create table public.vehicles (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references auth.users(id) on delete cascade,
  make text not null,
  model text not null,
  year smallint not null,
  color text not null,
  plate_number text not null,
  vehicle_class text not null,
  is_default boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint vehicles_make_length check (char_length(make) between 2 and 50),
  constraint vehicles_model_length check (char_length(model) between 1 and 50),
  constraint vehicles_year_range check (year between 1950 and 2100),
  constraint vehicles_color_length check (char_length(color) between 2 and 30),
  constraint vehicles_plate_length check (char_length(plate_number) between 2 and 20),
  constraint vehicles_class_allowed check (
    vehicle_class in ('sedan', 'suv', 'hatchback', 'pickup', 'van')
  )
);

comment on table public.vehicles is
  'Customer-owned vehicles used for service pricing and booking operations.';
comment on column public.vehicles.plate_number is
  'Operational vehicle identifier; it is not a verified licence document.';

create index vehicles_customer_id_idx
on public.vehicles (customer_id);

create unique index vehicles_one_default_per_customer_idx
on public.vehicles (customer_id)
where is_default;

create unique index vehicles_customer_plate_key_idx
on public.vehicles (
  customer_id,
  lower(regexp_replace(plate_number, '[[:space:]-]+', '', 'g'))
);

create or replace function public.prepare_customer_vehicle()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.make = btrim(new.make);
  new.model = btrim(new.model);
  new.color = btrim(new.color);
  new.plate_number = regexp_replace(btrim(new.plate_number), '[[:space:]]+', ' ', 'g');
  new.updated_at = now();
  return new;
end;
$$;

revoke all on function public.prepare_customer_vehicle()
from public, anon, authenticated;

create trigger prepare_customer_vehicle_before_write
before insert or update on public.vehicles
for each row execute function public.prepare_customer_vehicle();

alter table public.vehicles enable row level security;

revoke all on table public.vehicles from public, anon, authenticated;
grant select on table public.vehicles to authenticated;

create policy "Customers can read their own vehicles"
on public.vehicles
for select
to authenticated
using ((select auth.uid()) = customer_id);

create policy "Customers can create their own vehicles"
on public.vehicles
for insert
to authenticated
with check ((select auth.uid()) = customer_id);

create policy "Customers can update their own vehicles"
on public.vehicles
for update
to authenticated
using ((select auth.uid()) = customer_id)
with check ((select auth.uid()) = customer_id);

create policy "Customers can delete their own vehicles"
on public.vehicles
for delete
to authenticated
using ((select auth.uid()) = customer_id);

create or replace function public.save_my_vehicle(
  p_vehicle_id uuid,
  p_make text,
  p_model text,
  p_year smallint,
  p_color text,
  p_plate_number text,
  p_vehicle_class text,
  p_is_default boolean default false
)
returns public.vehicles
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_customer_id uuid := auth.uid();
  v_existing public.vehicles%rowtype;
  v_saved public.vehicles%rowtype;
  v_is_default boolean;
begin
  if v_customer_id is null then
    raise exception using errcode = '42501', message = 'AUTHENTICATION_REQUIRED';
  end if;

  perform pg_advisory_xact_lock(hashtextextended(v_customer_id::text, 0));

  if p_vehicle_id is null then
    v_is_default := coalesce(p_is_default, false) or not exists (
      select 1
      from public.vehicles
      where customer_id = v_customer_id
        and is_default
    );

    if v_is_default then
      update public.vehicles
      set is_default = false
      where customer_id = v_customer_id
        and is_default;
    end if;

    insert into public.vehicles (
      customer_id,
      make,
      model,
      year,
      color,
      plate_number,
      vehicle_class,
      is_default
    ) values (
      v_customer_id,
      p_make,
      p_model,
      p_year,
      p_color,
      p_plate_number,
      p_vehicle_class,
      v_is_default
    )
    returning * into v_saved;

    return v_saved;
  end if;

  select *
  into v_existing
  from public.vehicles
  where id = p_vehicle_id
    and customer_id = v_customer_id;

  if not found then
    raise exception using errcode = 'P0002', message = 'VEHICLE_NOT_FOUND';
  end if;

  v_is_default := coalesce(p_is_default, false) or v_existing.is_default;

  if coalesce(p_is_default, false) then
    update public.vehicles
    set is_default = false
    where customer_id = v_customer_id
      and is_default;
  end if;

  update public.vehicles
  set make = p_make,
      model = p_model,
      year = p_year,
      color = p_color,
      plate_number = p_plate_number,
      vehicle_class = p_vehicle_class,
      is_default = v_is_default
  where id = p_vehicle_id
    and customer_id = v_customer_id
  returning * into v_saved;

  return v_saved;
end;
$$;

revoke all on function public.save_my_vehicle(
  uuid, text, text, smallint, text, text, text, boolean
) from public, anon, authenticated;
grant execute on function public.save_my_vehicle(
  uuid, text, text, smallint, text, text, text, boolean
) to authenticated;

create or replace function public.delete_my_vehicle(p_vehicle_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_customer_id uuid := auth.uid();
  v_was_default boolean;
begin
  if v_customer_id is null then
    raise exception using errcode = '42501', message = 'AUTHENTICATION_REQUIRED';
  end if;

  perform pg_advisory_xact_lock(hashtextextended(v_customer_id::text, 0));

  select is_default
  into v_was_default
  from public.vehicles
  where id = p_vehicle_id
    and customer_id = v_customer_id;

  if not found then
    raise exception using errcode = 'P0002', message = 'VEHICLE_NOT_FOUND';
  end if;

  delete from public.vehicles
  where id = p_vehicle_id
    and customer_id = v_customer_id;

  if v_was_default then
    update public.vehicles
    set is_default = true
    where id = (
      select id
      from public.vehicles
      where customer_id = v_customer_id
      order by created_at, id
      limit 1
    );
  end if;
end;
$$;

revoke all on function public.delete_my_vehicle(uuid)
from public, anon, authenticated;
grant execute on function public.delete_my_vehicle(uuid) to authenticated;
