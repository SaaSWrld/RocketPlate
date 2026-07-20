# rocketplate.io — Copy Deck & QA Checklist

## Voice (applies to both sites)
Confident, warm, clear, energetic, slightly playful. Premium but not corporate;
Miami-local without sounding small; food-forward without reading like a menu;
direct enough to convert.
**Never use:** "cheap food", "meal prep" (as a description of RocketPlate),
"ghost kitchen", "like DoorDash" (or naming competitors), "rate for life",
fake restaurant names, fake testimonials, fake launch claims, fake numbers.

## Copy bank assignments (applied 2026-07-07)
| Slot | rocketplate.io (brand) | gorocketplate.com (conversion) |
|---|---|---|
| H1 | "Dinner, cleared for launch." | "Hot local meals. One weekly subscription. Zero delivery chaos." |
| Sub | "We batch orders, partner with neighborhood restaurants…" (bank #3) | "No delivery-fee roulette. No tip pressure…" (bank #2) |
| Problem | "Dinner got too complicated." + bank body | same |
| How it works | 3-part system (restaurants cook / we batch / subscribers eat) | bank 3 steps (choose plan / pick menus / evening route) |
| Restaurants | "Turn slow hours into a new revenue lane." + bank body | same |
| Founding 100 | "Be first on the launchpad." + bank body | same |
| Form submit | "Save My Spot 🚀" | same |
| ZIP CTA | "Request My ZIP" | "Check my ZIP" |
| Final CTA | "Join the Founding 100" + "Partner With RocketPlate" | "Bring RocketPlate to My Area" |
| Quick capture | — | "Get Launch Access" |
| FAQ lead | "Is this just another delivery app?" (no competitor names) | same |
Reserve headlines (unused, on deck): "Your favorite local meals, delivered hot
daily." / "A smarter dinner routine from restaurants you already love." /
"Restaurant meals, weekly simplicity."

Brand-era canonical strings (from the official asset set — usage rules in
context/01_BRAND_GUIDE.md): "3·2·1·LIFTOFF!" (campaign motif, never permanent
headline; live in the flagship ticker) · "FUELED BY YOUR ORDERS" · "SCAN TO JOIN
US" · "SEALED HOT AT __:__" · "NOW LAUNCHING IN {region}" · characters: Rocky
(the rocket) + RKT-3.3 "Three-Three" (the chef robot).

Reserve lines harvested from the archived daily-delights repo (audit D3, all
on-voice — see docs/audit/03 + ADR-005):
- "We own the kitchen relationships, the delivery experience, and the food
  temperature at your door."
- "The Founding 100 are the neighbors who unlock RocketPlate in their zone."
- "Waitlist signals drive the schedule."
- "Fresh during their slow afternoon window — never reheated leftovers."
- Honest-status FAQ pattern: "Is RocketPlate live today? Not yet." (+ what
  decides the schedule)
- Step-title alternates (concrete/benefit-forward): "Pick your plan" /
  "Kitchens batch-cook" / "One hot evening drop"

Company landing site. Brand authority over conversion pressure; the aggressive
capture funnel lives at gorocketplate.com. Both sites share one Supabase backend
(`leads` table, segmented by `role` + `landing_page_variant`).

## Primary message
**RocketPlate is building the daily hot-meal subscription layer for local restaurants.**

## Copy deck (as shipped)

### Hero (video-ready)
- Eyebrow: `RocketPlate · Launching first in Miami-Dade`
- H1: **Hot local meals, delivered daily.**
  (alternate held in reserve: "Your favorite meals, delivered on a weekly rhythm.")
- Sub: "RocketPlate partners with local kitchens to bring fresh, hot meals to your
  door through simple weekly plans."
- CTAs: `Join the Founding 100` (primary) · `See How RocketPlate Works` (ghost → #how)
- Load-in sequence: rocket reveal begins → eyebrow → headline words → sub → CTAs →
  hero note → scroll cue. Copy stays left; the right lane is reserved for the
  rocket/robot/plate focal point.

**Hero video drop-in** (Magica still → Higgsfield/Kling/Seedance motion):
drop `assets/rocketplate-hero.mp4` + `.webm` + `rocketplate-hero-poster.png` — no
code changes. Desktop + motion-OK gets the ambient film (muted/loop/lazy, object-fit
cover, cream/navy readability overlays, 3D rocket hands off and fades in after ~55vh
of scroll). Mobile and reduced-motion get the poster; if no assets exist, the
animated placeholder runs (3D rocket + pad smoke + steam wisps + drifting meal cards).
Approved video beats (v2, 2026-07-08): locked back-¾-view 4K still — hull slogan
"YOUR FAVORITE MEALS DELIVERED DAILY" on the back panel, "ROCKETPLATE.IO" arcing on
the side panel, exact logo colors (cream hull, crimson nose, light-blue fins, orange
porthole) → rotation sweeps ROCKETPLATE.IO past camera → front porthole reveals the
brand-colored robot (cream/navy, orange accents) waving left-handed with serving dish
in right hand → ignition → liftoff. Master upscaled to 2K for the flagship hero;
gorocketplate serves the lighter 720p.

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
- [x] OG image: real 1200×630 art from the hero still (`assets/og.jpg`)
- [x] Hero film + poster live (`assets/rocketplate-hero.mp4` / `-poster.jpg`,
      Higgsfield still `f1a7b4d0` → Kling video `068493b4`; regenerate at higher
      res by re-running the video job from the same still)
- [ ] Point www.rocketplate.io DNS at Netlify site `rocketplate` + HTTPS
- [ ] Add GTM/GA4 snippet (dataLayer events already firing)
- [ ] Privacy/terms pages before paid traffic
