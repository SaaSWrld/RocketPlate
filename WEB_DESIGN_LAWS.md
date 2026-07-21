# WEB_DESIGN_LAWS.md — RocketPlate front-end design law

**Status:** LAW. Read before producing any website design, layout, animation, or
front-end code. Violations are rejected regardless of technical correctness.
**Source:** distilled from the founder's curated design tutorials (Self-Made Web
Designer — *6 Easy Tips to 10x Any Site*, *Steal These Web Design Trends 2026*,
*The Seismic Shifts in Web Design*; Coding With Ujjwal — cinematic GSAP scroll /
parallax builds; Jack Roberts — *Claude + the correct design context builds $10k
websites*) plus current top-tier practice. This is a **living doc** — refine it
as we learn specifics from each source; never delete a rule without logging why.

> The core lesson from the Jack Roberts videos: an AI builds generic sites when
> it lacks *design context and taste*, not when it lacks skill. This document IS
> that context. The goal is work that looks **art-directed and intentional**, not
> assembled from defaults.

---

## 0. The one test (apply to every screen)

Before shipping any view, answer: **"Would this look at home in an awwwards /
$10k-agency portfolio, or does it look like a template?"** If it's the template,
it's not done. The tells of "template / generic AI" are in §9 — hunt them out.

---

## 1. Typography is 60% of the craft

- **Big, confident display type.** Hero headlines are large and set with intent
  (clamp-scaled, tight tracking on the biggest sizes, generous line-height on
  body). Timid 32px headlines read as a template.
- **A real type pairing with contrast.** One expressive display face + one clean
  workhorse + (optional) a mono for telemetry/labels. Use the display face's
  *personality* — weights, italics, optical sizing — don't set everything at one
  bold weight (that wastes the face and reads generic).
- **A modular type scale.** Sizes come from a scale (e.g. 1.2–1.333 ratio), not
  arbitrary px. Same for weights.
- **Editorial details:** an accent word in italic or a second style; deliberate
  line breaks only as a typographic decision (use `text-wrap: balance`, not a
  forced `<br>` on every heading); tracking that tightens as size grows.
- **Readable body:** 60–75ch measure, 1.5–1.65 line-height, ≥16px, high contrast.

## 2. Space is a material — use a lot of it

- **Generous, asymmetric whitespace.** Crowded = cheap. Let hero and section
  intros breathe. Whitespace is the fastest premium signal.
- **A spacing scale** (8pt-based tokens: 8/16/24/32/48/64/96/128). Every gap and
  padding snaps to it. Random 44/46/52px gaps read as hand-nudged = unrefined.
- **Vertical rhythm** is consistent section to section.

## 3. Break the grid — don't center everything

- **Editorial, asymmetric layouts.** Off-center heroes, content that spans an
  intentional column range, overlap between type and imagery, diagonal energy.
- **Don't stamp the same section header 9× in a row** (eyebrow + centered H2 +
  lead). Vary openers: an oversized numeral here, a full-bleed headline there, a
  left-label there. Repetition of one unit is the loudest AI-template tell.
- Use a real grid (12-col) and deliberately violate it for emphasis.

## 4. Color: restraint + depth

- **A disciplined palette** with one dominant, one bold accent, and neutrals.
  RocketPlate: navy `#0B3468` / rocket-orange `#F1502F` / warm-white `#FFF8EE`
  (see brand canon — that palette is law).
- **Never a flat, dead field.** Large color areas get depth: a subtle gradient, a
  grain/noise texture, a duotone, a vignette, or a background motif. A flat
  fully-saturated block reads toy-like.
- **Contrast is non-negotiable** — meet WCAG AA (§8). White on bright orange
  fails; darken the fill or the text passes.

## 5. Motion: cinematic, purposeful, hierarchical

The tutorials are heavy on GSAP scroll storytelling — do it *well*, not as decoration.

- **Scroll = narrative.** The page tells a story as you scroll (RocketPlate: the
  mission — signal → network → standard → launch → delivery → invite). Motion
  reveals meaning, it doesn't just fade things in.
- **Motion hierarchy, not one blanket reveal.** Stagger children (stepped
  delays), let images scale/clip-reveal while text translates, reserve the
  biggest move for one hero moment. One identical `opacity/translateY` fade on 60
  elements is the canonical stock reveal — avoid it.
- **Easing has taste:** cinematic ease-out curves (e.g. `cubic-bezier(.16,1,.3,1)`).
  Nothing linear, nothing bouncy, nothing that overshoots cartoonishly.
- **Micro-interactions with intent:** a signature CTA cue (arrow that slides, fill
  that wipes, subtle magnetic pull), considered hover states — not a universal
  `translateY(-2px)` on everything.
- **Restraint:** no scroll-hijacking, no pinning every section, no autoplay sound,
  60fps or don't ship it. GSAP/ScrollTrigger only for *deliberate* timelines.

## 6. Imagery & 3D: real, cinematic, consistent

- **Real photography, art-directed.** Consistent lighting/treatment across the
  set (duotone or shared grade if needed). No random stock mix.
- **Food must look appetizing and true** (brand rule: no fake/misrepresented
  food; label representative imagery).
- **3D/immersive earns its place:** spatial scenes only where they add wonder,
  with performance tiers and fallbacks (poster → video → reduced-motion). Never a
  blank canvas; meaningful HTML loads first. Critical copy is never trapped in a
  video or canvas.

## 7. Custom components, not a component-library look

- Buttons, cards, inputs, nav all feel **designed for this brand** — bespoke
  radius system (2–3 tokens, applied consistently), considered borders/shadows,
  brand-tied iconography (not default dots/✦/+ everywhere).
- Cohesion: one radius language, one shadow language, one motion language across
  the whole site. Inconsistency (rounded media + razor-sharp UI, five different
  corner radii) reads as unresolved.

## 8. Accessibility & performance ARE design

- **WCAG AA minimum:** text ≥4.5:1 (large ≥3:1), UI/borders ≥3:1, visible focus
  states, 44px tap targets, full `prefers-reduced-motion` coverage, semantic
  landmarks, alt text, keyboard paths.
- **Performance is a premium signal:** fast LCP, lazy/gated heavy media
  (desktop-gate video, poster fallbacks, webm+mp4), width/height on images (no
  CLS), subset fonts, offscreen render paused. A slow site never feels expensive.

## 9. Anti-patterns — the "generic AI / template" tells (BANNED)

If the design has these, it will read as cheap. Actively hunt and remove:

1. The same eyebrow + centered H2 + lead unit repeated every section.
2. One identical fade-up reveal on everything; no stagger, no variety.
3. Flat, untextured full-bleed color blocks with no depth.
4. Default micro-interactions (universal `translateY(-2px)` hover, uniform image
   zoom on every picture).
5. Stock iconography (plain dots, ✦ separators, +/× accordions) with no brand voice.
6. Timid type — everything one weight, no scale, no editorial accent.
7. Crowded, centered, symmetric everything (no whitespace, no grid-breaking).
8. Arbitrary spacing/radii not on a scale.
9. Generic "startup template" section order with no narrative.
10. Emoji as UI icons (also a Windows rendering rule — flag/emoji don't render).

## 10. RocketPlate-specific creative law (defer to brand canon)

- Brand canon in `brand/canon/` is ABSOLUTE and outranks this doc on brand
  specifics (palette, characters, hull markings, experience laws).
- Voice: premium, optimistic, family-friendly, mission/liftoff metaphor. **Not**
  cyberpunk, military, dystopian, generic-SaaS, or generic food-delivery.
- The cinematic layer creates wonder; **pricing, consent, forms, legal, and
  support stay in accessible live HTML** (blueprint rule 9 & §24.5).

---

*When a tutorial teaches a specific technique we adopt (e.g. a particular GSAP
scroll pattern, a type treatment, a layout move), add it here as a concrete rule
with a one-line "why" so the lesson becomes enforceable law, not a vibe.*
