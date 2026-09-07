-- Zones for service coverage areas.
-- PostGIS is enabled; geometry stores approximate bounding-box polygons.

create table if not exists public.zones (
  id          uuid primary key default gen_random_uuid(),
  code        text not null unique,
  name_ar     text not null,
  name_en     text not null,
  geometry    geography(Polygon, 4326),
  active      boolean not null default true,
  created_at  timestamptz not null default now()
);

comment on table public.zones is 'Service coverage zones with PostGIS polygons.';

-- RLS: authenticated users can read active zones.
alter table public.zones enable row level security;

drop policy if exists "Authenticated users can read active zones" on public.zones;
create policy "Authenticated users can read active zones"
  on public.zones for select
  to authenticated
  using (active = true);

-- Seed 3 Egyptian zones with approximate bounding-box polygons (idempotent).
insert into public.zones (code, name_ar, name_en, geometry) values
  (
    'cairo',
    'القاهرة',
    'Cairo',
    ST_GeogFromText('POLYGON((31.18 29.95, 31.42 29.95, 31.42 30.15, 31.18 30.15, 31.18 29.95))')
  ),
  (
    'giza',
    'الجيزة',
    'Giza',
    ST_GeogFromText('POLYGON((31.10 29.95, 31.25 29.95, 31.25 30.10, 31.10 30.10, 31.10 29.95))')
  ),
  (
    'sheikh_zayed',
    'الشيخ زايد',
    'Sheikh Zayed',
    ST_GeogFromText('POLYGON((30.95 30.00, 31.10 30.00, 31.10 30.10, 30.95 30.10, 30.95 30.00))')
  )
on conflict (code) do update set
  name_ar = excluded.name_ar,
  name_en = excluded.name_en,
  geometry = excluded.geometry,
  active = excluded.active;
