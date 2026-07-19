# ADR-002: RPC-only public write path

**Status:** Accepted · **Date:** 2026-07-18 (formalizes 2026-07-07 design)

## Context
Supabase exposes tables via PostgREST. Early versions allowed anon INSERT policies;
advisors flag `WITH CHECK (true)` policies, and raw inserts bypass validation.

## Decision
All public writes go through SECURITY DEFINER RPCs (`upsert_lead`,
`submit_partner_application`, `refer_restaurant` once applied) that validate input,
enforce first-touch attribution, and inherit trigger-level IP rate limiting. Raw anon
write policies are dropped (`harden_public_write_paths` migration). People-data tables
have no public read policies; reads happen via per-record access-token RPCs
(magic-link pattern) or the bcrypt-token admin RPCs.

## Consequences
- (+) Single validated, rate-limited, evolvable entry point per operation.
- (+) Schema can change without breaking clients (RPC is the contract).
- (−) Each new public operation requires a migration, not just a policy. Intended friction.
- Before Gate C: replace token patterns with Supabase Auth + RBAC (delta report §0.5-G).
