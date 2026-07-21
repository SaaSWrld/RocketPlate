# brand/canon/reference — Canonical renders & generated-asset registry

Provenance and QC record for the canon reference set adopted in
`../MO_CHARACTER_BIBLE.md` v1.1 (founder uploads + approvals, 2026-07-20).
Conflict order unchanged: `brand/canon/` is ABSOLUTE.

## Founder-approved reference renders (staged)

| File | Source (founder's Downloads) | Role | Verdict |
|---|---|---|---|
| `mo-hero-porthole.png` | `MO.3.3.png` | **MO's definitive portrait.** Porthole wave with chrome cloche; glossy warm-white body; navy fingers/joints/accents; chest speech window idle (dark). Look, material and proportion law. | **CANON** |
| `plate-reveal-console.png` | `AI.BeefMeal.png` | **The Reveal style law.** Braised short-rib plate on the navy mission-console table (orange-edged pads, dome lights, chrome cloche, steam, warm key light). Style reference for the plate roster below. | **CANON** |
| `rocky-sticker-3d.png` | `Gemini_Generated_Image_2c9g…` | Sticker-style 3D Rocky, MØ porthole line art. Icon/badge contexts. | Approved direction |
| `rocky-sticker-flat.png` | `Gemini_Generated_Image_rrp5…` | Flat vector Rocky sticker. Decal/icon contexts. | Approved direction |
| `app-icon-art.png` | `ChatGPT Image Jul 18 09_48…` | App-icon art (rounded square, coral clouds). | Approved direction |
| `app-icon-iphone-mockup.png` | `Gemini_Generated_Image_qlnzj6…` | The icon in situ on an iPhone home screen. | Approved direction |

**Rejected MO variants** (founder selection = navy-accent build; never use):
`Moe.withoutbluetrim.png`, `Moe.Prototype.Porcelain.png`,
`MO.Prototype.Toylookfeel.png` — remain in Downloads, deliberately unstaged.

**Not yet staged:** the "Rocky liftoff over circuit-board launchpad" 3D
renders shown in founder chat 2026-07-20 (rocket over glowing route-map
board). Drop the exports into this folder when available.

## Chest nameplate correction — `BYTE.3.3` (2026-07-21, founder directive)

Founder directive: *"fix his name plate and center it in the middle etched to
his body 'BYTE.3.3'."* Prior renders placed the plate low-left and clipped it
because the porthole/waving pose occludes the center chest. Fixed by
generating **front-facing, full-torso** portraits from the clean MO reference
(`mo-hero-porthole.png` → ref media `9a8c4126-e2bf-4953-a014-3eb69e843ba1`).

| File | Job | QC |
|---|---|---|
| `byte-3.3-portrait.webp` | `e07f4611` (front-facing, 1:1, 2K) | **PASS / CANON** — full body; **`BYTE.3.3` etched dead-center** in a framed, recessed tone-on-tone nameplate; face keeps eyes+smile; chef hat + navy accents on shoulders/elbows/knees/fingers/neck intact. Selected over `6090ae5b` and `a7832293` (both correct but upper-torso only, plate unframed). |

**Nameplate law:** the chest **nameplate** reads `BYTE.3.3`, centered, engraved
into the chassis as a recessed tone-on-tone plate (never a printed sticker or
colored decal). This is distinct from the **chest speech window** (which
displays live status/speech, e.g. `READY`) and the black **`MØ 3.3` badge**.
Naming note flagged to founder: canon board names the character *Moshi 3.3 /
MØ 3.3*; the physical nameplate stamp is `BYTE.3.3` per this directive — the
two coexist (product line vs unit stamp) unless the founder rules otherwise.

## Generated canon stills (2026-07-20, from `mo-hero-porthole.png` ref media `6c351b8b-bbb8-4329-a94f-6960be374d0e`)

| File | Job | QC |
|---|---|---|
| `mission-ring.webp` | `e8d42a30-7ab4-44ca-a73b-dcefdc5ab26a` (stamp `20260720_071929`) | **PASS** — GOROCKETPLATE.COM engraved tone-on-tone around the ring, spelled exactly; luxury-lens feel per ROCKY_HULL_MARKINGS.md |
| `mo-ready-portrait.webp` | `aca6ad4d-d5e9-49b4-928d-59d14d10eb99` (stamp `20260720_072555`) | **PASS** — face keeps eyes+smile; chest window shows READY; black MØ 3.3 badge beside it. First full bible-v1.1 render |
| — (rejected) | `0dff068b-b9e7-49e3-acdd-6fdd93d7e11c` | REJECT — rendered READY across the FACE display (violates v1.1 two-displays law); badge was correct |

## Sequence stills — one-style re-render (v1.2 style lock, 2026-07-20)

Founder rulings: ONE style for all animation (the canonical MO render style)
and the rocket interior is a **command center, never a dining room**. These
four supersede the Phase-1 photoreal/decal frames for sequence use:

| File | Job | QC |
|---|---|---|
| `seq-earth.webp` | `73b1578e-fce0-4314-bac7-ae95b17d1c9a` · `20260720_075608` | **PASS** — porcelain toy Earth, signal arc lands on Florida |
| `seq-coastline.webp` | `44cfe0c6-5763-41fc-a88a-1f4df116c656` · `20260720_075611` | **PASS** — miniature toy Miami, orange zone boundary |
| `seq-rocky-flight.webp` | `8afcf428-9cf6-4c09-8cf1-fd0645576771` · `20260720_075617` | **PASS** — canonical cream-hull Rocky, real 3D MO in porthole (no decal) |
| `seq-command-center.webp` | `d17c5c43-7d4d-45b2-ba83-f766a27dd2d8` · `20260720_075901` | **PASS** — MO navigating; cloche hot-hold bays; all-orange interface. (First take `7d8b9d35…` REJECTED: cyan HUD violated palette law + pixel-dot eyes) |

## The Reveal — plate roster (generated 2026-07-20)

Seven 2K masters (2752×1536, model `nano_banana_pro` → `nano_banana_2`,
`resolution: 2k`, `aspect_ratio: 16:9`), all generated from
`plate-reveal-console.png` as reference (Higgsfield media
`32b03a96-3880-4450-84f4-b0bb562fcbc9`). Browsable previews in `plates/`
(~95 KB webp each); masters stay in Higgsfield.

Master URL pattern:
`https://d8j0ntlcm91z4.cloudfront.net/user_3G8cbmmifcWVqzSC8KibofcyHUT/hf_<stamp>_<jobid>.png`
(append `_min.webp` instead of `.png` for the preview build).

| Plate | Job ID | Stamp | QC |
|---|---|---|---|
| Smash burger tower + crinkle fries | `b2a2c785-e80e-4d3a-aa1f-de9fb58f8df3` | `20260720_065635` | PASS |
| Street tacos (carne asada, cotija, charred lime) | `7f6ebd24-c42c-4dc5-8158-a150b330f19c` | `20260720_065640` | PASS |
| Italian — pappardelle al ragù, parmesan, basil | `71f3c680-ec45-477a-bb03-5c0054a2644c` | `20260720_065643` | PASS |
| American ribs & BBQ (glazed rack, cornbread, slaw) | `3ade7142-5d1e-4049-8489-7694cc0d851f` | `20260720_065646` | PASS |
| Asian — teriyaki salmon, jasmine rice, bok choy, gyoza | `bd67b717-b7a4-498e-8d16-74d823301776` | `20260720_065656` | PASS |
| Mediterranean — souvlaki, hummus, pita, olives, feta salad | `bb3d2c05-1bda-4418-92cd-c87d03d3c1fd` | `20260720_065659` | PASS |
| Cuban — ropa vieja, rice, black beans, maduros¹ | `ee966e8f-c6b9-4e25-8d8c-f436f3c92530` | `20260720_065703` | PASS |

¹ Cuban plate is an ELT addition beyond the founder's six (Miami-local
signal), flagged per no-silent-additions practice. The short-rib dish in the
CANON reference render itself is an eighth look available to the rotation.

QC (2026-07-20, every frame inspected): zero generated text/letters/logos
(experience-law §"no generated text" respected); style locked across the set
— same camera, same console, same steam behavior — which is exactly what the
Phase-2 crossfade rotation needs.

**Accepted deviations vs the CANON reference:** camera pulled back slightly;
plate rim reads as a bolder navy band; dome lights slightly more saturated.
Consistent within the set → accepted. The blurred human-style arm lifting
the cloche (top right) is inherited from the reference; per bible v1.1 the
lifter in Phase-2 *motion* work should be MO's glossy white hand with navy
fingers (or out of frame entirely).

## Regeneration recipe (new roster dishes)

`generate_image` · model `nano_banana_pro` · `resolution: 2k` ·
`aspect_ratio: 16:9` · media `{value: 32b03a96-3880-4450-84f4-b0bb562fcbc9,
role: image}` · prompt = "Using the reference image: keep the exact same
composition …" scaffold (see any job above via `job_display`), swapping only
the dish description. Always end with the no-text clause. Cost: 2 credits.
Roster law: only dishes a real neighborhood kitchen would serve.

## Honesty law

These are **concept renders** — never present them as photography of partner
dishes, menu items, or "tonight's dinner" claims. Real partner photography
replaces them at launch (hard rule 5).
