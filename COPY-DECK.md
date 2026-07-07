# rocketplate.io — Copy Deck & QA Checklist

Company landing site. Brand authority over conversion pressure; the aggressive
capture funnel lives at gorocketplate.com. Both sites share one Supabase backend
(`leads` table, segmented by `role` + `landing_page_variant`).

## Primary message
**RocketPlate is building the daily hot-meal subscription layer for local restaurants.**

## Copy deck (as shipped)

### Hero
- Eyebrow: `RocketPlate · Launching first in Miami-Dade`
- H1: **The daily meal subscription built for local restaurants.**
- Sub: "We partner with independent restaurants, batch meals during slow afternoon
  hours, and deliver them hot in a single evening route — creating better value for
  subscribers and predictable revenue for local kitchens."
- CTAs: `Join the Waitlist` (primary) · `Partner With RocketPlate` (ghost, prefills restaurant)

### Problem (`#why`)
- H2: **Food delivery got expensive. Meal prep got boring.**
- Four pains: fee-heavy apps · repetitive meal prep · idle restaurant afternoons ·
  no reliable dinner rhythm. Receipt visual: $13.50 bowl → $26.92 total (fees stack,
  count-up animation). Counter-chip: `ROCKETPLATE: ≈ $17 A PLATE · EVERYTHING INCLUDED`.

### Model (`#how`)
- H2: **One system. Three moving parts.**
- 1 Restaurants cook (slow hours) → 2 RocketPlate batches (one route) → 3 Subscribers
  eat hot (4:15–6:30 PM). Cutoff chips: 9 PM swap · 1 PM add-ons · skip/pause anytime.

### For subscribers (`#subscribers`)
- H2: **Dinner, handled.** Six benefits: hot restaurant meals · weekly simplicity ·
  no delivery-fee chaos · local kitchen variety · easy plan selection · Founding 100 access.

### Kitchens (`#kitchens`)
- H2: **Real restaurants. Real dinner.** 8 cuisine chips, no restaurant names
  (revealed at launch; Founding 100 tastes first).

### Pricing + Founding 100 (`#pricing` / `#founding`)
- H2: **One price. Everything included.** Basic $84.99/wk (5) · Premium $124.99/wk (7).
- Founding banner: first week free · 33% off month two · 12-month rate lock ·
  early access before public launch. CTA: `Join the Founding 100`.

### For restaurants (`#restaurants`)
- H2: **Your slowest hours can become your most predictable revenue.**
- Chips: batch production · pre-counted demand · no dine-in disruption · no
  marketplace dependency · new customer relationships · local brand lift.
- Dead-zone bar chart (illustrative day-shape, no fake data claims).
- CTA: `Apply as a founding kitchen` → form, restaurant segment.

### Operating rhythm (`#rhythm`)
- H2: **Every day runs on the same clock.**
- 9:00 PM cutoff → 10:00 PM counts locked → 2–4 PM afternoon prep → 4:15–6:30 PM
  evening delivery. (Customer-friendly; deeper ops stay in restaurant conversations.)

### Partner path (`#path`)
- H2: **From first hello to go-live, in five steps.**
- Apply → Menu fit review → Sample & tasting → Launch menu setup → Batch delivery
  go-live. CTA: `Apply as a Restaurant Partner`.

### Launch plan (`#launch`)
- H2: **First stop: Miami-Dade.** Neighborhood-by-neighborhood framing; pilot =
  Kendall/Pinecrest ZIP 33186; expansion by waitlist demand. Stylized SVG map with
  pulsing pilot beacon — deliberately abstract, no live-service implication, no fake
  city data. CTA: `Request Your ZIP` (scrolls to form, focuses ZIP).

### FAQ (`#faq`) — three groups
Subscriber (DoorDash?, change/skip, fees/tips) · Restaurant (kitchen fit, cost,
how to apply) · Launch (where first, ZIP not in pilot, Founding 100).

### Final CTA (`#launchpad`)
- H2: **Help launch RocketPlate in your neighborhood.**
- `Join the Waitlist` + `Become a Restaurant Partner`.

## Lead capture routes
| Route | Mechanism |
|---|---|
| Subscriber waitlist | Form segment "Hungry human" → `role: customer` |
| Restaurant partner | Any `data-seg="restaurant"` CTA (nav Partner, hero ghost, restaurant/path/final sections) pre-selects segment → `role: restaurant_owner` |
| Driver / Investor-Press | Segment buttons → `driver_operator` / `investor_press` |
| ZIP request | `Request Your ZIP` → form with ZIP focused |
| Full profile upsell | Success fine print links to gorocketplate.com |

Every insert carries: zone status (33186 priority / 12 nearby ZIPs), UTM + `?ref`
capture, user agent, `landing_page_variant: rocketplate-io-v1`, and email consent.
Duplicates (409) are told their spot is safe. Email events queue automatically.

## QA checklist
- [x] All 13 sections render in order; zero console errors
- [x] Nav single-line at desktop widths (Partner/Founding collapse first, then full mobile)
- [x] Form validation (missing fields, consent required) + progress bar (5 checks)
- [x] Submit → row in `leads` with correct role/zone/variant; email events queued; verified then cleaned
- [x] Duplicate email → friendly "already on the list" (409 path)
- [x] Restaurant CTAs pre-select the restaurant segment
- [x] Request Your ZIP scrolls + focuses ZIP field
- [x] Rocket flight retimed for 13 sections; no text collisions at checked breakpoints
- [x] Reduced motion: reveals instant, Lenis off, rocket static, map pulse hidden
- [x] Mobile: single-column grids, sticky CTA, rocket below hero copy
- [ ] Replace `assets/og.png` with real 1200×630 OG art
- [ ] Point www.rocketplate.io DNS at Netlify site `rocketplate` + HTTPS
- [ ] Add GTM/GA4 snippet (dataLayer events already firing)
- [ ] Privacy/terms pages before paid traffic
