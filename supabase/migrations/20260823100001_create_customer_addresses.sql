-- Customer saved addresses with zone association and readiness checklist.

create table if not exists public.addresses (
  id            uuid primary key default gen_random_uuid(),
  customer_id   uuid not null references auth.users(id) on delete cascade,
  zone_id       uuid not null references public.zones(id),
  point         geography(Point, 4326),
  label         text not null,
  street        text not null,
  building      text,
  floor         text,
  apartment     text,
  access_notes  text,
  readiness     jsonb not null default '{}'::jsonb,
  is_default    boolean not null default false,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

comment on table public.addresses is 'Customer saved addresses for service delivery.';

-- Indexes (idempotent).
create index if not exists idx_addresses_customer on public.addresses(customer_id);

-- Max 10 addresses per customer.
create or replace function public.check_address_limit()
returns trigger as $$
begin
  if (select count(*) from public.addresses where customer_id = NEW.customer_id) >= 10 then
    raise exception 'Maximum 10 addresses allowed per customer.'
      using errcode = 'check_violation';
  end if;
  return NEW;
end;
$$ language plpgsql security definer;

drop trigger if exists trg_address_limit on public.addresses;
create trigger trg_address_limit
  before insert on public.addresses
  for each row execute function public.check_address_limit();

-- Server-authoritative default: exactly one default address per customer.
create or replace function public.enforce_single_default_address()
returns trigger as $$
begin
  if NEW.is_default = true then
    update public.addresses
      set is_default = false
      where customer_id = NEW.customer_id
        and id != NEW.id
        and is_default = true;
  end if;

  -- Auto-set first address as default.
  if not exists (
    select 1 from public.addresses
    where customer_id = NEW.customer_id
      and is_default = true
      and id != NEW.id
  ) then
    NEW.is_default := true;
  end if;

  return NEW;
end;
$$ language plpgsql security definer;

drop trigger if exists trg_enforce_single_default_address on public.addresses;
create trigger trg_enforce_single_default_address
  before insert or update on public.addresses
  for each row execute function public.enforce_single_default_address();

-- After delete: promote another address to default if the deleted one was default.
create or replace function public.promote_default_address_after_delete()
returns trigger as $$
begin
  if OLD.is_default = true then
    update public.addresses
      set is_default = true
      where id = (
        select id from public.addresses
        where customer_id = OLD.customer_id
          and id != OLD.id
        order by created_at asc
        limit 1
      );
  end if;
  return OLD;
end;
$$ language plpgsql security definer;

drop trigger if exists trg_promote_default_address_after_delete on public.addresses;
create trigger trg_promote_default_address_after_delete
  after delete on public.addresses
  for each row execute function public.promote_default_address_after_delete();

-- Updated_at auto-update.
create or replace function public.update_address_timestamp()
returns trigger as $$
begin
  NEW.updated_at := now();
  return NEW;
end;
$$ language plpgsql;

drop trigger if exists trg_update_address_timestamp on public.addresses;
create trigger trg_update_address_timestamp
  before update on public.addresses
  for each row execute function public.update_address_timestamp();

-- RLS: customer owns their addresses only.
alter table public.addresses enable row level security;

drop policy if exists "Customers can read own addresses" on public.addresses;
create policy "Customers can read own addresses"
  on public.addresses for select
  to authenticated
  using (customer_id = auth.uid());

drop policy if exists "Customers can insert own addresses" on public.addresses;
create policy "Customers can insert own addresses"
  on public.addresses for insert
  to authenticated
  with check (customer_id = auth.uid());

drop policy if exists "Customers can update own addresses" on public.addresses;
create policy "Customers can update own addresses"
  on public.addresses for update
  to authenticated
  using (customer_id = auth.uid())
  with check (customer_id = auth.uid());

drop policy if exists "Customers can delete own addresses" on public.addresses;
create policy "Customers can delete own addresses"
  on public.addresses for delete
  to authenticated
  using (customer_id = auth.uid());
