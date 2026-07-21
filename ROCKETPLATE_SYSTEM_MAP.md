# ROCKETPLATE_SYSTEM_MAP.md

**Date:** 2026-07-21. Current vs target architecture. Companion to
`ROCKETPLATE_AUDIT.md`.

## Current (surviving repo — nothing deployed)

```
Browser (static HTML, one file per route)
  index.html ── Explorer waitlist form ──POST──▶ Supabase RPC upsert_lead  [BACKEND DELETED]
            └── ZIP service-area check (client-side ZONES list)
  /account /admin /partner  ── token-gated static dashboards ──▶ admin/partner RPCs  [DELETED]
  /partners /contact /privacy /terms /gorocketplate  ── static content
  3D: procedural three.js rocket (r128, CDN) + Higgsfield film/stills

Supabase project uhmyjevtfrynunxfsyof  ── DELETED (recreate from 10 migrations)
  send-emails edge function (Resend)    ── DELETED (source not in repo; recreate)
Hosting: Netlify + Vercel               ── DELETED (choose one)
Domain: gorocketplate.com / rocketplate.io ── on Vercel DNS, now serving nothing new
```

Hardcoded references that point at the dead project (must swap on rebuild):
`index.html` (SUPABASE.url + publishable key), `scripts/smoke.mjs` (SB + KEY),
`/account /admin /partner` dashboards.

## Target (blueprint V4 — one connected platform)

```
Next.js (App Router) on Vercel  ── single codebase, multiple domains, one source of truth
  Public: / how-it-works plans founding-crew waitlist service-area
          restaurants(+apply/waitlist) family about faq contact + legal routes
  Auth: login signup verify-email forgot/reset  (Supabase Auth)
  Subscriber: /account/*  (mission, meals, deliveries, billing, referrals, ...)
  Restaurant: /partner/*  (onboarding, menu, production, labels, pickups, payouts, ...)
  Driver: /driver/*       (routes, route/[id], exceptions)  — PWA
  Admin: /admin/*         (customers, restaurants, quality, production, dispatch,
                           billing, promotions, economics, service-areas, config, ...)
        │
        ├─ Supabase (Postgres + Auth + RLS + Storage + Edge Functions) — source of truth
        │     40+ entities (see blueprint §21); RPC-only public writes; RBAC (9 admin roles + 4 user types)
        ├─ Stripe (SetupIntent card-on-file; charge gate behind feature flag; webhooks)
        ├─ Resend (branded email) + Twilio (consented SMS)
        ├─ n8n/Make (event workflows) + Routific (route optimization) + Google Maps
        └─ Agents (intake, partner review, menu/photo QA, production, dispatch,
                   billing guardian, support, success, growth, founder briefing)
  Immersive: R3F/Three.js spatial scenes + GSAP timelines + Higgsfield film,
             performance tiers + fallbacks; critical copy always in live HTML
```

## Migration path (reuse, don't rebuild)

- Keep: the 10 Supabase migrations (extend, don't replace), brand system, copy
  deck, corrected homepage design + 3D/hero work, smoke test.
- Port: the static homepage into the Next.js app (or keep static Gate A and cut
  over — see AUDIT §6).
- Extend: data model from ~7 tables to the blueprint's 40+ entities via new
  ordered migrations; add Supabase Auth + RLS + RBAC; Stripe; agents.
