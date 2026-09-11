-- Bookings & Capacity migration.

-- Booking status enum matching the backend state machine (§12).
do $$
begin
  if not exists (select 1 from pg_type where typname = 'booking_status') then
    create type public.booking_status as enum (
      'draft',
      'pending_payment',
      'confirmed',
      'dispatching',
      'assigned',
      'en_route',
      'arrived',
      'in_service',
      'quality_review',
      'completed',
      'cancelled',
      'disputed',
      'resolved'
    );
  end if;
end $$;

-- Bookings table.
create table if not exists public.bookings (
  id              uuid primary key default gen_random_uuid(),
  customer_id     uuid not null references auth.users(id),
  vehicle_id      uuid not null references public.vehicles(id),
  address_id      uuid not null references public.addresses(id),
  zone_id         uuid not null references public.zones(id),
  status          public.booking_status not null default 'confirmed',
  slot_start      timestamptz not null,
  slot_end        timestamptz not null,
  total_minor     int not null check (total_minor >= 0),
  currency        text not null default 'EGP',
  payment_method  text not null default 'cash',
  idempotency_key text not null unique,
  version         int not null default 1,
  created_at      timestamptz not null default now()
);

comment on table public.bookings is 'Customer bookings with frozen snapshots and server state machine.';

-- Booking items (frozen price snapshots).
create table if not exists public.booking_items (
  id               uuid primary key default gen_random_uuid(),
  booking_id       uuid not null references public.bookings(id) on delete cascade,
  item_type        text not null check (item_type in ('service', 'addon')),
  name_snapshot    text not null,
  price_minor      int not null check (price_minor >= 0),
  duration_minutes int not null default 0
);

comment on table public.booking_items is 'Frozen line items snapshot per booking.';

-- Indexes for performance.
create index if not exists idx_bookings_customer on public.bookings (customer_id);
create index if not exists idx_bookings_status on public.bookings (status);
create index if not exists idx_bookings_slot on public.bookings (slot_start, slot_end);
create index if not exists idx_booking_items_booking on public.booking_items (booking_id);

-- RLS: customers see only their own bookings and items.
alter table public.bookings enable row level security;
alter table public.booking_items enable row level security;

drop policy if exists "Customer reads own bookings" on public.bookings;
create policy "Customer reads own bookings"
  on public.bookings for select to authenticated
  using (customer_id = auth.uid());

drop policy if exists "Customer reads own booking items" on public.booking_items;
create policy "Customer reads own booking items"
  on public.booking_items for select to authenticated
  using (booking_id in (
    select id from public.bookings where customer_id = auth.uid()
  ));

-- RPC: create_booking (idempotent, atomic with items snapshot)
create or replace function public.create_booking(
  p_vehicle_id      uuid,
  p_address_id      uuid,
  p_zone_id         uuid,
  p_slot_start      timestamptz,
  p_slot_end        timestamptz,
  p_total_minor     int,
  p_payment_method  text,
  p_idempotency_key text,
  p_items           jsonb
)
returns jsonb
language plpgsql
security definer
as $$
declare
  v_customer_id uuid := auth.uid();
  v_booking     record;
  v_item        jsonb;
  v_items_list  jsonb := '[]'::jsonb;
begin
  if v_customer_id is null then
    raise exception 'Not authenticated' using errcode = '401';
  end if;

  -- Check idempotency: return existing booking if key already processed.
  select b.* into v_booking
  from public.bookings b
  where b.idempotency_key = p_idempotency_key;

  if found then
    select jsonb_agg(
      jsonb_build_object(
        'id', bi.id,
        'item_type', bi.item_type,
        'name_snapshot', bi.name_snapshot,
        'price_minor', bi.price_minor,
        'duration_minutes', bi.duration_minutes
      )
    ) into v_items_list
    from public.booking_items bi
    where bi.booking_id = v_booking.id;

    return jsonb_build_object(
      'id', v_booking.id,
      'status', v_booking.status,
      'slot_start', v_booking.slot_start,
      'slot_end', v_booking.slot_end,
      'total_minor', v_booking.total_minor,
      'currency', v_booking.currency,
      'payment_method', v_booking.payment_method,
      'created_at', v_booking.created_at,
      'items', coalesce(v_items_list, '[]'::jsonb)
    );
  end if;

  -- Insert new booking.
  insert into public.bookings (
    customer_id,
    vehicle_id,
    address_id,
    zone_id,
    status,
    slot_start,
    slot_end,
    total_minor,
    payment_method,
    idempotency_key
  ) values (
    v_customer_id,
    p_vehicle_id,
    p_address_id,
    p_zone_id,
    'confirmed',
    p_slot_start,
    p_slot_end,
    p_total_minor,
    p_payment_method,
    p_idempotency_key
  )
  returning * into v_booking;

  -- Insert snapshot items.
  for v_item in select * from jsonb_array_elements(p_items)
  loop
    insert into public.booking_items (
      booking_id,
      item_type,
      name_snapshot,
      price_minor,
      duration_minutes
    ) values (
      v_booking.id,
      v_item->>'item_type',
      v_item->>'name_snapshot',
      (v_item->>'price_minor')::int,
      coalesce((v_item->>'duration_minutes')::int, 0)
    );
  end loop;

  select jsonb_agg(
    jsonb_build_object(
      'id', bi.id,
      'item_type', bi.item_type,
      'name_snapshot', bi.name_snapshot,
      'price_minor', bi.price_minor,
      'duration_minutes', bi.duration_minutes
    )
  ) into v_items_list
  from public.booking_items bi
  where bi.booking_id = v_booking.id;

  return jsonb_build_object(
    'id', v_booking.id,
    'status', v_booking.status,
    'slot_start', v_booking.slot_start,
    'slot_end', v_booking.slot_end,
    'total_minor', v_booking.total_minor,
    'currency', v_booking.currency,
    'payment_method', v_booking.payment_method,
    'created_at', v_booking.created_at,
    'items', coalesce(v_items_list, '[]'::jsonb)
  );
end;
$$;

-- RPC: get_available_slots (returns slots for a zone on a given date)
create or replace function public.get_available_slots(
  p_zone_id uuid,
  p_date    date
)
returns table (
  slot_start timestamptz,
  slot_end   timestamptz,
  available  boolean
)
language plpgsql
security definer
as $$
declare
  v_hours int[] := array[9, 11, 13, 15, 17, 19];
  v_hour  int;
  v_start timestamptz;
  v_end   timestamptz;
begin
  foreach v_hour in array v_hours
  loop
    v_start := (p_date + (v_hour || ' hours')::interval) at time zone 'Africa/Cairo';
    v_end   := (p_date + ((v_hour + 2) || ' hours')::interval) at time zone 'Africa/Cairo';
    slot_start := v_start;
    slot_end   := v_end;
    available  := true;
    return next;
  end loop;
end;
$$;
