# ADR-005: Consolidate on this repo; archive rocketplate-daily-delights

**Status:** Accepted · **Date:** 2026-07-19 (per the 13-agent consolidation audit, docs/audit/)

## Context
Two parallel implementations of RocketPlate existed: this repo (static two-site
system, Supabase `uhmyjevtfrynunxfsyof`, RPC-only writes) and
`Dreone6/rocketplate-daily-delights` ("DD") — a Lovable-built TanStack Start SSR
app with its own pages, lead form, and a **second, Lovable-managed Supabase
project** (`bnqxickbbsunlmuierkc`) outside the founder's org. Two live surfaces
with two databases would split the Miami 33186 demand signal Phase Zero exists
to measure, and DD's write path (browser-direct anon INSERT, no rate limiting,
silent-failure duplicate handling) violates ADR-002. Full evidence:
docs/audit/00–06.

## Decision
1. **This repo is the consolidated product in its entirety.** No DD page,
   feature, or API merges into the live product.
2. **DD is archived whole, read-only**, as (a) the leading Gate-C framework
   candidate (ADR-001's scheduled re-evaluation) and (b) the RBAC reference
   design (`user_roles` + `has_role()`) for the Gate-C auth migration.
3. **DD's Supabase project is decommissioned** — gated on a data-export check
   via the Lovable dashboard (restore → export `leads` / `waitlist_signups` /
   `restaurant_partner_applications` → replay through `upsert_lead` if real
   rows exist). Probed 2026-07-19: the project is already unreachable
   (paused/deleted — fail-closed), so no live page can write to it today.
4. **Small harvest, banked in this repo:** 3 lifestyle photos
   (`assets/food-life/`), 5–6 copy lines + step titles (COPY-DECK reserve
   bank), the role-conditional form pattern and `utm.ts` sessionStorage
   attribution pattern (Phase-2 backlog).
5. **New rule from audit P0-4:** the backend must be reproducible from this
   repo — `supabase/migrations/` now holds the byte-verified live migration
   history, and every future DDL change adds a file there (hard rule 3,
   clarified).

## Consequences
- (+) One database, one funnel, one brand source of truth; the ADR-004
  two-variant experiment stays uncontaminated.
- (+) Disaster recovery exists (versioned schema); single-laptop risk closed
  (repo pushed to github.com/SaaSWrld/RocketPlate).
- (+) DD's craft isn't wasted: it becomes the evaluated candidate at Gate C
  rather than a competing implementation today.
- (−) The founder must perform the Lovable export check + repo archive
  (external accounts; see docs/audit/06 milestones M2/M5/M6).
- (−) React/TypeScript componentization benefits are deferred to Gate C.
