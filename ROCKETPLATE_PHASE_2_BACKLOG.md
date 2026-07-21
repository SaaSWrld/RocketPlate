# ROCKETPLATE_PHASE_2_BACKLOG.md

Everything beyond Gate A. Ordered by blueprint gate. Nothing here blocks the Gate
A relaunch. Pull items forward only when the gate ahead is truly ready
(blueprint §27–28). "Est" = AI-execution build time (excludes founder/external).

## Platform foundation (enables Gate B/C) — do once architecture is decided (O2)

- Next.js App Router scaffold on Vercel; port homepage + 3D/hero — Est ~1 day
- Supabase Auth + email verification + RLS + RBAC (9 admin roles, 4 user types) — Est ~1 day
- Extend data model to blueprint §21 (40+ entities) via ordered migrations — Est ~1–2 days
- Configuration center (service areas, ZIP eligibility, plans, prices, windows, feature flags) — Est ~1 day

## Gate B — controlled pilot operations

- Restaurant application → approval pipeline (17 statuses) + admin review — Est ~1.5 days
- Restaurant onboarding checklist portal — Est ~1 day
- Menu system (fields, 15 approval states) + Food Photo QA — Est ~1.5 days
- Restaurant dashboard (home, profile, menu, production, labels, payouts, performance) — Est ~2 days
- Production counts + acknowledgments; 2×1 meal + 4×6 bag labels + QR — Est ~1.5 days
- Scan chain (meal→bag→route→pickup→delivery) with idempotent events — Est ~1.5 days
- Driver PWA (routes, manifests, scan, proof, exceptions) — Est ~1.5 days
- Dispatch dashboard + exception handling + reconciliation — Est ~1.5 days
- Master admin dashboard (executive overview, customer/restaurant CRM, quality,
  production, delivery, billing, economics simulator, expansion, system health) — Est ~3 days
- Full pilot simulation (blueprint Prompt 7 personas) — Est ~1 day

## Gate C — paid subscription activation (flag-off until B ready)

- Stripe production config + SetupIntent + safe metadata only — Est ~1 day
- Founding status machine (14 states) — Est ~0.5 day
- 72/48/24-hour pre-charge notice sequence + logging — Est ~1 day
- Charge gate (14 preconditions) + duplicate-charge protection + failed-payment flow — Est ~1.5 days
- Webhook verification + billing audit view + production smoke with internal test acct — Est ~1 day

## Gate D — immersive 3D experience (separate preview branch)

- Prompt 2 narrative treatment (approve before building) — Est ~0.5 day
- Prompt 3 Higgsfield shot production (Earth→Kendall, Rocky, Lift, cockpit) — Est ~1 day + credits
- Prompt 4 realtime R3F/GSAP implementation w/ performance tiers + fallbacks — Est ~2–3 days
- Character reconciliation once name is decided (O1)

## Automation / agents (blueprint §20)

- 10 controlled agents (intake, partner review, menu/photo QA, production,
  dispatch, billing guardian, support, success, growth, founder briefing), each
  with structured I/O, evidence, audit, and human-approval boundaries — Est ~3–4 days total

## Cleanup / debt

- Fold `/gorocketplate` stub + `/partner`→`/partners` split into one canonical structure
- Recommit `send-emails` source so no logic lives only in the cloud again
- Consolidate the older `docs/audit/00–05` into this Prompt-1 doc set
- SMS (Twilio) consented operational messaging — Est ~0.5 day

## Family Mission

- Interest list only until economics validated (blueprint §2.3 — price not approved)
