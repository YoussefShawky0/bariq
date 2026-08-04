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
- Configure Google OAuth for the Android application and add every required
  development/production redirect URI before enabling the Google button.
- Collect phone numbers in E.164 format, for example `+20...` for Egypt, but do
  not label them verified while SMS verification is intentionally disabled.
- Add Android application ID `com.youssefshawky.bariq` to integration settings
  that require the mobile identity.
- Use migrations for schema changes.
- Enable RLS and add ownership/role policies before exposing each table.
- Verify Data API grants because new tables may not be automatically exposed.
- Run database advisors and RLS tests before merging schema changes.

## Current Boundary

This foundation initializes Supabase only when valid local configuration exists
and lets App Startup read the Supabase Auth session. Email/password and Google
OAuth screens, schema,
profiles, vehicles, addresses, and booking tables belong to their own feature
branches and migrations.
