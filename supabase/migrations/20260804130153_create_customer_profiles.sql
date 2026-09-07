create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  full_name text check (
    full_name is null or char_length(btrim(full_name)) between 2 and 100
  ),
  phone text check (
    phone is null or phone ~ '^\+[1-9][0-9]{7,14}$'
  ),
  city text check (
    city is null or char_length(btrim(city)) between 2 and 80
  ),
  area text check (
    area is null or char_length(btrim(area)) between 2 and 80
  ),
  avatar_path text,
  preferred_language text not null default 'ar' check (
    preferred_language in ('ar', 'en')
  ),
  completed_at timestamptz,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

comment on table public.profiles is
  'Customer-owned profile data. Vehicles and addresses are separate resources.';

alter table public.profiles enable row level security;

revoke all on table public.profiles from anon, authenticated;
grant select, insert, update on table public.profiles to authenticated;

create policy "Customers can read their own profile"
on public.profiles
for select
to authenticated
using ((select auth.uid()) = id);

create policy "Customers can create their own profile"
on public.profiles
for insert
to authenticated
with check ((select auth.uid()) = id);

create policy "Customers can update their own profile"
on public.profiles
for update
to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);
