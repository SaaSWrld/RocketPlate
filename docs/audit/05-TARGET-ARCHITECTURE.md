<!-- Synthesized from the 2026-07-19 multi-agent consolidation audit. Decision doc — read with 02 (matrix) and 06 (migration plan). -->

# 05 — Target Architecture

## The decision in one paragraph

**SaaSWrld/RocketPlate (RP) is the consolidated product in its entirety.** Every page,
flow, RPC, asset, and doc that ships for the Miami 33186 Phase-Zero launch is RP's.
**Dreone6/rocketplate-daily-delights (DD) is archived whole** — a well-crafted second
implementation of the same two-persona product, built on a stack the constitution
defers to Gate C (ADR-001), wired through a write path the constitution bans (ADR-002),
into a Supabase project the founder does not control. Nothing in DD is launch-critical;
nothing blocks launch by archiving it. DD's real value is banked, not merged: it is the
leading **Gate-C framework candidate** and the **RBAC reference design**, plus a small
harvest of copy lines, photography, and form-UX patterns.

This decision is recorded as **ADR-005** (written alongside this audit).

## Why RP wins (evidence-backed, from 02/03/04)

| Dimension | RP | DD |
|---|---|---|
| Engineering grade | **A-** — deliberate, documented, tested, constitution-honoring | **C-** — polished frontend on the wrong architecture: unused SSR, 50 deps, no tests/README/CI, Lovable lock-in |
| UX grade | **A-** — 7 coherent surfaces, real end-to-end journeys | **B** — 2 beautiful pages with a lying success state, placeholder CTA, no legal scaffolding |
| Backend | Hardened RPC-only platform, verified live (zero anon write policies) | Direct anon writes, no rate limit, silent-failure duplicate path — **[CONFIRMED]** |
| Data custody | Founder's org (`uhmyjevtfrynunxfsyof`, ACTIVE_HEALTHY, keepalive cron) | Lovable-managed `bnqxickbbsunlmuierkc`, **not in the founder's Supabase org** |
| Brand | The source of truth (COPY-DECK, Warm Launch) | ~85% faithful port with banned-phrase violations and H1 slot contamination |
| Phase-Zero completeness | Waitlist + partners + admin + account + email pipeline + analytics dictionary | Landing pages only; admin/email machinery schema'd but unbuilt |

## Target system (the consolidated RocketPlate)

```
                        ┌──────────────────────────────────────────────┐
                        │  GitHub: SaaSWrld/RocketPlate (master)       │
                        │  CI: smoke.yml · supabase-keepalive.yml      │
                        └───────────────┬──────────────────────────────┘
                                        │ git push → Netlify (ADR-003)
            ┌───────────────────────────┼───────────────────────────┐
            ▼                           ▼                           │
  Netlify site "rocketplate"   Netlify site "gorocketplate"         │
  rocketplate.io (post-DNS)    gorocketplate.com (post-DNS)         │
  /  /partners/  /admin        /  (conversion variant,              │
  /account /contact /legal     ADR-004 two-site test)               │
            │                           │                           │
            └──────────── RPC-only (publishable key) ───────────────┘
                                        │
                        ┌───────────────▼──────────────────────────────┐
                        │  Supabase uhmyjevtfrynunxfsyof (SINGLE DB)   │
                        │  7 tables · 14 SECURITY DEFINER RPCs         │
                        │  rate_limit_guard · email_events queue       │
                        │  send-emails edge fn (Resend, dormant)       │
                        │  NEW: supabase/migrations/ versioned in repo │
                        └──────────────────────────────────────────────┘

  ARCHIVED (read-only): Dreone6/rocketplate-daily-delights
  ├─ Gate-C framework candidate (TanStack Start + React 19 + TS + Zod)
  ├─ RBAC reference (user_roles + has_role, SEC-11)
  └─ its Supabase project bnqxickbbsunlmuierkc: DECOMMISSIONED after data-export gate
```

## Architecture principles carried forward (unchanged)
1. **Static-first until Gate C** (ADR-001) — zero-build single-file pages; framework
   adoption is re-evaluated when Stripe/auth/RBAC arrive, with DD as candidate.
2. **RPC-only public writes** (ADR-002) — verified live; DD's violation is the cautionary tale.
3. **Netlify canonical** (ADR-003) — two sites, git-push deploys, deploy-history rollback.
4. **Two-site variant test into one leads table** (ADR-004) — a third live surface (DD)
   would contaminate the experiment; archiving it protects the data.

## New architectural requirements surfaced by this audit
1. **The backend must be reproducible from the repo** (completeness P0-4): RP had zero
   `.sql` files — production DDL existed only in the hosted project. Fixed by
   snapshotting the live schema into `supabase/migrations/` (see 06, M1).
   Rule going forward: hard rule 3 means *in-repo* migrations, not just named ones.
2. **One database, ever** (P0-1/P0-5): any surface that captures a lead points at
   `uhmyjevtfrynunxfsyof` through an RPC. Domain cutover checklists must verify which
   site each domain serves *and which DB it writes to*.
3. **Defense-in-depth on the edges** (SEC-01): CSP + SRI + HSTS become part of the
   Netlify config baseline.
4. **Assets live in the repo** (P1-10): no CDN-manifest-only brand assets. Harvest DD's
   real images into `assets/` before archive.

## What is explicitly banked from DD (the complete merge surface)
- **Gate-C framework candidate**: the whole repo, archived read-only.
- **RBAC reference**: `user_roles` + `has_role()` + revoked-EXECUTE pattern (SEC-11).
- **Copy lines** (into COPY-DECK reserve bank): "We own the kitchen relationships, the
  delivery experience, and the food temperature at your door." · "The Founding 100 are
  the neighbors who unlock RocketPlate in their zone." · "Waitlist signals drive the
  schedule." · "Fresh during their slow afternoon window — never reheated leftovers." ·
  the honest-status FAQ pattern · DD's concrete step titles.
- **Photography**: `chef-kitchen.jpg`, `doorstep-delivery.jpg`, `hot-meals-hero.jpg`
  (committed JPGs) — copy into RP's asset library.
- **Form-UX pattern** (Phase-2 backlog): role-conditional progressive fields.
- **utm.ts sessionStorage attribution pattern** (only if the funnel ever spans pages).

## What is explicitly rejected
- Running DD as a third live surface (contaminates ADR-004, splits the funnel).
- Adopting the DD stack now (violates ADR-001; 5-vendor debug surface for a solo founder).
- Migrating any DD write path (violates ADR-002).
- Keeping two Supabase projects (splits demand signal; custody risk; keepalive gap).
