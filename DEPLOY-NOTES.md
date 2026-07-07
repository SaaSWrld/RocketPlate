# RocketPlate — Cinematic Launch Site (v1)

## Review it the right way
Do NOT judge this in a chat preview pane. Zip this folder (or drag the folder itself)
onto **app.netlify.com/drop** and review the live deploy. The 3D rocket, Google Fonts,
and scroll choreography only behave correctly on a real deploy.

## What's inside
- `index.html` — everything: styles, copy, 3D rocket (Three.js, procedural — no stock
  assets, no watermarks), GSAP scroll reveals, segmented waitlist form
- `logo.png` — extracted from your SVG, transparent background

## Wire the waitlist (before launch)
1. In Supabase, run the SQL in the comment block near the top of the <script> in index.html
   (creates the `waitlist` table). Enable RLS, allow anon INSERT only.
2. Fill in `SUPABASE.url` and `SUPABASE.anonKey` in the same block.
Until wired, the form honestly reports "backend not connected" — no fake success, no localStorage.

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
