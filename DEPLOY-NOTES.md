# RocketPlate — Cinematic Launch Site (v1)

## Review it the right way
Do NOT judge this in a chat preview pane. Zip this folder (or drag the folder itself)
onto **app.netlify.com/drop** and review the live deploy. The 3D rocket, Google Fonts,
and scroll choreography only behave correctly on a real deploy.

## What's inside
- `index.html` — everything: styles, copy, 3D rocket (Three.js, procedural — no stock
  assets, no watermarks), GSAP scroll reveals, segmented waitlist form
- `logo.png` — extracted from your SVG, transparent background

## Waitlist backend — WIRED ✅ (2026-07-07)
Supabase project: **RocketPlate** (`uhmyjevtfrynunxfsyof`, us-east-1, org "A SaaS Nation").
- `public.waitlist` table created via migration `create_waitlist_table` with RLS enabled:
  anon role can INSERT only (no select/update/delete). Server-side checks on segment,
  email format, and field lengths.
- `SUPABASE.url` + publishable key are filled in index.html.
- Verified end-to-end: form submit → 201 → row in table → success message.
View signups: Supabase dashboard → Table Editor → waitlist.

## Flight choreography
The rocket's scroll path lives in `KF_DESKTOP` / `KF_MOBILE` arrays:
[progress, x, y, rotationTurns, tiltZ, scale, flameSize, smokeOpacity]
Tune positions per section by editing those rows. Progress 0 = top of page, 1 = footer.

## Built-in quality floor
- Reduced-motion: static rocket, instant reveals, no scroll scrub
- Mobile: rocket rides the top of the viewport, lighter pixel ratio
- No fake data anywhere: no counters, no restaurant names, no invented testimonials
- Domain on footer: rocketplate.io (per latest direction: .io = main landing,
  gorocketplate.com = waitlist capture)
