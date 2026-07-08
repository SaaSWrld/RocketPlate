# RocketPlate — Waitlist Backend (Supabase)

Shared backend for both sites. Project `uhmyjevtfrynunxfsyof` (us-east-1,
org "A SaaS Nation"). A real lead-capture platform, not a static form target.

## Tables

### `leads`
Full spec columns plus platform extras: `updated_at` (auto-touch trigger),
`referral_count` (bumped when someone signs up with your `referral_code`),
`source_domain`, `founding_100_interest` (was `wants_founding_100`), and the
segmentation fields `feeding_count` / `subscribe_timeline`. Unique on
`lower(email)`. RLS: **no anon INSERT** — all public writes go through
`upsert_lead()` (see below), so the client can't set arbitrary columns.

### `launch_zones`
Public marketing data (anon SELECT allowed): `zip_code` unique, city,
neighborhood, state, `status` (priority/nearby/future/live), `priority_score`,
`target_launch_date`. Seeded with 33186 (priority) + 12 Kendall/Pinecrest ZIPs
(nearby). Lead/partner counts are **not** columns here — they live in the
service-role admin views so private totals aren't exposed.

### `restaurant_partner_applications`
Full partner intake: business_name, contact_name, email, phone, cuisine_type,
address, zip_code, website, instagram, pos_system, number_of_locations,
can_batch_2_to_4_pm, estimated_capacity, `status` (new→reviewing→tasting→
menu_setup→live / declined / on_hold), notes. RLS: anon INSERT only.

### `email_events`
Resend-ready queue: `lead_id`, `event_type`, `status`, `sent_at`,
`provider_message_id`, `metadata` jsonb. RLS with **no policies** = service-role
only (the future Resend worker). Auto-queued by the `queue_lead_emails` trigger
on lead insert (see mapping in gorocketplate/BUILD-NOTES.md). Preference
**updates do not re-queue** — no email spam on resubmit.

### `submission_log`
Rate-limit ledger (ip, tbl, created_at). Service-role only.

## Security model
- **RLS on every table.** Public can only: INSERT partner apps + referrals,
  SELECT launch_zones, EXECUTE `upsert_lead` and `zip_wait_count`.
- **No public read of leads.** Private counts are never exposed raw; only the
  intentional `zip_wait_count(zip)` aggregate (returns an integer, shown only
  when > 0) and the service-role admin views.
- **Server-side validation** in `upsert_lead`: email format, name presence, ZIP
  length, and required email consent — all enforced in the DB, not just JS.
- **Rate limiting**: `rate_limit_guard` BEFORE INSERT trigger on leads, partner
  apps, and referrals. Reads `x-forwarded-for`; caps 10 submissions / 10 min /
  IP; raises `rate_limited` (frontends show a friendly cooldown message).
  Non-HTTP contexts (admin/service) are exempt.
- **Duplicate-email graceful handling** via `upsert_lead`: same email updates
  its own preferences; identity and first-touch attribution (created_at,
  referral_code, utm_*, referred_by) are never overwritten.

## `upsert_lead(p jsonb)` → jsonb
Single public write path (SECURITY DEFINER, anon EXECUTE). Validates, then
INSERT … ON CONFLICT (lower(email)) DO UPDATE of preference columns only.
Returns `{ status: 'created'|'updated', referral_code, launch_zone_status }`.
Frontends: `created` → success/zone state; `updated` → "You're already on the
launch list. We updated your preferences."

## Dashboards (built — all three)

Three static pages in the root repo, so live at `rocketplate.netlify.app/…`
(→ rocketplate.io/… when DNS lands). Shared styles in `dash.css`. **No
service-role key ever reaches the browser** — access is via SECURITY DEFINER
RPCs that self-authorize.

### `/admin` — internal ops dashboard
- Token gate → `admin_dashboard(token)`. Token is bcrypt-hashed in
  `admin_credentials` (one row); the plaintext is held only by Andre and typed
  in (kept in sessionStorage for the tab). `is_admin()` does the bcrypt compare.
- Shows: totals (leads / founding interest / SMS / last 7d / partner apps),
  leads by zone, by role, cuisine demand, by source site, leads-by-ZIP table,
  launch-zone stats (real lead + partner counts), partner applications table,
  recent-50 leads.
- CSV export via `admin_export_leads(token)` / `admin_export_partners(token)`
  (full rows, token-gated; CSV built client-side). All real data, no fake metrics.
- **Rotate the admin token**: `update admin_credentials set token_hash =
  extensions.crypt('NEW_TOKEN', extensions.gen_salt('bf',10));`

### `/account` — subscriber launch profile
- Opened via `?token=<access_token>` (per-lead UUID, unguessable; would be the
  email magic-link). `get_my_lead(token)` reads, `update_my_lead(token, prefs)`
  writes preference columns only (never email/attribution). Shows current plan,
  ZIP zone, Founding status, editable prefs, and the referral link + count.
- Surfaced automatically in both signup success flows (upsert_lead returns the
  access_token). Until Resend is wired, returning access needs that emailed link —
  the no-token state says so honestly.

### `/partner` — restaurant application + status
- No token → application form → `submit_partner_application(jsonb)` (validates
  business/contact/email, rate-limited) → returns a private status link.
- `?token=` → `get_my_application(token)` → 5-stage pipeline (Applied → Menu fit
  review → Sample & tasting → Launch menu setup → Go-live), with declined/on_hold
  states. Ops advance a partner by updating `restaurant_partner_applications.status`.
- All partner CTAs on both sites now point here.

### Admin aggregate views (service-role / definer only)
- `admin_leads_by_zip`, `admin_cuisine_demand`, `admin_zone_stats` — consumed by
  `admin_dashboard`. Not granted to anon/authenticated.

Migrations added: `dashboards_backend`, `admin_rpcs_and_upsert_token`.

## Email worker (Resend) — Edge Function `send-emails`

Deployed and ACTIVE, currently **dormant** (no Resend key yet, so it never
fake-sends). Drains `email_events` where `status='queued'`, renders an HTML
template per `event_type`, sends via Resend, marks `sent`/`failed` +
`provider_message_id` + `sent_at`. Templates exist for all 7 event types.

- **Auth**: caller must present the service-role key as `Bearer`. Unauthenticated
  `GET ?selftest=1` returns only `{ ok, hasResendKey, from }` for health checks.
  Verified: selftest ok, unauthorized POST → 401.
- **Dry-run**: runs automatically while `RESEND_API_KEY` is unset (leaves events
  queued, marks nothing); or force with `?dryRun=1`. So it's safe as-is.

**Activation (Andre must do — external account required):**
1. Verify a sending domain in Resend (e.g. rocketplate.io) — SPF/DKIM records.
2. Set Edge Function secrets: `RESEND_API_KEY`, `FROM_EMAIL`
   (e.g. `RocketPlate <launch@rocketplate.io>`), optional `SITE_URL`.
   (`supabase secrets set …`, or Dashboard → Edge Functions → Secrets.)
3. Schedule it. Options: Supabase Dashboard cron; an external cron (cron-job.org,
   GitHub Action) POSTing to `…/functions/v1/send-emails` with the service-role
   key; or pg_cron + pg_net from Postgres. Every 2–5 min is plenty.
   Preview before going live: POST with `?dryRun=1` to see rendered recipients/subjects.

## Migrations (in order)
`create_waitlist_table` → `create_leads_and_email_events` →
`relax_leads_for_light_capture` → `lead_platform_upgrade`.

## Verified (2026-07-07, then cleaned to zero)
Create; duplicate-updates-preferences (case-insensitive); first-touch
attribution preserved on update; referral_count bump; email events queue on
insert only; rate limit trips on the 11th rapid submit; validation rejects
bad email / missing name / short ZIP / missing consent.
