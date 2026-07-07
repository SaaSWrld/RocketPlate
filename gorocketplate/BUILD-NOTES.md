# gorocketplate.com — Build Notes

Primary waitlist conversion site. Captures high-intent early users, segments them
for email/SMS launch campaigns. Sister site: rocketplate.netlify.app (brand landing).
Motion follows the shared [INTERACTION-DIRECTION.md](../INTERACTION-DIRECTION.md).

## Component structure (single-file, section = component)

| Component | ID | Notes |
|---|---|---|
| Header | `#hdr` | Logo + single CTA, blur on scroll |
| Cinematic hero | `#hero` | Video slot + animated fallback (see below), copy, dual CTA, quick capture |
| Pain section | `#pain` | 6 pain cards: fees, tips, cold food, random prices, decisions, no rhythm |
| Meet RocketPlate | `#how` | 4-step system cards |
| Founding 100 | `#founding` | 4 offer cards + CTA |
| Launch ZIP module | `#zipcheck` | ZIP → priority / nearby / not_yet + real wait count |
| Cuisine orbit | `#cuisines` | 8 cuisine satellites orbit a plate (CSS animation, pauses on hover; flat grid under reduced motion) |
| Partner teaser | `#partners` | Navy card, CTA prefills role=restaurant_owner |
| FAQ | `#faq` | 8 accessible `<details>` items |
| Waitlist form | `#join` → `#leadForm` | Full capture w/ validation, progress bar, loading/error states |
| Success state | `#successWrap` | Zone status, referral link + shares, restaurant referral |
| Final CTA | `#launchpad` | "Your neighborhood is next on the launchpad." |
| Sticky mobile CTA | `.m-cta` | Mid-journey only, hides at the form |

## Hero video drop-in

The hero autodetects the video. To activate, add these files (no code changes):
- `/assets/rocketplate-hero.mp4`
- `/assets/rocketplate-hero.webm`
- `/assets/rocketplate-hero-poster.png`

A `HEAD` request for the mp4 gates activation; until it exists, the animated
fallback runs (atmospheric gradients, rising steam wisps, bobbing SVG brand
rocket with pulsing flame). Reduced motion pauses autoplay + animations.

## Database (Supabase project `uhmyjevtfrynunxfsyof`, migration `create_leads_and_email_events`)

- **`leads`** — full spec columns (`first_name`…`landing_page_variant`), plus
  `feeding_count`, `subscribe_timeline`, `wants_founding_100`, `referral_code`.
  RLS: anon INSERT only. Unique on `lower(email)` → duplicate submit returns 409,
  handled client-side as "You're already aboard."
- **`email_events`** — Resend-ready queue. RLS with no policies = service-role
  only (for the future sender worker).
- **`restaurant_referrals`** — success-state suggestions. Anon INSERT only.
- **`zip_wait_count(p_zip)`** — SECURITY DEFINER RPC, anon-executable, returns the
  real aggregate count for a ZIP. This is the ONLY read path exposed to the
  browser: no fake counters, counts shown only when > 0.

## Email event mapping (Resend)

| # | Event | `event_type` | Queued by |
|---|---|---|---|
| 1 | Waitlist confirmation | `waitlist_confirmation` | DB trigger, every signup |
| 2 | Founding 100 nurture | `founding100_nurture` | DB trigger, role=customer & wants_founding_100 |
| 3 | Restaurant partner confirmation | `restaurant_partner_confirmation` | DB trigger, role=restaurant_owner |
| 4 | ZIP launch announcement | `zip_launch_announcement` | campaign (insert rows for a ZIP when it goes live) |
| 5 | Area-not-launched nurture | `area_nurture` | DB trigger, launch_zone_status=not_yet |
| 6 | Pre-launch card-on-file invite | `card_on_file_invite` | campaign |
| 7 | Subscription launch conversion | `launch_conversion` | campaign |

Sender worker (to build when Resend key exists): Supabase Edge Function on a cron —
`select * from email_events where status='queued'` → send via Resend → mark
`sent`/`failed` + `sent_at`. Payload JSON already carries email/first_name/zone.

## Segmentation fields for campaigns

`role`, `interested_plan`, `household_type`, `cuisine_interests[]`,
`launch_zone_status`, `wants_founding_100`, `subscribe_timeline`, `sms_consent`,
`utm_*`, `referred_by`/`referral_code` (referral graph), `landing_page_variant` (A/B).

## Analytics hooks

`rpTrack(event, props)` pushes `rp_*` events to `window.dataLayer` (GTM-ready).
Wired: header/hero/founding/partner/final CTAs, quick capture, zip check + result,
form submit, lead_created, lead_duplicate, success_shown, copy_referral,
share_* clicks, restaurant_referred. Drop in GTM/GA4 snippet to consume.

## Launch zone config

`ZONES` in the inline script: `priority: [33186]`, `nearby:` 12 surrounding
Kendall/Pinecrest ZIPs. Edit there as zones open; `launch_zone_status` is stamped
on each lead at signup.

## Deployment checklist

- [x] Supabase schema migrated, RLS verified (anon = insert-only + count RPC)
- [x] Keys wired (publishable key — safe for client)
- [x] Netlify site + deploy
- [ ] Point www.gorocketplate.com DNS at the Netlify site, enable HTTPS
- [ ] Replace `assets/og.png` with a real 1200×630 Open Graph image
- [ ] Drop in hero video files when the Higgsfield/Magica render is ready
- [ ] Add GTM/GA4 snippet (dataLayer already populated)
- [ ] Build the Resend sender edge function + add RESEND_API_KEY secret
- [ ] Privacy policy + terms pages before paid traffic (footer links are stubs)
- [ ] Legal review of SMS consent language before enabling texting (TCPA)
