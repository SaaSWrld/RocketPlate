# 05 — MOTION SYSTEM (canon)

Extends `../INTERACTION-DIRECTION.md` (tokens/tiers/perf budget remain law).
This doc adds the physicality mandate.

## Physicality mandate

All motion must feel physically believable — handcrafted, never generic CSS:
- Cinematic acceleration in, soft deceleration out (`power3.out` / `expo.out`
  stay the tokens; nothing linear, nothing bouncy).
- **Rocky banks** into direction changes (existing keyframe tiltZ does this —
  preserve in any new path).
- Clouds disperse with turbulence (staggered puff scales/opacities, never one
  uniform fade). Smoke expands as it rises.
- Stars drift slowly; parallax layers move at distinct speeds.
- Particles respond to user movement (scroll velocity already throttles the
  flame — keep extending this pattern).
- Lighting shifts subtly with scene position (flame PointLight flicker,
  hero-film handoff fade).

## The flight rule

The rocket **always flies, never teleports**. Any new section, page, or state
change the rocket participates in must show a path, not a jump cut. Scroll is
navigation: damped progress (0.07 lerp) mapped to keyframed flight.

## Delight moments (approved inventory)

- Submit button 🚀 mini-launch on success (exists — keep).
- Success state may fire a one-shot launch-cloud puff (turbulent, brand colors,
  ≤900ms) — motif-compatible.
- Ticker = telemetry feed; 3·2·1·LIFTOFF line rides it.
- Cinematic opening per 02 (guardrails there are law).

## Hard limits (unchanged + extended)

- `prefers-reduced-motion`: EVERY effect has a static-parity fallback; intro
  sequence skips entirely.
- One WebGL context; three.js desktop-only, idle-loaded, SRI-pinned.
- Animate transform/opacity only; `once:true` reveals; no scroll-jank —
  interaction must never wait on decoration.
- Mobile: lighter everything; sticky CTA behavior preserved.
