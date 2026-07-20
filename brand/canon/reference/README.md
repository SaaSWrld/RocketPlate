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

## Generated canon stills (2026-07-20, from `mo-hero-porthole.png` ref media `6c351b8b-bbb8-4329-a94f-6960be374d0e`)

| File | Job | QC |
|---|---|---|
| `mission-ring.webp` | `e8d42a30-7ab4-44ca-a73b-dcefdc5ab26a` (stamp `20260720_071929`) | **PASS** — GOROCKETPLATE.COM engraved tone-on-tone around the ring, spelled exactly; luxury-lens feel per ROCKY_HULL_MARKINGS.md |
| `mo-ready-portrait.webp` | `aca6ad4d-d5e9-49b4-928d-59d14d10eb99` (stamp `20260720_072555`) | **PASS** — face keeps eyes+smile; chest window shows READY; black MØ 3.3 badge beside it. First full bible-v1.1 render |
| — (rejected) | `0dff068b-b9e7-49e3-acdd-6fdd93d7e11c` | REJECT — rendered READY across the FACE display (violates v1.1 two-displays law); badge was correct |

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
