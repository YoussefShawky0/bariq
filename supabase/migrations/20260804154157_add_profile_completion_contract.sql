alter table public.profiles
  add column terms_version text,
  add column terms_accepted_at timestamptz;

alter table public.profiles
  add constraint profiles_terms_version_length check (
    terms_version is null or char_length(terms_version) between 1 and 40
  ),
  add constraint profiles_terms_acceptance_pair check (
    (terms_version is null and terms_accepted_at is null)
    or (terms_version is not null and terms_accepted_at is not null)
  );

comment on column public.profiles.terms_version is
  'Version of the customer terms accepted during profile completion.';
comment on column public.profiles.terms_accepted_at is
  'UTC timestamp for the current terms acceptance.';

-- Existing profiles must pass through the new terms gate as well.
update public.profiles
set completed_at = null
where terms_version is null;

create or replace function public.prepare_customer_profile()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.full_name = nullif(btrim(new.full_name), '');
  new.phone = nullif(btrim(new.phone), '');
  new.city = nullif(btrim(new.city), '');
  new.area = nullif(btrim(new.area), '');
  new.updated_at = timezone('utc', now());

  if new.terms_version is not null then
    if tg_op = 'INSERT'
      or old.terms_version is distinct from new.terms_version
      or old.terms_accepted_at is null then
      new.terms_accepted_at = timezone('utc', now());
    else
      new.terms_accepted_at = old.terms_accepted_at;
    end if;
  else
    new.terms_accepted_at = null;
  end if;

  if new.full_name is not null
    and new.terms_version is not null
    and new.terms_accepted_at is not null then
    if tg_op = 'UPDATE' then
      new.completed_at = coalesce(old.completed_at, timezone('utc', now()));
    else
      new.completed_at = timezone('utc', now());
    end if;
  else
    new.completed_at = null;
  end if;

  return new;
end;
$$;

revoke all on function public.prepare_customer_profile() from public, anon, authenticated;

create trigger prepare_customer_profile_before_write
before insert or update on public.profiles
for each row execute function public.prepare_customer_profile();

insert into storage.buckets (
  id,
  name,
  public,
  file_size_limit,
  allowed_mime_types
)
values (
  'profile-avatars',
  'profile-avatars',
  false,
  2097152,
  array['image/jpeg', 'image/png', 'image/webp']
)
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

create policy "Customers can read their own profile avatars"
on storage.objects
for select
to authenticated
using (
  bucket_id = 'profile-avatars'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

create policy "Customers can upload their own profile avatars"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'profile-avatars'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

create policy "Customers can replace their own profile avatars"
on storage.objects
for update
to authenticated
using (
  bucket_id = 'profile-avatars'
  and (storage.foldername(name))[1] = (select auth.uid())::text
)
with check (
  bucket_id = 'profile-avatars'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

create policy "Customers can delete their own profile avatars"
on storage.objects
for delete
to authenticated
using (
  bucket_id = 'profile-avatars'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);
