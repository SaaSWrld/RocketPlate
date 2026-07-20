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

## Motion shots — v2, one-style re-render (5s, 16:9, sound off; masters in Higgsfield)

Founder rulings 2026-07-20 (bible v1.2): ONE style for the whole sequence
(the canonical MO render style) + interior = command center, never a dining
room. New sequence stills in `brand/canon/reference/seq-*.webp`.

| # | Shot | Model | Start → End | Job | QC |
|---|---|---|---|---|---|
| 1 | Signal (toy Earth → toy coastline) | kling3_0 std | S1 `73b1578e…` → S2 `44cfe0c6…` | `37d3de19-7edb-4ac9-a0a0-36049936a63f` · `20260720_075904` (720p) | Completed; founder review on preview |
| 2 | Descent (toy coastline → Kendall map world) | kling3_0 std | S2 → f3 `f7b7ffde…` | `8ebfeec8-a6fc-4087-b391-0c620c1cbcea` · `20260720_075910` (720p) | Completed; founder review on preview |
| 3 | Flight (canonical Rocky over map world) | kling3_0_turbo 1080p | S3 `8afcf428…` | `7ee08089-7bdf-4c85-88b3-1d1f159c5f71` · `20260720_121936` | Completed; founder review on preview |
| 4 | Hello (MO at the Mission Ring porthole) | kling3_0_turbo 1080p | Mission Ring still `e8d42a30…` | `e8aef471-0f3f-48d7-afde-eb7cc09ab67d` · `20260720_072633` | **KEPT (already one-style). Frame-checked live: the money shot.** Verify faint chest marking on master in close-up |
| 5 | Command Center (MO navigates; hot-hold bays) | kling3_0_turbo 1080p | S4 `d17c5c43…` | `870b6026-f334-48b6-a0f7-52bf5b52c9b9` · `20260720_122047` | Replaces the dining-table cockpit shot per v1.2 ruling |
| 6 | The Reveal (cloche lifts off ribs) | kling3_0_turbo 1080p | f7 `191187d0…` | `3d5663bb-bafb-4e19-8836-3894f54f0641` · `20260720_072404` | **KEPT (photoreal-food exception). Frame-checked live** |

Superseded v1 shots (style-mixed; jobs retained in Higgsfield history only):
signal `2c66a309…`, descent `560c264a…`, flight `0cd5b8b2…`, dining-cockpit
`184d8523…` — retired by the v1.2 style lock / command-center ruling.

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
