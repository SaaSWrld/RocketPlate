# ADR-003: Netlify stays canonical; Vercel deferred to Gate C re-evaluation

**Status:** Accepted · **Date:** 2026-07-18

## Context
V2 master prompt §0.6/§29 directs a Netlify→Vercel migration. On 2026-07-18 the Netlify
pipeline was restored (Personal plan), both sites deployed and verified, and rollback
exists via Netlify deploy history.

## Decision
Reject migration for the static phase: it adds cutover risk and hours of work with zero
customer value for static sites during War Room. Netlify remains canonical. The platform
question reopens automatically when Gate C introduces server-side needs (framework,
Stripe webhooks, auth) — evaluated then on merits (Vercel, Netlify functions, or other),
as ONE migration together with ADR-001's framework adoption.

## Consequences
- (+) No churn during validation; deploy story just fixed stays fixed.
- (+) One platform migration later instead of two.
- (−) If Gate C chooses Vercel, netlify.toml headers/redirects must be ported (small).
- Interim hardening: link Netlify sites to GitHub for CI deploys; keep deploy history
  as rollback; document manual deploy fallback in README.
