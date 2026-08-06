# ADR 0004 — Server-Authoritative Vehicle Default

- Status: Accepted
- Date: 2026-08-05

## Context

The customer can own multiple vehicles, but a booking should start with one
predictable default. Separate mobile requests that unset one row and set another
can fail midway or race, leaving no default or more than one attempted default.
Ownership RLS alone does not protect this cross-row business invariant.

## Decision

- PostgreSQL is the source of truth for the default-vehicle invariant.
- A partial unique index limits every customer to at most one `is_default` row.
- The first inserted vehicle becomes default even when the client sends false.
- Setting a different default, saving a vehicle, and deleting a default happen
  through transaction-scoped RPCs serialized per customer.
- Deleting the default promotes the oldest remaining vehicle deterministically.
- Authenticated clients receive direct `SELECT` only. They cannot directly
  insert, update, or delete table rows and bypass the RPC contract.
- RPCs derive `customer_id` from `auth.uid()` and reject missing or foreign IDs.
- Flutter reloads the list after each mutation rather than predicting the
  cross-row result locally.

## Consequences

- Default switching remains consistent during retries and concurrent requests.
- Flutter has a simpler, server-authoritative state model.
- Vehicle mutations are intentionally coupled to the RPC contract and covered
  by pgTAP ownership/invariant tests.
- A future fleet workflow will need a new authorization contract instead of
  weakening customer ownership.
