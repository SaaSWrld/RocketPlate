# ADR-004: Two-site split retained through demand validation

**Status:** Accepted · **Date:** 2026-07-18 (formalizes 2026-07-07 design)

## Context
V2 master prompt §0.5-B directs consolidation into one canonical experience.
Current design: flagship (rocketplate.io) = full company/brand site; go
(gorocketplate.com) = stripped ad-landing conversion page. Both write to the same
`leads` table segmented by `landing_page_variant` and `source_domain`.

## Decision
Keep the split through Phase Zero. It is a deliberate variant test: paid/social traffic
lands on go, organic/brand traffic on flagship, and conversion is comparable in the
shared backend. Consolidation now would cost days and destroy the comparison.

## Consequences
- (+) Variant-level conversion data with zero extra tooling.
- (−) Copy/config duplication (accepted per ADR-001).
- Revisit triggers: DNS cutover (add redirects + canonicals — already planned), one
  variant clearly winning (>2x conversion over meaningful volume), or Gate C rebuild.
- SEO safety: distinct canonicals per domain already live; no duplicate-content overlap
  in indexed copy (different page content).
