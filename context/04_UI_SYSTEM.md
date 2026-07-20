# 04 — UI SYSTEM (canon)

Base: the shipped single-file system (ADR-001) + `dash.css` for utility pages.
This doc records the brand-era token evolution. Change tokens, not layouts.

## Design tokens (CSS custom properties, both sites + dash.css)

```css
--navy:        #1C3A6E;  /* large surfaces (unchanged) */
--ink:         #16294D;  /* body text (unchanged) */
--navy-deep:   #0B3468;  /* wordmark-depth navy for headings/logo-adjacent */
--launch:      #F1502F;  /* Rocket Orange: primary CTAs, clouds, display accents */
--launch-deep: #C43A1B;  /* small-text accent, hover/pressed */
--flame:       #F28C28;  /* flame/glow gradient interiors ONLY */
--cream:       #FFF8EE;  /* page world */
--steel:       #BECCD6;  /* on-navy secondary */
--card:        #FFFDF8;
```
Compatibility: legacy `--crimson` aliases to `var(--launch)`; legacy `--orange`
stays = `--flame`; audit every *small-text* crimson/orange use → `--launch-deep`.

## Components

- **Primary CTA** — `--launch` fill, WHITE text at ≥1.17rem/700 (AA-large law,
  see 01), radius 999px, navy-tinted shadow, hover deepen to `--launch-deep` +
  lift −3px, shine sweep stays. One primary per viewport-moment.
- **Secondary CTA** — solid navy, white text. **Ghost** — navy outline.
- **Chips/tags** — mono telemetry stays rocket-blue/steel; launch-orange chips
  only for campaign motifs.
- **Cards** — cream/white, 18–22px radius, soft navy-tinted shadows, orange
  border-tint on hover (now `--launch` at low alpha).
- **Forms** — labels mono-caps, focus ring rocket-blue, errors `--launch-deep`,
  progress bar gradient rocket-blue→`--launch`.
- **Navy cards (Mission Control)** — contained, mono labels, status lights;
  never full-page navy.
- **Logo placement** — `assets/brand-logo.png` in headers (height ~48px) and
  footers (on navy: place the transparent logo on a white/cream rounded chip
  rather than recoloring it — never invert/filter the new logo). Favicon:
  `assets/favicon-64.png` + `assets/apple-touch-icon.png`.

## Grid & rhythm
Existing: max-width 1160–1240, section padding clamp(72px,10vh,120px), 12–22px
radii, negative space is a feature. Don't densify.

## Accessibility floor (non-negotiable)
AA contrast per the computed table in 01; visible focus; `aria-pressed` on
segments; labels on every input; `role="status"` on async results; reduced-motion
parity for every effect; tap targets ≥44px.
