# 02 — CREATIVE DIRECTION (canon)

North star: **"Apple Maps meets Pixar."** Soft, cinematic, warm food-light — a
supper club that runs like mission control (DESIGN-DIRECTIONS.md "Warm Launch"
remains the base layer; this doc extends it with the character era).

## The world

- Space is WARM here: cream skies, golden-hour light, navy dusk — never cold
  sci-fi. Stars drift slowly. Steam is kitchen steam.
- Rocky flies; MO delights. The launch cloud is a recurring shape.
- Mission Control (mono type, telemetry, status lights) frames operational facts
  inside contained navy cards — never the whole page.

## The cinematic opening (flagship intro sequence — build spec)

Fade in. Black. Silence. One star… then thousands. Camera floats, tilts down —
Earth, night lights aglow. Florida becomes visible. Push in: South Florida,
Miami-Dade lights. Neighborhood labels soft-appear (Miami · Coral Gables · Doral ·
Pinecrest · Kendall). Descend into Kendall: roads sketch in, restaurant points
glow, tiny route arcs animate. Camera settles. Mission Control activates:

```
MISSION CONTROL ONLINE
SCANNING LOCATION
TARGET ACQUIRED — KENDALL
LAUNCH PILOT SITE
READY FOR FIRST DELIVERY
```

Tiny ignition. Rocky flies on — confident, elegant, never rushed. MO
waves: "Mission accepted. Welcome aboard. Ready to fuel your day?" → the site
resolves beneath.

**Non-negotiable guardrails:** skippable instantly (visible SKIP + Esc + click);
plays once per session (sessionStorage flag, never localStorage-as-truth); total
≤12s; `prefers-reduced-motion` → straight to site; mobile gets a 3-beat light
version or none; zero layout shift on resolve; stylized vector/canvas world (no
satellite imagery, no fake data on the map — glowing points are illustrative and
unlabeled as restaurants until partners are signed).

## Scroll = flight

You never scroll RocketPlate — you navigate it. The rocket always flies, never
teleports. Section beats (flagship): Launch Pad → Mission Briefing →
Restaurants → Meals → Rewards → Founder's Club → Join Launch Crew. (Current
section structure already maps; evolve labels/copy, don't rebuild sections.)

## Campaign motif rule

"3·2·1·LIFTOFF!" is a *moment*, not wallpaper: ticker lines, launch announcements,
seasonal/city campaigns, success celebrations. It never becomes the permanent H1.

## Interaction inspiration (study, never clone)

Apple · Stripe · Linear · Arc · Nothing · SpaceX · Disney Imagineering · Airbnb ·
Framer. Inspiration for feel and finish only — RocketPlate keeps its own identity.

## Tooling

Use connected MCP tools where they materially improve the result (Higgsfield for
motion/film prototypes; GitHub/Supabase/Netlify for shipping). References and
implementation aids — never sources to imitate.
