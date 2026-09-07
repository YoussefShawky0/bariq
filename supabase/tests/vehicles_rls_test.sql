begin;
set local role postgres;
create extension if not exists pgtap with schema extensions;
set local search_path = public, extensions, pgtap;
select plan(14);

insert into auth.users (id, email)
values
  ('11111111-1111-4111-8111-111111111111', 'vehicle-one@example.com'),
  ('22222222-2222-4222-8222-222222222222', 'vehicle-two@example.com');

insert into public.vehicles (
  customer_id, make, model, year, color, plate_number, vehicle_class, is_default
) values (
  '22222222-2222-4222-8222-222222222222',
  'Kia', 'Cerato', 2021, 'Black', 'ط س ن ٩٩٩', 'sedan', true
);

select ok(
  (
    select relrowsecurity
    from pg_class
    where oid = 'public.vehicles'::regclass
  ),
  'vehicles has row level security enabled'
);

select ok(
  has_table_privilege('authenticated', 'public.vehicles', 'SELECT'),
  'authenticated customers can select vehicles'
);

select ok(
  not has_table_privilege('authenticated', 'public.vehicles', 'INSERT')
    and not has_table_privilege('authenticated', 'public.vehicles', 'UPDATE')
    and not has_table_privilege('authenticated', 'public.vehicles', 'DELETE'),
  'direct vehicle mutations are not granted to the client'
);

select ok(
  not has_function_privilege(
    'anon',
    'public.save_my_vehicle(uuid,text,text,smallint,text,text,text,boolean)',
    'EXECUTE'
  ),
  'anonymous users cannot execute the save RPC'
);

set local role authenticated;
set local request.jwt.claim.sub = '11111111-1111-4111-8111-111111111111';

select lives_ok(
  $$
    select public.save_my_vehicle(
      null, 'Toyota', 'Corolla', 2022::smallint, 'White',
      'أ ب ج ١٢٣', 'sedan', false
    )
  $$,
  'a customer can create an owned vehicle through the RPC'
);

select results_eq(
  $$select count(*) from public.vehicles$$,
  array[1::bigint],
  'a customer can only read their own vehicles'
);

select results_eq(
  $$select is_default from public.vehicles$$,
  array[true],
  'the first vehicle becomes default automatically'
);

select throws_ok(
  $$
    insert into public.vehicles (
      customer_id, make, model, year, color, plate_number, vehicle_class
    ) values (
      '11111111-1111-4111-8111-111111111111',
      'Ford', 'Focus', 2020, 'Blue', 'أ ب ١', 'sedan'
    )
  $$,
  '42501',
  'permission denied for table vehicles',
  'direct inserts are denied'
);

select lives_ok(
  $$
    select public.save_my_vehicle(
      null, 'Hyundai', 'Tucson', 2024::smallint, 'Gray',
      'س ص ع ٤٥٦', 'suv', false
    )
  $$,
  'a customer can add a second vehicle'
);

select lives_ok(
  $$
    select public.save_my_vehicle(
      (select id from public.vehicles where model = 'Tucson'),
      'Hyundai', 'Tucson', 2024::smallint, 'Gray',
      'س ص ع ٤٥٦', 'suv', true
    )
  $$,
  'a customer can switch the default vehicle atomically'
);

select results_eq(
  $$select count(*) from public.vehicles where is_default$$,
  array[1::bigint],
  'a customer has exactly one default vehicle after switching'
);

select lives_ok(
  $$
    select public.delete_my_vehicle(
      (select id from public.vehicles where model = 'Tucson')
    )
  $$,
  'a customer can delete their default vehicle through the RPC'
);

select results_eq(
  $$select model, is_default from public.vehicles$$,
  $$values ('Corolla'::text, true)$$,
  'deleting the default promotes the oldest remaining vehicle'
);

do $$
declare
  v_vehicle_id text;
begin
  select id::text
  into v_vehicle_id
  from public.vehicles
  where model = 'Corolla';
  perform set_config('test.customer_one_vehicle_id', v_vehicle_id, true);
end;
$$;

set local request.jwt.claim.sub = '22222222-2222-4222-8222-222222222222';

select throws_ok(
  $$
    select public.delete_my_vehicle(
      current_setting('test.customer_one_vehicle_id')::uuid
    )
  $$,
  'P0002',
  'VEHICLE_NOT_FOUND',
  'a customer cannot mutate another customer vehicle'
);

reset role;
set local role postgres;
select * from finish();
rollback;
