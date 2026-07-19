# ADR-001: Static, dependency-light sites until Gate C

**Status:** Accepted · **Date:** 2026-07-18

## Context
Both public sites are single-file static HTML with inline CSS/JS, CDN-loaded GSAP/Lenis,
and idle-loaded three.js. There is no framework, bundler, or package.json. The V2 master
prompt and long-term company directive raise the question: migrate to a framework now?

## Decision
Stay static until Gate C (paid subscriptions) begins. At that point the product needs
authenticated accounts, Stripe webhooks, and server logic — the natural moment to adopt
a framework (likely Next.js or similar) and re-evaluate hosting (ADR-003) in one move,
instead of migrating twice.

## Consequences
- (+) Zero build/dependency maintenance during validation; nothing to break; instant deploys.
- (+) Page weight and TTFB stay minimal — conversion-critical.
- (−) Shared copy/config duplicated between the two sites' HTML — tolerated while the
  surface is 2 pages + dashboards; revisit if a third surface appears.
- (−) No component reuse. Accepted: dashboards already share `dash.css`.
- Trigger to revisit: Gate C build start, a third public surface, or copy drift causing
  a real inconsistency bug.
