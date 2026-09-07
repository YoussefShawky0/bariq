-- Service catalog: services, add-ons, and zone/vehicle-class pricing.

-- Services table.
create table if not exists public.services (
  id                    uuid primary key default gen_random_uuid(),
  code                  text not null unique,
  name_ar               text not null,
  name_en               text not null,
  description_ar        text not null default '',
  description_en        text not null default '',
  icon_name             text not null default 'local_car_wash',
  base_duration_minutes int not null,
  active                boolean not null default true,
  sort_order            int not null default 0,
  created_at            timestamptz not null default now()
);

comment on table public.services is 'Service catalog managed by operations.';

-- Service add-ons.
create table if not exists public.service_addons (
  id               uuid primary key default gen_random_uuid(),
  service_id       uuid not null references public.services(id) on delete cascade,
  name_ar          text not null,
  name_en          text not null,
  description_ar   text not null default '',
  price_minor      int not null,
  duration_minutes int not null default 0,
  active           boolean not null default true,
  sort_order       int not null default 0,
  created_at       timestamptz not null default now()
);

comment on table public.service_addons is 'Optional add-ons for each service.';

-- Pricing per zone + vehicle class.
create table if not exists public.service_zone_configs (
  id               uuid primary key default gen_random_uuid(),
  service_id       uuid not null references public.services(id) on delete cascade,
  zone_id          uuid not null references public.zones(id) on delete cascade,
  vehicle_class    text not null,
  price_minor      int not null,
  duration_minutes int not null,
  available        boolean not null default true,
  created_at       timestamptz not null default now(),
  unique (service_id, zone_id, vehicle_class)
);

comment on table public.service_zone_configs is 'Service pricing per zone and vehicle class.';

-- RLS: authenticated users can read active services and configs.
alter table public.services enable row level security;
alter table public.service_addons enable row level security;
alter table public.service_zone_configs enable row level security;

drop policy if exists "Read active services" on public.services;
create policy "Read active services"
  on public.services for select to authenticated
  using (active = true);

drop policy if exists "Read active addons" on public.service_addons;
create policy "Read active addons"
  on public.service_addons for select to authenticated
  using (active = true);

drop policy if exists "Read available configs" on public.service_zone_configs;
create policy "Read available configs"
  on public.service_zone_configs for select to authenticated
  using (available = true);

-- ── Seed 3 baseline services (idempotent) ──

insert into public.services (code, name_ar, name_en, description_ar, description_en, icon_name, base_duration_minutes, sort_order) values
  ('exterior_wash', 'غسيل خارجي', 'Exterior Wash',
   'غسيل خارجي شامل للجسم والإطارات والزجاج—بدون مياه من المحل.',
   'Full exterior wash including body, tires, and glass—no water needed from the customer.',
   'local_car_wash', 45, 1),
  ('full_detail', 'تلميع شامل', 'Full Detail',
   'تلميع وتنظيف عميق للطلاء الخارجي وحماية بطبقة شمعية.',
   'Deep polish and paint protection with a wax coating.',
   'auto_awesome', 90, 2),
  ('interior_clean', 'تنظيف داخلي', 'Interior Clean',
   'تنظيف شامل للمقاعد والتابلوه والأرضيات والسقف الداخلي.',
   'Complete interior cleaning of seats, dashboard, floors, and headliner.',
   'airline_seat_recline_extra', 60, 3)
on conflict (code) do update set
  name_ar = excluded.name_ar,
  name_en = excluded.name_en,
  description_ar = excluded.description_ar,
  description_en = excluded.description_en,
  icon_name = excluded.icon_name,
  base_duration_minutes = excluded.base_duration_minutes,
  sort_order = excluded.sort_order;

-- Seed pricing per zone/vehicle class (idempotent).
do $$
declare
  v_cairo_id   uuid;
  v_giza_id    uuid;
  v_zayed_id   uuid;
  v_ext_id     uuid;
  v_detail_id  uuid;
  v_int_id     uuid;
begin
  select id into v_cairo_id  from public.zones    where code = 'cairo';
  select id into v_giza_id   from public.zones    where code = 'giza';
  select id into v_zayed_id  from public.zones    where code = 'sheikh_zayed';
  select id into v_ext_id    from public.services where code = 'exterior_wash';
  select id into v_detail_id from public.services where code = 'full_detail';
  select id into v_int_id    from public.services where code = 'interior_clean';

  -- Exterior Wash pricing.
  insert into public.service_zone_configs (service_id, zone_id, vehicle_class, price_minor, duration_minutes) values
    (v_ext_id, v_cairo_id, 'sedan',       18000, 45),
    (v_ext_id, v_cairo_id, 'suv',         22000, 55),
    (v_ext_id, v_cairo_id, 'hatchback',   16000, 40),
    (v_ext_id, v_giza_id,  'sedan',       18000, 45),
    (v_ext_id, v_giza_id,  'suv',         22000, 55),
    (v_ext_id, v_giza_id,  'hatchback',   16000, 40),
    (v_ext_id, v_zayed_id, 'sedan',       20000, 45),
    (v_ext_id, v_zayed_id, 'suv',         25000, 55),
    (v_ext_id, v_zayed_id, 'hatchback',   18000, 40)
  on conflict (service_id, zone_id, vehicle_class) do update set
    price_minor = excluded.price_minor,
    duration_minutes = excluded.duration_minutes;

  -- Full Detail pricing.
  insert into public.service_zone_configs (service_id, zone_id, vehicle_class, price_minor, duration_minutes) values
    (v_detail_id, v_cairo_id, 'sedan',     32000, 90),
    (v_detail_id, v_cairo_id, 'suv',       40000, 110),
    (v_detail_id, v_cairo_id, 'hatchback', 28000, 80),
    (v_detail_id, v_giza_id,  'sedan',     32000, 90),
    (v_detail_id, v_giza_id,  'suv',       40000, 110),
    (v_detail_id, v_giza_id,  'hatchback', 28000, 80),
    (v_detail_id, v_zayed_id, 'sedan',     35000, 90),
    (v_detail_id, v_zayed_id, 'suv',       45000, 110),
    (v_detail_id, v_zayed_id, 'hatchback', 30000, 80)
  on conflict (service_id, zone_id, vehicle_class) do update set
    price_minor = excluded.price_minor,
    duration_minutes = excluded.duration_minutes;

  -- Interior Clean pricing.
  insert into public.service_zone_configs (service_id, zone_id, vehicle_class, price_minor, duration_minutes) values
    (v_int_id, v_cairo_id, 'sedan',       52000, 60),
    (v_int_id, v_cairo_id, 'suv',         60000, 75),
    (v_int_id, v_cairo_id, 'hatchback',   48000, 55),
    (v_int_id, v_giza_id,  'sedan',       52000, 60),
    (v_int_id, v_giza_id,  'suv',         60000, 75),
    (v_int_id, v_giza_id,  'hatchback',   48000, 55),
    (v_int_id, v_zayed_id, 'sedan',       55000, 60),
    (v_int_id, v_zayed_id, 'suv',         65000, 75),
    (v_int_id, v_zayed_id, 'hatchback',   50000, 55)
  on conflict (service_id, zone_id, vehicle_class) do update set
    price_minor = excluded.price_minor,
    duration_minutes = excluded.duration_minutes;
end $$;

-- Seed add-ons (idempotent).
do $$
declare
  v_ext_id    uuid;
  v_detail_id uuid;
  v_int_id    uuid;
begin
  select id into v_ext_id    from public.services where code = 'exterior_wash';
  select id into v_detail_id from public.services where code = 'full_detail';
  select id into v_int_id    from public.services where code = 'interior_clean';

  if not exists (select 1 from public.service_addons where service_id = v_ext_id) then
    insert into public.service_addons (service_id, name_ar, name_en, description_ar, price_minor, duration_minutes, sort_order) values
      (v_ext_id,    'تنظيف الجنوط',    'Rim Cleaning',       'تنظيف عميق للجنوط الألومنيوم.',       5000, 15, 1),
      (v_ext_id,    'تلميع الإطارات',  'Tire Shine',         'طبقة لمعان على الإطارات.',             3000, 10, 2);
  end if;

  if not exists (select 1 from public.service_addons where service_id = v_detail_id) then
    insert into public.service_addons (service_id, name_ar, name_en, description_ar, price_minor, duration_minutes, sort_order) values
      (v_detail_id, 'حماية سيراميك',   'Ceramic Coating',    'طبقة سيراميك لحماية إضافية.',          15000, 30, 1);
  end if;

  if not exists (select 1 from public.service_addons where service_id = v_int_id) then
    insert into public.service_addons (service_id, name_ar, name_en, description_ar, price_minor, duration_minutes, sort_order) values
      (v_int_id,    'تنظيف بالبخار',   'Steam Cleaning',     'تنظيف عميق بالبخار للمقاعد.',         10000, 20, 1),
      (v_int_id,    'معطر داخلي',      'Interior Fragrance', 'معطر يدوم طويلاً.',                    2000,  5, 2);
  end if;
end $$;
