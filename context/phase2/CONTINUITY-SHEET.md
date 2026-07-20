# Phase 2 — Cinematic Hero Preview · Continuity Sheet
_2026-07-20 · branch `phase2-cinematic` · preview live at `/phase2/` (additive,
noindex, unlisted; production routes byte-identical — smoke green after deploy
`6a5dd09dee7c5ab5aa464e37`). Founder approval gate governs integration._

Canon in force: `brand/canon/MO_CHARACTER_BIBLE.md` v1.1 (two displays: face =
emotion, chest = words) · `ROCKY_HULL_MARKINGS.md` (Mission Ring + discovery
layer) · `ROCKETPLATE_EXPERIENCE_LAWS.md`.

## Keystone stills (nano_banana_pro → nano_banana_2, 2K 2752×1536, 2 cr each)

Reference media: `mo-hero-porthole.png` uploaded as `6c351b8b-bbb8-4329-a94f-6960be374d0e`.

| Still | Job | Verdict |
|---|---|---|
| Mission Ring (GOROCKETPLATE.COM engraved on porthole ring) | `e8d42a30-7ab4-44ca-a73b-dcefdc5ab26a` · `20260720_071929` | **SELECT — vehicle canon.** Spelled exactly; tone-on-tone deboss; luxury-lens light-catch |
| MO READY portrait (chest window speaks, MØ 3.3 badge) | `aca6ad4d-d5e9-49b4-928d-59d14d10eb99` · `20260720_072555` | **SELECT — first full bible-v1.1 render.** Face keeps smile; READY in chest window; black badge correct incl. Ø |
| (first READY attempt) | `0dff068b-b9e7-49e3-acdd-6fdd93d7e11c` | **REJECT** — READY rendered across the FACE display (violates two-displays law). Badge was correct |

Web copies: `brand/canon/reference/mission-ring.webp` + `mo-ready-portrait.webp`.

## Motion shots (5s, 16:9, sound off; masters in Higgsfield)

| # | Shot | Model | Start → End | Job | QC |
|---|---|---|---|---|---|
| 1 | Signal (orbit → South Florida) | kling3_0 std | f1 `bdb6e85e…` → f2 `ade50409…` | `2c66a309-12a2-4501-ab41-408891d656e9` · `20260720_072433` (720p) | Completed; plays in sequence; full-motion eyeball = founder review |
| 2 | Descent (coast → Kendall map world) | kling3_0 std | f2 → f3 `f7b7ffde…` | `560c264a-f6f0-49cc-8d76-fb3af7a5ccdc` · `20260720_072355` (720p) | **Frame-checked live: beautiful** — beacons ignite, aerial holds warmth |
| 3 | Flight (Rocky banks over map) | kling3_0_turbo 1080p | f4b `10961a8e…` | `0cd5b8b2-b259-4c49-94a1-885821c90bd9` · `20260720_072358` | Completed; plays in sequence; eyeball = founder review |
| 4 | Hello (MO at the Mission Ring porthole) | kling3_0_turbo 1080p | Mission Ring still `e8d42a30…` | `e8aef471-0f3f-48d7-afde-eb7cc09ab67d` · `20260720_072633` | **Frame-checked live: the money shot.** Push-in to MO waving; engraved ring arcs overhead. Note: kling surfaced a faint chest marking — verify legibility on the 1080p master in close-up |
| 5 | Cockpit (dolly through porthole) | kling3_0_turbo 1080p | f6b `db5736e4…` | `184d8523-2c6d-4560-ac4f-8e1db03c9dcc` · `20260720_072436` | **Frame-checked live: gorgeous** — steam, domes, warm cabin |
| 6 | The Reveal (cloche lifts off ribs) | kling3_0_turbo 1080p | f7 `191187d0…` | `3d5663bb-bafb-4e19-8836-3894f54f0641` · `20260720_072404` | **Frame-checked live** (endcard bg) — glaze, steam, chrome sparkle |

Master URLs: `https://d8j0ntlcm91z4.cloudfront.net/user_3G8cbmmifcWVqzSC8KibofcyHUT/hf_<stamp>_<jobid>.mp4`.
Local copies for the preview: `phase2/media/` (gitignored, deploy-only; ~34 MB).
Preset note: Higgsfield's "IN THE DARK" preset recommendation was declined on
three shots (declined_preset_id `24bae836…`) — canon look only, never stock presets.

## Preview player (`phase2/index.html`)

- Double-buffered crossfade sequencer; captions are live HTML (no text baked in
  video); mission-control lines may exceed 3 words, MO's never do.
- **MO chest speech window = real DOM text** (`... → READY → ...`), Pixar-soft
  blur/ease morphs, tiny `MØ 3.3` plate-id on the chip. Never on his face.
- Resilience: per-shot 9s cap + stall re-play() watchdog (local python server
  starves streams — Netlify CDN plays clean; watchdog stays as belt-and-braces).
- Reduced motion: poster stepper, no autoplay motion. Skip/Esc + Replay.
- Analytics: `rp_phase2_view / _shot / _skip / _complete / _replay / _cta`
  (dataLayer; GTM container still founder-gated).
- Sections: plate-roster rotation (8 looks, honest concept-render label) ·
  MO READY portrait · Discovery Layer (Mission Ring) · founder approval gate.

## Verification (2026-07-20)

Deploy `6a5dd09dee7c5ab5aa464e37` → positive checks: `/phase2/` 200 with title +
mo-window + 6 wired shots; `v1-signal.mp4` streams (6.4 MB); plate webp 200;
`node scripts/smoke.mjs` **all green** (production untouched). Film sequence
verified end-to-end in-browser (shots 2/4/5/6 frame-captured; endcard + CTA
render; roster rotation advancing; section text/styles computed visible).
Known tooling artifact: the Browser-pane screenshot path intermittently returns
blank frames on this GPU-heavy page while DOM/text/style checks all pass.

## Open for Phase-2b (post-approval)

1. Integrate the film as the flagship intro (replace code-drawn sequence;
   keep `window.__playHero` handoff, session-once, skip, ≤12s cut).
2. Full-vehicle markings render: RP-01 near fins, engine inspection marks,
   EST.2026 — per ROCKY_HULL_MARKINGS.md (Mission Ring is done).
3. Hero loop + 9:16 mobile reframes of shots 3/4/6.
4. Close-QC shot 4's incidental chest marking on the 1080p master.
5. Sound design (tik · chk · whrr · ping) — user-action-gated only.
