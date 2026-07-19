# RocketPlate — Engineering Constitution

RocketPlate is a **long-term software company, not a coding project** (founder directive,
2026-07-18). Every architectural decision must reduce future technical debt, improve
maintainability, preserve scalability, and leave the repository cleaner, faster, more
secure, better documented, and easier to extend than before. Never optimize for
short-term convenience at the expense of long-term quality.

## Hard rules

1. **RPC-only public writes.** The browser never writes tables directly; every public
   write goes through a validated SECURITY DEFINER RPC with rate limiting (ADR-002).
   Never add an anon INSERT/UPDATE/DELETE policy to a people-data table.
2. **No secrets client-side or in Git.** Only the publishable Supabase key may appear
   in HTML. Service-role keys and API keys live in provider dashboards only.
3. **Schema changes are migrations.** Named, ordered, applied via Supabase migrations —
   never ad-hoc dashboard DDL. Run security advisors after every DDL change.
4. **Verify on the real deploy.** Preview panes and localhost lie (Range requests,
   fonts, 3D). Route checks + `node scripts/smoke.mjs` after every deploy.
5. **No fake data, ever.** No invented testimonials, counters, restaurant names, or
   figures presented as real. Demo/sample data must be labeled.
6. **Docs move with code.** A change that alters behavior updates the relevant doc
   (README, BACKEND, LAUNCH-REVIEW) in the same commit. Significant choices get an ADR.
7. **Performance is a feature.** Heavy media: lazy, desktop-gated, webm+mp4, posters,
   immutable-cached. No new dependency without weighing its weight.
8. **Windows quirks:** flag emoji don't render (use alternatives); local http.server
   can't serve Range requests; `python` not `python3`.

## Current phase

War Room / Phase Zero: waitlist validates demand before payments are built. Launch-critical
work only; everything else goes to the Phase 2 backlog in LAUNCH-REVIEW / delta report.
Gate C (Stripe, auth accounts, RBAC) triggers the platform re-evaluation in ADR-003.

## Key references

Architecture: README.md + docs/adr/ · Backend: BACKEND.md · State: ROCKETPLATE_CURRENT_STATE_DELTA.md
Supabase project: `uhmyjevtfrynunxfsyof` (us-east-1) · Netlify: sites `rocketplate` + `gorocketplate`, team `dreone6`
