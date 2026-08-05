# ADR 0003 — Customer Profile Completion Contract

- Status: Accepted
- Date: 2026-08-04

## Context

The product plan lists name, phone, city, area, avatar, and terms acceptance on
the profile-completion screen. ADR 0002 deliberately requires phone and
location details only before the first booking, while the first-login gate must
still prevent anonymous-looking customer records and record terms acceptance.

## Decision

- The first-login gate is complete when `full_name` is valid and the current
  terms version has been accepted.
- Phone, governorate, and area are offered during completion but remain
  optional until the first booking. Phone input is Egypt-only and canonicalized
  to E.164; governorate is restricted to Egypt's 27 governorates.
- Avatar upload is optional. Files live in the private `profile-avatars` bucket
  under a user-owned path, are limited to 2 MiB, and support JPEG, PNG, or WebP.
- Flutter reads avatar files through short-lived signed URLs without paid image
  transformations.
- Flutter performs a local 1:1 crop before upload so customers control the
  visible avatar framing without paid server transformations.
- PostgreSQL derives `completed_at`; the mobile client cannot mark a profile
  complete by writing that field directly.

## Security

- Profile rows continue to use `id = auth.uid()` ownership RLS.
- Storage policies restrict select, insert, update, and delete to the first path
  segment matching `auth.uid()`.
- Upsert access includes the select, insert, and update policies required by
  Supabase Storage and PostgREST.
- Terms acceptance is versioned and timestamped. A later legal workflow can
  move immutable acceptance history to a dedicated audit table if needed.

## Consequences

- New customers reach Home after one required identity field and explicit
  consent instead of being blocked by booking-only data.
- Customers can prefill booking data and an avatar without being forced to do
  so during onboarding.
- Vehicles, addresses, phone verification, and full legal-document management
  remain outside this feature.
