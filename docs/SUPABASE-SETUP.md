# BARIQ — Supabase Setup

## Local Flutter Configuration

1. Copy `.env.example` to `.env`.
2. Add the project URL and **publishable** key:

```dotenv
SUPABASE_URL=https://your-project-ref.supabase.co
SUPABASE_PUBLISHABLE_KEY=sb_publishable_your_key
```

3. Run `flutter pub get` and start the app normally.

The app can start with both values empty while the backend project is not yet
created. Providing only one value fails fast so a partially configured client
cannot silently reach the wrong environment.

Never place a secret key or `service_role` key in this file. `.env` is ignored
by Git. CI copies `.env.example` to `.env` so analysis, tests, and debug builds
remain deterministic without production credentials.

## Project Setup Checklist

- Create a dedicated Supabase project for BARIQ; do not reuse an unrelated
  project.
- Keep development and production as separate environments before real user
  data is collected.
- Keep Email/Password enabled and use the default confirmation/reset email
  templates while the project remains on the free plan.
- Create a Google OAuth **Web application** client. In Google Cloud, add
  `https://<project-ref>.supabase.co/auth/v1/callback` as an authorized redirect
  URI, then put that client ID and secret in the Supabase Google provider.
- In **Authentication > URL Configuration**, add this exact mobile redirect:
  `com.youssefshawky.bariq://login-callback/`.
- In **Authentication > Providers > Google**, enable Google only after adding
  the Web client ID and secret. Those provider credentials never belong in
  Flutter. Keep Email/Password enabled and turn on email confirmation.
- Collect phone numbers in E.164 format, for example `+20...` for Egypt, but do
  not label them verified while SMS verification is intentionally disabled.
- Add Android application ID `com.youssefshawky.bariq` to integration settings
  that require the mobile identity.
- Use migrations for schema changes.
- Enable RLS and add ownership/role policies before exposing each table.
- Verify Data API grants because new tables may not be automatically exposed.
- Run database advisors and RLS tests before merging schema changes.

## Current Boundary

The customer authentication slice supports email/password, confirmation/reset
links, and browser-based Google OAuth. The mobile callback is registered on
Android and iOS. The `profiles` migration grants only authenticated
select/insert/update access and combines those grants with ownership RLS.

The profile-completion UI, vehicles, addresses, and booking tables remain
separate feature slices. Do not apply this migration to an unrelated Supabase
project.
