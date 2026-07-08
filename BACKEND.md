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

## Admin aggregates (service-role only — power a future `/admin`)
- `admin_leads_by_zip` — leads, founding interest, restaurant leads per ZIP
- `admin_cuisine_demand` — picks per cuisine (unnested array)
- `admin_zone_stats` — each zone's real lead + partner counts, priority, date

Planned `/admin` route (build later, service-role key server-side ONLY, never
shipped to the browser): total leads, leads by ZIP, Founding 100 interest,
restaurant applications, cuisine demand, CSV export. No fake metrics — every
number reads from these views.

## Migrations (in order)
`create_waitlist_table` → `create_leads_and_email_events` →
`relax_leads_for_light_capture` → `lead_platform_upgrade`.

## Verified (2026-07-07, then cleaned to zero)
Create; duplicate-updates-preferences (case-insensitive); first-touch
attribution preserved on update; referral_count bump; email events queue on
insert only; rate limit trips on the 11th rapid submit; validation rejects
bad email / missing name / short ZIP / missing consent.
