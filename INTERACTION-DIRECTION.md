# RocketPlate — Interaction Direction

The site is a **launch sequence, not a brochure**. Every scroll advances a directed
product film: the rocket lifts off, banks through the story, and settles over the
waitlist. Motion exists to carry that narrative — never as decoration.

---

## 1. Motion tokens

Single vocabulary, used everywhere. No one-off timings.

| Token | Value | Used for |
|---|---|---|
| `EASE` | `power3.out` | Card/group entrances, generic reveals |
| `EASE_LONG` | `expo.out` | Headlines, hero moments, CTA lock-ins |
| `EASE_UI` | `cubic-bezier(.22,1,.36,1)` | CSS hovers, shine, progress bar |
| `EASE_SPRING` | `cubic-bezier(.34,1.56,.64,1)` | Button press/hover lift only (restrained overshoot, never bounce) |
| Reveal duration | 0.85–0.9s | Text and cards |
| Group stagger | 0.10s | Cards in a grid |
| Word stagger | 0.045s | Headline words |
| Hover transition | 0.22–0.3s | All microinteractions |
| Scroll damping | Lenis `duration: 1.15`, expo easing | Whole-page weight |

**Banned:** `bounce`, `elastic`, back-easing over 1.6 overshoot, linear fades,
anything longer than 1.5s for a UI response.

## 2. Weighted scroll (Lenis)

- Lenis drives the page with `duration 1.15` and an exponential ease-out — weighted
  and intentional, not slippery, not syrupy.
- ScrollTrigger and the rocket's flight both read Lenis-driven scroll; GSAP's ticker
  owns the RAF loop (`lagSmoothing(0)`).
- Anchor navigation glides via `lenis.scrollTo` with a `-76px` header offset.
- Scroll **velocity feeds the rocket's flame** — fast scrolls stretch the exhaust,
  making the page feel like the user is throttling the rocket.
- Touch devices keep native scrolling (Lenis smooths wheel only); reduced motion
  disables Lenis entirely.

## 3. Reveal system

Three tiers, in priority order:

1. **Headlines (`h1`, section `h2`)** — split into words at runtime; words rise
   `0.6em` with opacity, `expo.out`, 45ms stagger. Fires once at `top 86%`.
2. **Card groups** (steps, cuisine wall, plan cards, restaurant points, founding
   perks) — children enter as a sequence: `y:44 → 0`, 100ms stagger, triggered by
   the *container*, so a grid reads as one choreographed beat.
3. **Everything else (`.rv`)** — single soft rise (`y:34 → 0`, `power3.out`).

Special moments:
- **Receipt (Problem section):** fee lines stack in one at a time, then the total
  counts up 13.50 → 26.92 — the fees literally pile up in front of the user.
- **Join card:** locks into attention — scales from 0.965 with a long expo settle
  as the rocket arrives overhead. This is the "payload deployment" beat.

## 4. 3D depth policy

Three.js earns its weight in exactly one place: the **procedural toy rocket** that
flies the full scroll journey (keyframed x/y/rotation/scale/flame per section, with
idle bob, mouse parallax, orbiting dinner-plate payload, and pad smoke at launch).
Depth elsewhere is faked cheaply:
- `.bg-wash` ambient gradients drift on scrub (slow parallax layer)
- rocket moves against static content (fast layer) — two speeds are enough
- No additional WebGL scenes. If a future section wants depth, use layered
  SVG/canvas parallax, not a second renderer.

## 5. Section pacing (launch sequence)

| Beat | Section | Rocket | Motion moment |
|---|---|---|---|
| Ignition | Hero | On pad, smoke alive | Headline words rise; scroll cue pulses |
| Value stream | Ticker | — | Constant marquee (the "telemetry feed") |
| The problem | Why (receipt) | Banks right, small | Fees stack, total counts up |
| The fix | How it works | Crosses left | 3 steps enter in sequence |
| The kitchens | Kitchens | Crosses far right | Cuisine chips cascade |
| The offer | Pricing | Small, upper left | Founding banner, then plans lift in |
| The partners | Restaurants | Right side | Points slide with depth; dead-zone bars grow |
| Payload deploy | Join | Centers overhead, nose up | Join card locks in; form is the star |
| Drift | Footer | Floats up and away | Quiet exit |

## 6. Microinteractions

| Element | Behavior |
|---|---|
| Primary buttons | Hover: lift `-3px` + scale 1.02 + deeper shadow + **shine sweep** (skewed light band, 0.7s, `EASE_UI`); active: press down |
| Ghost buttons | Hover: lift + border solidifies |
| Arrows in CTAs | Nudge `+4px` on hover |
| Step / plan cards | Hover: lift `-6/-8px`, shadow deepens, **warm glow + orange border tint** |
| Cuisine chips | Hover: lift + 1° tilt + warm fill |
| Nav links | Crimson underline grows left→right |
| Form fields | Focus ring (rocket blue) + label tints blue via `:focus-within` |
| Form progress | Thin gradient bar above fields fills as name/ZIP/email become valid |
| Submit success | Message pops in (rise + scale settle); the 🚀 in the button launches off and re-lands |
| Mobile sticky CTA | Pill slides up after the hero, hides near the join section (never covers the form) |

## 7. Mobile

- Rocket rides the top of the viewport at reduced scale; pixel ratio capped at 1.5.
- Lenis leaves touch scrolling native — no scroll-jacking on phones.
- Sticky bottom CTA keeps "Join" one thumb away for the whole journey.
- Same reveal system, same tokens — cinematic feel is preserved through timing,
  not extra effects. Nothing mobile-only is added except the sticky CTA.

## 8. Reduced motion (`prefers-reduced-motion: reduce`)

Non-negotiable fallbacks, no broken layout:
- Lenis off; native scrolling, instant anchors.
- All reveals render visible immediately (no split words, no staggers, no scrub).
- Rocket renders static at its hero pose; no bob, no flame flicker, no smoke drift.
- Ticker, scroll-cue pulse, and shine sweeps are disabled.
- Sticky mobile CTA shows without the slide transition.

## 9. Performance budget

- One WebGL context, procedural geometry only (no texture/model downloads).
- Reveals are `once: true` — no persistent scroll listeners after they fire.
- Only `transform`/`opacity` are animated in CSS/GSAP (no layout thrash).
- Libraries: Three.js + GSAP + ScrollTrigger + Lenis, all CDN. Nothing else.
