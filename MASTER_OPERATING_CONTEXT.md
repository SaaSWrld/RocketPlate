# RocketPlate — MASTER OPERATING CONTEXT

> **Load this first.** One file = the whole operating picture. Everything here was
> true and verified on 2026-07-19. Operates under AI-BOS
> (`C:\Users\dreon\AI-BOS\MASTER_SYSTEM_PROMPT.md`) and this repo's constitution
> (`CLAUDE.md` — 8 hard rules; RPC-only writes, no fake data, docs move with code).

## 1. What this company is

Hot-dinner subscription for Miami-Dade: independent restaurants batch-cook during
their dead 2–4 PM window; RocketPlate delivers hot on one nightly route (4:15–6:30 PM).
Basic **$84.99/wk** (5 dinners) · Premium **$124.99/wk** (7) · Founding 100 offer:
first week free, 33% off month two, 12-month rate lock, early access — in waitlist order.

**Phase Zero / War Room:** the waitlist IS the experiment. Pilot ZIP **33186**
(Kendall/Pinecrest) + 12 nearby ZIPs. Demand signal decides launch order; nothing is
built past validation until Gate C (Stripe/auth/RBAC → ADR-003 re-evaluation).

## 2. Live surfaces (all verified by `node scripts/smoke.mjs` — 24 checks green)

| Surface | URL (pre-DNS) | Role |
|---|---|---|
| Company site | rocketplate.netlify.app | Brand flagship ("Dinner, cleared for launch."), 3D rocket + hero film |
| Conversion site | gorocketplate.netlify.app | Waitlist machine (variant test arm, ADR-004) |
| Partners | /partners/ | Restaurant application + tokenized 5-stage status tracker |
| Admin | /admin/ | Token-gated live metrics + CSV export (bcrypt, sessionStorage) |
| Account | /account?token= | Subscriber self-service (magic-link tokens) |
| Legal/Contact | /privacy /terms /contact | Honest pre-launch placeholders |
| Email worker | Edge Fn `send-emails` | Deployed, dormant until RESEND_API_KEY |

Domains **rocketplate.io** / **gorocketplate.com** are owned but NOT cut over yet
(runbook: DNS-AND-ANALYTICS.md).

## 3. The system in one diagram

```
GitHub SaaSWrld/RocketPlate (master) ── CI: smoke.yml + supabase-keepalive.yml
        │  git push → 2 Netlify sites (rocketplate / gorocketplate)
        ▼
Static single-file pages (ADR-001) ── CSP + SRI + HSTS (2026-07-19)
        │  publishable key, /rest/v1/rpc/* ONLY (ADR-002 — zero anon table writes, live-verified)
        ▼
Supabase uhmyjevtfrynunxfsyof (us-east-1, THE ONLY DATABASE — ADR-005)
  7 tables · 14 SECURITY DEFINER RPCs · IP rate limiting (10/10min)
  email_events queue (7 types) · admin views · bcrypt admin credential
  Schema versioned in supabase/migrations/ (10 files, md5 == live history)
```

## 4. Consolidation state (ADR-005, 2026-07-19)

The parallel Lovable build `Dreone6/rocketplate-daily-delights` is **retired**: audited
by a 13-agent review (docs/audit/00–06), graded C-, wrote to a Lovable-owned database
outside our org via a write path our constitution bans. Harvested into this repo:
3 lifestyle photos (`assets/food-life/`), 6 copy lines (COPY-DECK reserve bank).
Banked for Gate C: its TanStack/React stack (framework candidate) and `user_roles`+
`has_role()` RBAC reference. Its Supabase project (`bnqxickbbsunlmuierkc`) probed
unreachable — fail-closed.

## 5. Founder-gated actions (🔑 the ONLY things blocking launch)

1. **Lovable export check** → then archive the daily-delights repo on GitHub (M2/M5/M6 in docs/audit/06)
2. **DNS cutover** both domains (+ verify each domain's page writes to OUR database) → then run the URL-swap in DNS-AND-ANALYTICS.md §2
3. **Resend**: verify domain, set `RESEND_API_KEY`/`FROM_EMAIL`/`SITE_URL`, cron the worker
4. **GTM container ID** in 3 files — the funnel is instrumented but unmeasured (highest-leverage single action)
5. **Rotate admin token** (SQL in BACKEND.md:84) — exposed in chat 2026-07-07
6. **Formal legal/TCPA sign-off** before paid traffic or any SMS send
7. One real end-to-end signup per site after cutover → verify in /admin → delete

## 6. Operating runbooks

- **Deploy:** `npx @netlify/mcp` flow or Netlify UI; ALWAYS `node scripts/smoke.mjs` after (hard rule 4 — previews lie).
- **Any DDL change:** new file in `supabase/migrations/` + apply via migration + run advisors (hard rule 3; repo and live must never diverge — audit P0-4).
- **Read the demand signal:** /admin (token) — totals, zones, cuisines, variants, exports.
- **Advance a partner:** update `restaurant_partner_applications.status` (new→reviewing→tasting→menu_setup→live).
- **Email preview before going live:** POST worker with `?dryRun=1` + service key.
- **Weekly:** keepalive workflow pings Supabase (free tier pauses after ~7 idle days — it already died once, 2026-07-15).

## 7. Where everything is documented

| Question | Doc |
|---|---|
| Rules of engagement | CLAUDE.md (constitution) + docs/adr/ADR-001…005 |
| Backend model | BACKEND.md · schema: supabase/migrations/ |
| Launch state / known issues / checklist | LAUNCH-REVIEW.md |
| Verified current state | ROCKETPLATE_CURRENT_STATE_DELTA.md |
| Voice + copy bank + banned phrases | COPY-DECK.md |
| Approved art direction ("Warm Launch") | DESIGN-DIRECTIONS.md · motion: INTERACTION-DIRECTION.md |
| DNS/GTM founder runbook | DNS-AND-ANALYTICS.md |
| The two-repo audit + migration plan | docs/audit/00–06 |
| Conversion-site internals | gorocketplate/BUILD-NOTES.md |

## 8. Key identifiers

| Thing | Value |
|---|---|
| GitHub | github.com/SaaSWrld/RocketPlate (master) |
| Netlify | team `dreone6`: sites `rocketplate` (fa64163e…) + `gorocketplate` (f416765d…) |
| Supabase | `uhmyjevtfrynunxfsyof` us-east-1, org "A SaaS Nation" (publishable key is public by design; service key lives ONLY in provider dashboards) |
| Retired | Dreone6/rocketplate-daily-delights + Supabase `bnqxickbbsunlmuierkc` (Lovable) |
| Variants | `rocketplate-io-v1` (light form) / `gorocketplate-v1` (full form) → one `leads` table |

## 9. Post-launch backlog (top of the list)

Progressive profiling (light capture everywhere + /account enrichment) · ZONES config
generated from `launch_zones` · flagship mp4 re-encode · logo.png→SVG · write-path
smoke canary · /account email-consent revoke · admin sort/filter · first signed
kitchen replaces the "revealed at launch" mystery · Gate C: framework + Supabase Auth
RBAC + Stripe (re-evaluate with DD as candidate). Full list: docs/audit/06 §B.
