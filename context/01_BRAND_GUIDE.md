# 01 — BRAND GUIDE (canon)

Derived 2026-07-19 by pixel-sampling the official asset set (`brand/`). **Uploaded
assets override generated artwork; these docs override assumptions.**

## Logo system (source files in `brand/`, web builds in `assets/`)

| Asset | File | Use |
|---|---|---|
| Master logo (wordmark, rocket-as-O) | `brand/logos/master-logo.png` → web `assets/brand-logo.png` (transparent, 1200w) | Site headers, footers, documents |
| Master + slogan lockup | `brand/logos/master-logo-slogan.png` | Marketing where the slogan must appear |
| Rocket mark (Rocky + Three-Three) | `brand/robot/rocket-robot.png` → web `assets/brand-mark.png` | Square/compact placements, watermark, loaders |
| App icon (3D render, navy tile) | `brand/logos/app-icon.png` → `assets/favicon-64.png`, `assets/apple-touch-icon.png` | Favicons, app buttons |
| 3·2·1·LIFTOFF sticker | `brand/stickers/sticker-321-liftoff.png` | Campaign moments only (see motif rule) |
| Bags / magnets | `brand/bags/`, `brand/magnets/` | Physical system reference; regional variants: South Florida · Miami-Dade · Kendall |

Rules: never recolor the logo; never separate Three-Three from the porthole in the
mark (solo robot art may come later as its own asset); the launch cloud may be used
as a standalone shape in brand colors; keep clear space ≈ the height of the "R".

## Characters (canon)

- **Rocky** — the rocket. THE logo. Orange-red hull, white nose, navy outlines.
- **RKT-3.3 "Three-Three"** — the chef robot in the porthole. White body, navy
  visor/joints, chef's hat, serves a silver cloche. Friendly, confident, never
  frantic. Three-Three is the voice of delight moments (success states, emails,
  Mission Control transmissions); Rocky is the motion.

## Color (sampled from assets — the law)

| Token | Hex | Source | Role |
|---|---|---|---|
| **Brand Navy** | `#0B3468` | wordmark/outlines | Dominant brand color: text, outlines, navy cards. Site tint `#1C3A6E` remains valid for large surfaces; type may deepen toward `#0B3468` |
| **Rocket Orange** (`--launch`) | `#F1502F` | hull/cloud/slogan | THE accent: primary CTAs, launch cloud, display accent words, motifs |
| **Deep Vermillion** (`--launch-deep`) | `#C43A1B` | derived shade | Small-text accent + hover/pressed states (AA: 5.0:1 on cream, 5.3:1 under white) |
| **White** | `#FFFFFF` | nose/robot | Knockouts, text on navy/orange |
| **Steam Cream** | `#FFF8EE` | existing site world | Page background world (kraft-adjacent; harmonizes with bag system) |
| **Flame Orange** | `#F28C28` | app-icon flame core | ONLY inside flame/glow/cloud gradients — never UI chrome |

Retired from UI chrome: crimson `#C0182A` (survives only inside the current hero
film render until re-rendered). No purple, no green, no neon, no random accents.

### Accessibility law (computed, not guessed)
- White on `#F1502F` = 3.54:1 → **AA-large only**: white-on-orange text must be
  ≥18.66px bold (primary CTAs are 1.17rem/700+).
- Small accent text on cream uses `--launch-deep #C43A1B` (5.02:1 ✓ AA).
- Rocket Orange as text on cream: display sizes only (h1/h2 accent spans).
- Body text stays navy (`#16294D`/`#0B3468`, ≥11:1).

## Typography

Rounded · friendly · bold · modern · readable. Never corporate, never generic
startup. Current stack stays: **Fraunces** (display; warm, confident) · **Outfit**
(body; rounded-friendly) · **IBM Plex Mono** (telemetry ONLY: times, ZIPs, counts,
Mission Control). The wordmark's rounded weight is logo-only — don't imitate it in UI
type. Mono never sets human/emotional copy.

## Copy motifs from the physical system (canonical strings)

- **"3·2·1·LIFTOFF!"** — campaign motif, NOT a permanent headline. Allowed: ticker,
  launch/campaign moments, seasonal/city announcements, success celebrations.
- **"YOUR FAVORITE MEALS DELIVERED DAILY"** — the slogan (already the film's hull text).
- **"FUELED BY YOUR ORDERS"** · **"SCAN TO JOIN US"** · **"SEALED HOT AT __:__"** —
  ops-warmth lines; usable on site where honest.
- **"NOW LAUNCHING IN {Kendall | Miami-Dade County | South Florida}"** — regional
  launch treatment.

Voice remains COPY-DECK.md law (banned phrases unchanged).
