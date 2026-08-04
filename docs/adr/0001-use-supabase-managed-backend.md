# ADR 0001 — Use Supabase as the Managed Backend

- Status: Accepted
- Date: 2026-08-04
- Owner: BARIQ

## Context

BARIQ is being developed initially by one Flutter developer. Operating a custom
NestJS API, worker processes, Redis, PostgreSQL, object storage, authentication,
and realtime infrastructure would increase delivery time and operational risk
before the product validates demand.

The product still needs relational booking data, geospatial queries, secure
user-owned records, realtime status updates, evidence storage, and protected
server-side integrations.

## Decision

Use Supabase as the primary managed backend for the MVP:

- Supabase Auth for phone/OTP and session persistence.
- Supabase PostgreSQL with PostGIS for transactional and geospatial data.
- Supabase Data API and RPC for client-accessible operations.
- Supabase Realtime for booking and technician status updates.
- Supabase Storage for profile and service-evidence media.
- Supabase Edge Functions for payment webhooks, server secrets, notifications,
  and other privileged integrations.
- Firebase Cloud Messaging may be used only as the mobile push provider called
  from trusted backend code; Firebase is not a second application backend.

Flutter accesses Supabase only from feature Data layers through repository
implementations. UI and Domain code remain vendor-independent.

## Security Boundaries

- The Flutter app receives only the project URL and publishable key.
- Secret and `service_role` keys never enter Flutter, `.env`, or Git.
- RLS is enabled on every table in an exposed schema.
- Policies include ownership or explicit authorization predicates.
- Sensitive state transitions and payment operations run in SQL/RPC or Edge
  Functions, not as unrestricted table updates from clients.
- Schema changes are committed as migrations and checked with database advisors
  and RLS tests.

## Alternatives Considered

### Firebase as the primary backend

Rejected for the MVP because bookings, vehicles, addresses, pricing snapshots,
capacity, assignments, and payments form a strongly relational model. Firestore
would require more denormalization and application-side consistency work.

### NestJS modular monolith

Deferred. It offers maximum server control but introduces a separate language,
deployment, monitoring, queue, authentication, and infrastructure workload that
is not justified for a solo-developer MVP.

## Consequences

- Faster MVP delivery with fewer services to operate.
- PostgreSQL and RLS become core engineering skills for the project.
- Platform coupling is isolated behind repository and data-source boundaries.
- Phone OTP requires a configured SMS provider and carries provider cost.
- A custom API can be introduced later only if measured constraints justify it
  and a new ADR replaces this decision.
