# RocketPlate — Final Demo Review (2026-07-08)

> ## ⚠️ STATUS UPDATE 2026-07-16 (audit session)
>
> 1. **CRITICAL — Supabase project is paused.** `uhmyjevtfrynunxfsyof.supabase.co`
>    no longer resolves in DNS (verified against 8.8.8.8 too) — the free-tier
>    project auto-paused after ~7 days of inactivity (last activity 2026-07-08).
>    **Both live sites' forms fail for every visitor** (graceful error message
>    shows, but every lead is lost). Restore: supabase.com dashboard → project
>    RocketPlate → Restore. Prevent recurrence: upgrade to Pro OR schedule any
>    weekly request against the project (even the `zip_wait_count` RPC).
> 2. Netlify still serves the 2026-07-08 pre-`dfe47b5` deploy (`/privacy/` 404s
>    live). Credit state unknown — no CLI/MCP auth available in this session;
>    check app.netlify.com and redeploy both sites when credits allow.
> 3. Known issue #1 (three.js on mobile) is **FIXED** in commit `883fc29`:
>    three.js is now desktop-only, fetched on idle; mobile uses the poster.
>    Tradeoff: mobile loses the 3D pad mascot. Not yet deployed (see #2).
> 4. Known issue #2 (webm encode) addressed this session — see assets.
> 5. This repo has **no git remote** — the only copy of the business lives on
>    this laptop. Create a private GitHub repo and push (also enables a free
>    scheduled-workflow keep-alive for Supabase).

Reviewed against **real Netlify deployments** (not preview panes).

## Demo URLs
| Surface | URL |
|---|---|
| Company site (flagship) | **https://rocketplate.netlify.app** |
| Conversion site | **https://gorocketplate.netlify.app** |
| Restaurant partners | https://rocketplate.netlify.app/partners/ |
| Contact / Privacy / Terms | /contact/ · /privacy/ · /terms/ |
| Subscriber profile | /account?token=… (magic link from signup/email) |
| Partner status | /partners/?token=… |
| Admin (token-gated) | https://rocketplate.netlify.app/admin/ |

## QA results (all checked this pass)

**Brand** ✅ — correct logo + palette everywhere; grep-verified zero: old-domain
references, competitor names, fake restaurants, fake counters, fake testimonials.
Only real Supabase aggregates ever display; dead-zone chart labeled illustrative.

**Copy** ✅ — value prop lands in the hero's first screen on both sites; Founding 100
identical everywhere (first week free / 33% off month two / 12-month rate lock /
early access, waitlist order) and restated in /terms; "rate lock" never "rate for
life"; no competitor comparisons; launch scope always "select Miami-Dade
neighborhoods" + demand-based expansion; /partners copy is ops-credible
(counts locked night before, 2–4 PM batch, one pickup).

**Forms** ✅ — live round-trip on production Supabase this session: waitlist upsert
(created), partner application (created), duplicate email → "updated preferences"
path, required-field + consent validation, success/error/rate-limit states, UTM +
ref + source_domain captured and first-touch-protected. Test rows deleted; tables
back to zero.

**Email** ✅ — worker v2 deployed (ACTIVE, dormant until Resend key): all 7 event
templates incl. unsubscribe-ready footer ("manage preferences" link + reply
'unsubscribe'); waitlist confirmation, Founding-100 nurture, area nurture
(zone-segmented via launch_zone_status), and NEW: restaurant partner applications
now queue their own confirmation w/ status link (email_events.application_id).
Verified queuing live for all three signup paths.

**Motion** ✅ — 2K hero film desktop (lazy, HEAD-gated), Lenis smooth scroll,
choreographed rocket, reduced-motion disables everything cleanly, poster fallback
for reduced-motion, animated pad scene for mobile.

**Mobile** ✅ — readable hero (no text collisions), hamburger nav, sticky CTA,
single-column forms, ≥44px targets; NEW this pass: gorocketplate hero video now
desktop-only too (phones no longer pull 5.7MB).

**Performance** ✅/⚠️ — images 56–165KB w/ dimensions + lazy; video preload=none,
desktop-only, poster 139KB; no layout shift (absolute hero media, sized imgs).
⚠️ Known: three.js (~600KB) still loads on mobile for the mascot — see Known Issues.

**SEO** ✅ — unique titles/descriptions/canonicals/OG/Twitter cards on all public
pages; Miami-Dade/Kendall/Pinecrest/33186 keywords throughout; JSON-LD Organization;
robots.txt + sitemap.xml on BOTH sites (admin/account disallowed).

**Legal/basic** ✅ — NEW: /privacy + /terms honest pre-launch placeholders (plain-
language commitments, full versions promised before billing), /contact route with
segmented paths, unsubscribe language in every email template + privacy page.

## Supabase schema (project `uhmyjevtfrynunxfsyof`, us-east-1)
Tables: `leads` (full capture + referral graph + access_token), `launch_zones`
(seeded 33186 priority + 12 nearby), `restaurant_partner_applications` (+
best_time_to_contact, access_token, status pipeline), `email_events` (lead_id OR
application_id, 7 event types, provider fields), `submission_log` (rate limiting),
`admin_credentials` (bcrypt). RPCs: `upsert_lead`, `submit_partner_application`,
`get_my_lead`/`update_my_lead`, `get_my_application`, `zip_wait_count`,
`admin_dashboard`/`admin_export_*`, `is_admin`. RLS: no public reads of people data;
inserts via validated SECURITY DEFINER RPCs; rate-limited. Migrations (9, in order):
create_waitlist_table → create_leads_and_email_events → relax_leads_for_light_capture
→ lead_platform_upgrade → dashboards_backend → admin_rpcs_and_upsert_token →
partner_best_time_to_contact → partner_application_email_events (+ edge fn v2).
Full detail: BACKEND.md.

## Environment variables / secrets needed (the only human-gated items)
| Where | Key | Purpose |
|---|---|---|
| Supabase Edge Fn secrets | `RESEND_API_KEY` | turns the email worker on (dormant until set) |
| Supabase Edge Fn secrets | `FROM_EMAIL` | e.g. `RocketPlate <launch@rocketplate.io>` (verified domain) |
| Supabase Edge Fn secrets | `SITE_URL` | `https://www.rocketplate.io` after DNS |
| 3 HTML files | `GTM-XXXXXXX` → real ID | activates analytics (guarded no-op now) |
| Operator only | admin token | /admin access; **rotate** (SQL in BACKEND.md) |
| Registrar | nameservers/records | DNS-AND-ANALYTICS.md |

## Known issues (honest list — updated 2026-07-18)
0. ~~Deploy blocker~~ **RESOLVED 2026-07-18** — Netlify Personal ($9) activated;
   both sites deployed via MCP tokenized upload and verified live (legal routes,
   robots/sitemap, three.js diet, webm encodes all serving). Gotcha for future
   deploys: the deploy-site MCP op returns a proxy URL containing `//proxy/` —
   normalize to a single slash or the upload 400/404s. Still recommended: link
   both Netlify sites to github.com/SaaSWrld/RocketPlate for CI deploys
   (publish dir `/` for flagship, `gorocketplate` for go).
1. ~~three.js on mobile~~ **FIXED** `883fc29` — desktop-only, loaded on idle.
2. ~~No webm encode~~ **FIXED** `e13ca4f` — VP9: flagship 16.6MB→1.5MB, go 5.7MB→0.4MB.
3. **Supabase auto-paused 2026-07-15 → restored + re-verified live 2026-07-18**
   (upsert_lead 200, email queued, zip_wait_count 200). Forms were dead ~3 days;
   0 real leads lost (tables were empty). Keep-alive GitHub Action added
   (`.github/workflows/supabase-keepalive.yml`) — active once repo is pushed.
4. ~~Write-path hardening~~ **APPLIED 2026-07-19** (Andre-approved):
   `harden_public_write_paths` migration live — raw anon INSERT policies dropped
   on all four tables, `refer_restaurant` RPC live + go-site form switched
   (`5fb6d18`, deployed), `set_updated_at` search_path pinned, e2e test rows
   deleted. Verified: RPC 200, raw inserts rejected 42501, advisors WARNs cleared
   (remaining advisories are the intended ADR-002 architecture), smoke green.
5. ~~GitHub backup blocked~~ **RESOLVED 2026-07-19**: repo pushed and tracking
   `origin/master` at github.com/SaaSWrld/RocketPlate; smoke + keepalive
   workflows active. (Sister repo rocketplate-daily-delights: see docs/audit/
   + ADR-005 — archived, its Lovable Supabase project is already unreachable
   (connection refused 2026-07-19), so no stray page can write to it.)
6. AI film: minor text softness mid-rotation frames; liftoff lands in the final ~1.5s of the loop.
7. Legal pages are honest placeholders — formal versions + TCPA review required before paid traffic/SMS.
8. Receipt figures ($13.50→$26.92) are realistic but constructed — replace with a real screenshot day-of-launch.
9. Cross-site links use *.netlify.app until DNS cutover (swap script ready in DNS-AND-ANALYTICS.md).
10. Local python preview can't serve Range requests (video seek rewinds locally only) — use the Netlify URLs to review.

## Launch checklist (final)
1. ☐ DNS both domains (DNS-AND-ANALYTICS.md §1) → HTTPS green
2. ☐ Run netlify.app→domain swap script + redeploy both (§2)
3. ☐ Resend: verify domain, set 3 secrets, schedule worker (BACKEND.md) — test with `?dryRun=1` first
4. ☐ GTM ID in 3 files + publish container w/ GA4 (§3)
5. ☐ Rotate admin token (BACKEND.md)
6. ☐ One real signup per site → verify in /admin + confirmation email → delete
7. ☐ Formal privacy/terms + TCPA sign-off before ads/SMS

## Next-step recommendations (post-demo)
- Social cut of the hero film (t≈4–10 + sound bed) — virality analysis says the hook
  is the only weak beat (53/100 as-is, strong build to liftoff)
- First signed kitchen → replace "revealed at launch" mystery with one real name+photo
- Stripe card-on-file flow to convert `card_on_file_invite` emails at launch
- Mobile three.js diet; webm encode; font self-hosting (perf A)
- /admin: add partner-status editing UI (currently via SQL/dashboard)
