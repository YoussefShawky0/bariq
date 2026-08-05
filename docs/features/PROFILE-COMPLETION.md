# BARIQ — Customer Profile Completion

## User Story

As an authenticated customer, I want to add the minimum personal details BARIQ
needs so I can reach Home and prepare for my first booking without uploading
identity documents.

## Acceptance Criteria

- An authenticated user with no completed profile is routed to Profile
  Completion before Home.
- Existing partial data is loaded and can be retried after a safe failure.
- Full name is required and contains 2–100 trimmed characters.
- Accepting the current terms version is required.
- Phone is optional at this stage. The UI keeps `+20` fixed, accepts an
  Egyptian mobile with or without the local leading zero, and stores canonical
  E.164 such as `+201112345678`.
- Governorate and area are optional at this stage. Governorate is selected from
  Egypt's 27 governorates; area contains 2–80 trimmed characters when entered.
- Legacy free-text city values remain readable until the customer next saves
  the profile; all new and updated rows enforce the governorate list.
- Avatar is optional, private, no larger than 2 MiB, and JPEG/PNG/WebP only.
- A selected avatar is cropped to a user-positioned 1:1 frame before upload.
- A successful save refreshes startup routing and opens Home.
- Loading, validation, backend, offline, and success states are explicit.
- The flow is RTL, accessible, scroll-safe, and tested on small phone and tablet.
- Customer national ID, driving licence, and vehicle licence are not collected.

## Backend Contract

- Table: `public.profiles`
- Owner: `profiles.id = auth.uid()`
- Data API role: `authenticated` with select/insert/update plus ownership RLS
- Completion source of truth: server-derived `completed_at`
- Avatar bucket: private `profile-avatars/<auth.uid()>/...`
- Terms version for this release: `2026-08`

## Out of Scope

- Phone OTP verification
- Vehicle and address CRUD
- Booking-readiness enforcement
- Profile editing from the future account screen
- Legal-document version history and identity-document upload
