# ROCKETPLATE_AUDIT.md — Prompt 1 master audit

**Date:** 2026-07-21 · **Auditor:** Claude (AI-BOS executive team) · **Against:**
blueprint V4 (`docs/ROCKETPLATE_MASTER_PLATFORM_BLUEPRINT.md`), repo `master`
@ `5b3e559`, and the founder's 2026-07-21 teardown of live infra.
**Rule followed:** audit first, preserve working systems, no redesign yet.

Evidence: **[V]** verified by code/git read this session · **[I]** inferred ·
**[A]** assumption · **[?]** unknown/needs founder.

---

## 1. Headline (the honest state)

The **code survived; the running infrastructure did not.** During the 2026-07-21
teardown the founder deleted the Supabase project, the Netlify sites, and the
Vercel projects. The `SaaSWrld/RocketPlate` git repo (all branches) and the full
local working copy are **intact**, including every migration, brand asset, and
doc. So this is a **clean relaunch from a known-good repo**, not a from-scratch
rebuild.

**Nothing is live right now.** Gate A must be *re-stood-up*, not reinvented.

## 2. What survived (keep) [V]

| Area | State |
|---|---|
| Static site | `index.html` (brand-corrected navy/orange/Fraunces homepage) + 9 routes: `/account /admin /contact /partners /partner /privacy /terms /gorocketplate /phase2` |
| Supabase schema | **10 migrations** in `supabase/migrations/` — waitlist, leads+email events, light-capture relax, lead-platform upgrade, dashboards backend, admin RPCs + upsert token, partner fields, partner email events, hardened public write paths, ZIP format guard. Enough to **recreate the backend exactly.** |
| Brand + character | Official logo set (`assets/brand-*`, `brand/logos`, `brand/robot`, `brand/stickers`, bags, magnets), corrected character render `assets/character/byte-ready.webp`, engraved porthole `porthole-ring.webp`, 8 canon webp refs, full `brand/canon/` law docs |
| Docs | README, BACKEND, LAUNCH-REVIEW, COPY-DECK, context/00–07, `docs/audit/00–05`, and now the V4 blueprint |
| Tooling | `scripts/smoke.mjs` production smoke test |
| Git | branches `master`, `phase1-styleframes`, `phase2-cinematic` — all on `SaaSWrld/RocketPlate` |

## 3. What was destroyed (rebuild) [V]

| Lost | Impact | Recovery |
|---|---|---|
| **Supabase project** `uhmyjevtfrynunxfsyof` | Backend gone; hardcoded project ref + publishable key in `index.html` and `scripts/smoke.mjs` now point at a dead project | Create a **new** Supabase project, apply the 10 migrations, swap the ref/key everywhere. AI ~15 min. |
| **Real waitlist leads** (if any existed) | Any real Explorer/Founding signups captured pre-teardown are **gone** | Unrecoverable. Going forward, export before any destructive action. |
| **`send-emails` edge function** | Source was **not** committed to the repo (lived in the deleted project) — only its behavior is documented in `BACKEND.md` | Recreate from the BACKEND.md spec; commit the source this time so it never lives only in the cloud. AI ~30 min + founder: Resend API key. |
| **Netlify sites + Vercel projects** | No host; no live domain | Pick ONE host, deploy, repoint domain. Founder: DNS. |

## 4. Feature classification vs blueprint

- **Working & keep:** homepage shell + brand system; Explorer waitlist form +
  `upsert_lead` contract (backend needs recreating); ZIP service-area check;
  legal/contact routes; smoke test; procedural 3D rocket + Higgsfield film/stills.
- **Working but disconnected:** `/admin`, `/account`, `/partner` token-gated
  static dashboards — UI exists, backend deleted, and they are hand-built static
  HTML that will **not** scale to the blueprint's role-based app.
- **Incomplete vs blueprint:** Founding Crew (needs Stripe SetupIntent — never
  built); real subscriber dashboard; restaurant application/approval/onboarding;
  menu + photo approval; restaurant dashboard; labels/packout/production; driver
  + dispatch; master admin; promotions + economics simulator; email/SMS
  workflows (only leads confirmation existed); full analytics; the Earth→Kendall
  cinematic (§24).
- **Not started (by design — Phase Zero):** all paid-billing (Gate C), all pilot
  ops (Gate B). Correct per the plan — validate demand first.
- **Unsafe:** none active — **no Stripe, no auth, no service-role key or secret
  in tracked web files** [V, secrets sweep clean]. Only latent risk: the dead
  Supabase ref will make forms error until swapped.
- **Duplicate:** the `/gorocketplate` redirect stub + `/partner`→`/partners`
  split are consolidation leftovers; fold into one canonical structure.

## 5. Gate readiness (current reality)

| Gate | Now | After Gate-A relaunch | Notes |
|---|---|---|---|
| **A — Public discovery + lead capture** | 🔴 **DOWN** (infra deleted) | 🟡 **YELLOW** (recoverable in hours) | Recreate Supabase from migrations + email fn + one host; then it's back. |
| **B — Controlled pilot ops** | 🔴 Not started | 🔴 | Needs the app platform (auth/RBAC/dashboards). Post-validation. |
| **C — Paid subscription** | 🔴 Not started (by design) | 🔴 | Stripe SetupIntent + 72/48/24 guard. Behind feature flag until Gates B ready. |
| **D — Immersive 3D** | 🟡 Partial | 🟡 | Procedural rocket + film exist; full Earth→Kendall cinematic §24 not built; character name unresolved. |

## 6. The architecture fork (decide before building Gates B/C) [I]

- **Current:** static single-file-per-route HTML + Supabase RPCs. Fast, cheap,
  great for **Gate A**. But every dashboard is hand-built static HTML.
- **Blueprint target:** ONE connected app — auth, RBAC (9 admin roles + 4 user
  types), 40+ entity data model, Stripe, restaurant/driver/admin dashboards,
  agents. This **cannot** be hand-built as static HTML at quality.
- **Recommendation:** adopt **Next.js (App Router) on Vercel** for the platform,
  reusing the migrations, brand system, copy, and the 3D/hero work. Do it
  **before** Gates B/C, not after they're half-built in static HTML. This is the
  `ADR-003` platform re-evaluation the constitution anticipated.
- **Two viable sequencings** (founder picks):
  - **(i) App-first:** stand the Next.js app up now; build Gate A inside it, then
    B/C incrementally. Cleaner, no rework. AI est: Gate A in app ~1 focused day.
  - **(ii) Static Gate A now, app in parallel:** relaunch the static Gate A in
    hours to be live, build the app alongside, cut over at Gate B. Faster to
    "live," some throwaway. AI est: static relaunch ~2–3 hrs.

## 7. Open decisions — need founder ruling (block direction, not Gate A)

1. **Character name (blueprint Q46):** blueprint says **L.I.F.T.-3.3 / "Lift"**;
   repo canon says **MO / MØ / BYTE.3.3**. These conflict. Pick one canonical name
   before any new character art/copy. *Recommend: decide now; I'll reconcile the
   canon docs to match.*
2. **Architecture:** app-first (i) or static-now-app-parallel (ii) from §6.
3. **Host:** **Vercel** or **Netlify** — one only. (Blueprint assumes Vercel/Next.)
4. **Canonical domain:** `gorocketplate.com` primary; `rocketplate.io` →
   redirect? Confirm both are still registered and where DNS lives.
5. **Contest scope:** you asked to spin up a few agents and pick the best build.
   Recommend running that as a **homepage design contest** (3 distinct art-
   directed directions, same content + brand law) *after* the backend is back —
   so we compare real, wired variants, not throwaways. Confirm agent count (3?).

## 8. Recommended immediate path (Gate A relaunch)

AI-execution estimates (AI build + human review + external), per AI-BOS:

1. **New Supabase project + apply 10 migrations** — AI ~15m · founder: approve
   project (Supabase MCP can create it) · run security advisors after.
2. **Recreate + commit `send-emails` edge function** — AI ~30m · founder: Resend
   API key (goes in Supabase secrets, never in Git).
3. **Swap dead project ref/key** in `index.html`, `scripts/smoke.mjs`, dashboards
   — AI ~15m.
4. **Pick host + deploy Gate A**, verify on real deploy + smoke — AI ~20m ·
   founder: choose host, later DNS.
5. **Confirm §7 decisions** → then **Prompt 2** (story/experience) + the homepage
   **design contest**.

## 9. Founder actions required (short list)

- Rule on the **5 open decisions** in §7 (name, architecture, host, domain, contest).
- Provide a **Resend API key** (for confirmation emails) when we recreate the email fn.
- Approve **new Supabase project** creation.
- Later: **DNS** change to point the domain at the chosen host.

Nothing here needs card/payment info, and Gate C billing stays disabled behind a
flag per blueprint §3.
