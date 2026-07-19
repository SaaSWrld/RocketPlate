# ROCKETPLATE — CURRENT-STATE DELTA & V2 MASTER PROMPT BACKTEST
**Date:** 2026-07-18 · **Auditor:** Claude (AI-BOS executive team) · **Verified against:** live deploys, live Supabase, repo `master` @ `a7b48a5`

This document backtests ROCKETPLATE_LAUNCH_MASTER_PROMPT_V2.md against verified reality.
Evidence classes: **[V]** verified this session (live request, SQL, or code read) · **[I]** inferred from code/docs · **[A]** assumption · **[?]** unknown.

---

## 1. RELEASE GATE VERDICTS (the honest answer)

| Gate | Verdict | Summary |
|---|---|---|
| **A — Demonstration Ready** | 🟢 **PASS** | Both sites live & current, forms round-trip production Supabase, no fake data, admin dashboard works, legal routes public. Demo to restaurant owners today. |
| **B — Lead-Capture Pilot Ready** | 🟡 **YELLOW** | Capture/attribution/rate-limit/consent/admin all verified working. Blocked only by: email delivery unproven (Resend key+domain = founder), DNS not cut over (founder), hardening migration awaiting approval, GTM ID (founder, optional). |
| **C — Paid Subscription Pilot** | 🔴 **NOT STARTED — BY DESIGN** | Zero Stripe footprint [V]. Per AI-BOS Phase Zero, payments are built AFTER the waitlist validates demand. V2's Gate C list is accepted as the future spec, behind-flag. |

---

## 2. V2 CLAIMS vs VERIFIED REALITY

### §0.2 Reported deployments — CORRECTED
- ~~"Live sites serve a prior deploy; `dfe47b5` not deployed"~~ → **STALE.** Both sites redeployed 2026-07-18 from `a7b48a5` (includes `dfe47b5` + 5 later commits). [V] Routes /privacy /terms /contact /partners, robots, sitemap, webm all return 200 on both sites.
- "Six tables, ten RPCs, nine migrations" → close: **7 tables** (incl. `restaurant_referrals`, absent from older docs), **14+ RPCs**, **9 migrations** + this session's pending one. [V via SQL]
- `BUILD-NOTES.md` (V2 §0.1) → exists at `gorocketplate/BUILD-NOTES.md` (go-site build notes), not repo root; other docs: DEPLOY-NOTES, BACKEND, LAUNCH-REVIEW, COPY-DECK, DESIGN-DIRECTIONS, INTERACTION-DIRECTION, DNS-AND-ANALYTICS. [V]

### §0.5-A Deployment drift — RESOLVED 2026-07-18 [V]
Netlify Personal plan active; both sites deployed & browser-verified. Rollback = Netlify deploy history (previous deploy retained). MCP deploy gotcha documented in LAUNCH-REVIEW (`//proxy/` URL must be normalized).

### §0.5-B Two public sites — DECISION: KEEP SPLIT THROUGH VALIDATION (challenged)
V2 wants one canonical experience. Pushback: the split is deliberate — flagship = brand/company site, go = stripped ad-landing variant; both feed ONE backend with `landing_page_variant` attribution [V]. Merging now costs days, destroys the variant test, adds zero leads. **Revisit at DNS cutover** (redirects preserve attribution) or when data shows one variant dominates. Logged in DECISION_LOG.

### §0.5-C Stripe — CONFIRMED ABSENT [V]; deferred to post-validation (Phase Zero). V2 §11–13 (subscriptions, promotions engine, pricing simulator) adopted as the Gate C build spec, not current work.

### §0.5-D Constructed receipt figures — OPEN, pre-ads blocker. Receipt visual ($13.50→$26.92) is constructed [I]. Replace with real screenshot at first partner signing; not a Gate A/B blocker (it's illustrative marketing, not a billing record — no billing exists).

### §0.5-E Legal placeholders — DEPLOYED [V]. /privacy /terms /contact live on flagship; footer links present; honest "formal versions before billing" language. Formal versions + TCPA review remain **pre-paid-traffic blockers** (already in LESSONS_LEARNED as law).

### §0.5-F Resend — PREPARED, DELIVERY UNPROVEN — agreed. Worker v2 ACTIVE + dormant-safe (selftest [V]: `ok:true, hasResendKey:false`). Queue verified live [V] (test signup queued `waitlist_confirmation`). V2 §F items 1–3 = founder (key, FROM_EMAIL, SPF/DKIM/DMARC); items 4–14 (inbox tests, bounce handling, dedupe, partner-token safety) = Claude, ~1h after secrets exist. **Do not claim "email works" until inbox tests pass.**

### §0.5-G Admin auth — PARTIALLY DISAGREE with severity. Verified [V]: token entered in UI, held in sessionStorage (not URL), validated server-side via bcrypt (`is_admin`/`admin_dashboard(p_token)` SECURITY DEFINER); data reads impossible without it (RLS: no public read policies on people tables [V]). Acceptable for Gate A/B single-operator use. **Required before Gate C:** Supabase Auth + RBAC + audit logs + MFA (V2 list adopted). **Required now:** rotate the token that was pasted in chat on 2026-07-07 (SQL in BACKEND.md) — still pending.

### §0.5-H Supabase security — REVERIFIED THIS SESSION [V]
- Advisors run: no ERRORs. WARNs = SECURITY DEFINER RPCs callable by anon (that IS the architecture — token-gated), `WITH CHECK (true)` anon INSERT policies, one mutable search_path.
- **Fix written, awaiting Andre approval** (`harden_public_write_paths`): drops unused raw anon INSERT policies (leads/waitlist/partner apps — frontends use RPCs only [V]), replaces go-site's one raw insert (`restaurant_referrals` [V]) with validated `refer_restaurant` RPC, pins `set_updated_at` search_path.
- Rate limiting verified at trigger level on all 3 public-write tables [V]. Service-role key: never in repo [V grep]. Backups/PITR: free tier = daily backups only [I] — acceptable for pilot, revisit at Gate C.
- One e2e test lead (`e2e-test-20260718@rocketplate.io`) awaits approved deletion.

### §0.5-I Mobile three.js — FIXED [V] `883fc29`: desktop-only, requestIdleCallback, poster fallback; forms/nav have zero three.js dependency [V]. Live-verified.

### §0.5-J Film assets — LARGELY FIXED [V] `e13ca4f`: webm now exists (flagship 16.6MB→1.5MB, go 5.7MB→0.4MB), muted, poster present, preload=none, desktop-only. Remaining (accepted, minor): mp4 masters still in bundle (~22MB/deploy) — fine at current deploy frequency; move to CDN/storage if deploys become frequent. Masters ARE the deploy copies; 4K source lives in Higgsfield job history.

### §0.5-K DNS — OPEN, FOUNDER. Canonicals/OG/JSON-LD already point to final domains (rocketplate.io / gorocketplate.com) [V], so cutover is registrar work + the netlify.app→domain link-swap script (ready in DNS-AND-ANALYTICS.md). **V2's `rocketplate.com` preference challenged:** we hold .io + gorocketplate.com; .com purchase = optional founder call, not a launch blocker.

### §0.5-L GTM — GUARDED NO-OP VERIFIED [V] in both files (regex-validated placeholder, analytics-independent site). Needs container ID (founder). rpTrack event names exist in code [V]; document payloads at GTM setup.

### §0.5-M Robots/sitemap/footer — LIVE-VERIFIED TODAY [V]. robots disallows /admin/ + /account/ on flagship. Sitemap: legal routes added this session (commit pending deploy — batch with next deploy).

### §0.5-N Form lifecycle — MOSTLY VERIFIED: server-side validation [V (`invalid_name` rejection observed)], rate limit [V], duplicate→update-preferences [V docs+code], consent checkbox required [V code], attribution first-touch [I from code], accessibility ≥44px targets [I from LAUNCH-REVIEW QA]. No captcha — deliberate (rate limit suffices at current scale; add Turnstile if spam appears). Deletion/suppression path: manual via admin/SQL — acceptable for pilot, document in privacy ops.

### §0.5-O Capability depth — honest classification:

| Capability | Status |
|---|---|
| Waitlist, early-interest, referral capture, partner application, partner status page | **Existing & complete** [V] |
| Customer prefs self-service (/account via magic token) | Existing & complete [I, QA'd 07-08] |
| Admin CRM (leads, zips, cuisine demand, exports, zone stats) | Existing, read-mostly; partner status edits via SQL — **partner-status UI = Phase 2** |
| Expansion intelligence | Basic ranked tables live (admin views) [V schema]; V2 §18 scoring engine = Phase 2 |
| Customer auth accounts, Stripe billing, menu management, promotions engine, pricing simulator, CMS, notification center, feature flags, RBAC, demo mode | **Missing — deferred to Gate C / Phase 2 with reason: Phase Zero validation first** |

### §0.6 / §29 Vercel migration — **REJECTED FOR THIS PHASE** (challenged per AI-BOS)
Rationale: static sites + working paid Netlify pipeline restored TODAY; Vercel adds zero customer value, real cutover risk, and hours of work during War Room. V2's own escape hatch applied: documenting the reasoned blocker instead. **Revisit trigger:** when Gate C build begins (app framework, serverless Stripe webhooks) — that's the natural platform re-evaluation point. Until then Netlify = canonical + rollback.

### §35 Deliverables mapping
Delivered now: this delta report, ROCKETPLATE_FOUNDER_ACTIONS.md, LAUNCH-REVIEW (test results + known limitations), DECISION_LOG (AI-BOS), DNS runbook, BACKEND schema map. Deferred with Gate C: API guide, mobile-readiness guide, brand guide (assets not yet supplied — see Founder Actions), media pipeline doc.

---

## 3. WHAT STANDS BETWEEN TODAY AND GATE B (complete list)

1. **Founder:** DNS cutover (both domains) → then Claude runs link-swap + redeploy + full re-verify.
2. **Founder:** Resend key + verified sending domain + 3 secrets → then Claude runs V2 §F delivery test battery.
3. ~~Hardening batch~~ **DONE 2026-07-19** — migration applied, referral form on RPC (deployed), test rows deleted, advisors clean, smoke green.
4. **Founder:** GitHub re-auth → Claude pushes backup + keep-alive activates.
5. **Founder:** rotate admin token (2-min SQL).
6. **Founder (optional for Gate B):** GTM container ID.

Nothing else. Gate A needs nothing — demo today.
