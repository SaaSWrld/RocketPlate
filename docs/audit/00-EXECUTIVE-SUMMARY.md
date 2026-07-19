<!-- 2026-07-19 consolidation audit — 13 read-only agents (3 inventory, 5 audit dimensions,
     5 adversarial verifiers), ~1.5M tokens, 286 tool calls. Full detail in docs 01–06. -->

# RocketPlate Consolidation Audit — Executive Summary

**Question:** two repos claim to be RocketPlate — `SaaSWrld/RocketPlate` ("RP", the
static two-site system) and `Dreone6/rocketplate-daily-delights` ("DD", the
Lovable-built TanStack Start app). Which one is the product?

**Answer:** **RP, in its entirety. DD is archived whole, after a data-export gate.**
No page, feature, or API from DD is merged into the live product; DD is banked as the
Gate-C framework candidate and RBAC reference, plus a small harvest (3 photos,
5–6 copy lines, 2 UX patterns). Recorded as ADR-005.

## Grades

| | RP | DD |
|---|---|---|
| Engineering | **A-** | **C-** |
| UX | **A-** (flagship A-, go A-, partners B+, account B+, admin B, legal B-) | **B** (/ B+, /company B) |
| Brand vs approved system | source of truth | ~85% port, 2 banned-phrase violations, H1 slot contamination |
| Phase-Zero completeness | full operating system (waitlist, partners, admin, account, email, analytics) | 2 landing pages |
| Security | hardened, **live-verified** RPC-only (zero anon write policies) | direct anon writes, no rate limit **[CONFIRMED]** |

## The five decision-driving discoveries

1. **DD writes to a database the founder doesn't own.** Its Supabase project
   (`bnqxickbbsunlmuierkc`) is Lovable-managed and absent from the founder's org —
   any leads it captured are outside our custody and invisible to `/admin`.
   → Export gate (M2) before anything is turned off.
2. **DD's write path violates the constitution.** Browser-direct anon INSERTs, no rate
   limiting, and a duplicate-email path that silently updates 0 rows while telling the
   user "we updated your preferences." Adversarially confirmed.
3. **RP's backend had no versioned source of truth.** Zero `.sql` files in the repo —
   production DDL lived only in the hosted project + prose docs. Ironically DD, the
   archived repo, was the only one with real migration files. → M1 snapshots the live
   schema into `supabase/migrations/` (done in the implementation pass).
4. **Domain three-way collision.** DD's pages also claim rocketplate.io /
   gorocketplate.com. At DNS cutover, whichever site a domain points at silently
   decides which database gets the leads. → DD offline before cutover; cutover
   checklist now verifies the write target.
5. **RP's security held up under adversarial review.** The one claimed RP policy gap
   was **refuted** against the live database (exactly one policy exists: public SELECT
   on `launch_zones`). Remaining RP findings are defense-in-depth (CSP/SRI, two small
   escaping fixes, token-scrub) — all fixed in the implementation pass.

## Launch-critical fixes surfaced (engineering-doable, executed)
Broken logo/favicon refs on partners/privacy/terms/contact (visible 404 on the
credibility-critical partner page) · flagship missing favicon · noindex-vs-sitemap
contradiction · SEC-04/05/08 hardening · SRI + CSP + HSTS · doc-drift reconciliation
(BACKEND.md migration list, BUILD-NOTES pre-hardening section, stale delta advisor
line) · ADR-005.

## What stays founder-gated 🔑
DD data export via Lovable → then archive DD + decommission its Supabase project ·
DNS cutover · Resend activation · GTM container ID (the funnel is instrumented but
**unmeasured** — the single highest-leverage action in this audit) · admin token
rotation · formal legal/TCPA before paid traffic or SMS.

## Docs in this audit
[01 Inventory](01-REPO-INVENTORY.md) · [02 Matrix (46 dispositions)](02-PAGE-FEATURE-MATRIX.md) ·
[03 UX/Eng/Brand grades](03-UX-ENGINEERING-GRADES.md) · [04 Security (verified)](04-SECURITY-AUDIT.md) ·
[05 Target architecture](05-TARGET-ARCHITECTURE.md) · [06 Migration plan](06-MIGRATION-PLAN.md)
