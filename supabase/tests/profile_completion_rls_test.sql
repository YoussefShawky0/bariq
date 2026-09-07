begin;
set local role postgres;
create extension if not exists pgtap with schema extensions;
set local search_path = public, extensions, pgtap;
select plan(11);

insert into auth.users (id, email)
values
  ('11111111-1111-4111-8111-111111111111', 'customer-one@example.com'),
  ('22222222-2222-4222-8222-222222222222', 'customer-two@example.com'),
  ('33333333-3333-4333-8333-333333333333', 'customer-three@example.com');

insert into public.profiles (id, full_name, terms_version)
values (
  '22222222-2222-4222-8222-222222222222',
  'Customer Two',
  '2026-08'
);

select ok(
  (
    select relrowsecurity
    from pg_class
    where oid = 'public.profiles'::regclass
  ),
  'profiles has row level security enabled'
);

set local role authenticated;
set local request.jwt.claim.sub = '11111111-1111-4111-8111-111111111111';

select lives_ok(
  $$
    insert into public.profiles (id, full_name, terms_version)
    values (
      '11111111-1111-4111-8111-111111111111',
      'Customer One',
      '2026-08'
    )
  $$,
  'a customer can create their own profile'
);

select results_eq(
  $$select count(*) from public.profiles$$,
  array[1::bigint],
  'a customer can only read their own profile'
);

select lives_ok(
  $$
    update public.profiles
    set city = 'القاهرة'
    where id = '11111111-1111-4111-8111-111111111111'
  $$,
  'a customer can update their own profile'
);

select is_empty(
  $$
    update public.profiles
    set city = 'Hacked'
    where id = '22222222-2222-4222-8222-222222222222'
    returning id
  $$,
  'a customer cannot update another profile'
);

select throws_ok(
  $$
    insert into public.profiles (id, full_name, terms_version)
    values (
      '33333333-3333-4333-8333-333333333333',
      'Invalid Owner',
      '2026-08'
    )
  $$,
  '42501',
  'new row violates row-level security policy for table "profiles"',
  'a customer cannot create a profile for another id'
);

select results_eq(
  $$
    select completed_at is not null
    from public.profiles
    where id = '11111111-1111-4111-8111-111111111111'
  $$,
  array[true],
  'completed_at is derived by the database trigger'
);

select lives_ok(
  $$
    update public.profiles
    set phone = '+201112345678', city = 'القاهرة'
    where id = '11111111-1111-4111-8111-111111111111'
  $$,
  'canonical Egyptian mobile and governorate values are accepted'
);

select throws_ok(
  $$
    update public.profiles
    set phone = '+971501234567'
    where id = '11111111-1111-4111-8111-111111111111'
  $$,
  '23514',
  'new row for relation "profiles" violates check constraint "profiles_egyptian_mobile_check"',
  'non-Egyptian mobile numbers are rejected'
);

select throws_ok(
  $$
    update public.profiles
    set city = 'Dubai'
    where id = '11111111-1111-4111-8111-111111111111'
  $$,
  '23514',
  'new row for relation "profiles" violates check constraint "profiles_egypt_governorate_check"',
  'non-Egyptian governorates are rejected'
);

reset role;
set local role postgres;

select results_eq(
  $$
    select count(*)
    from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname like 'Customers can % their own profile avatars'
  $$,
  array[4::bigint],
  'profile avatars define four ownership policies'
);

select * from finish();
rollback;
