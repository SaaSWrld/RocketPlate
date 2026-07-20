# 06 — BUILD INSTRUCTIONS (canon)

## Working rules
1. Evolve, never redesign. Small verified steps; every change deployed is
   smoke-tested (`node scripts/smoke.mjs`, 24+ checks) and eyeballed on the
   REAL Netlify deploy (previews lie — hard rule 4).
2. Conflict order: context docs > brand assets > generated art > assumptions;
   CLAUDE.md hard rules always win (RPC-only writes, no fake data, migrations
   in `supabase/migrations/`, docs move with code).
3. Never ask "what next": find the weakest experience → improve → repeat.
4. Every DDL change = new file in `supabase/migrations/` + advisors run.
5. Assets: originals in `brand/`, optimized web derivatives in `assets/`
   (immutable-cached). Never ship multi-MB originals to a page.
6. Copy changes obey COPY-DECK.md (voice, banned phrases) — extend the deck in
   the same commit when new canonical lines ship.
7. Analytics: every new interactive element gets a `data-track` name consistent
   with the DNS-AND-ANALYTICS.md dictionary.

## Deploy loop
Edit → local sanity → commit → deploy via Netlify MCP flow (site IDs in
MASTER_OPERATING_CONTEXT §8; run from repo root for flagship, `gorocketplate/`
for the go site — watch for double-slash in generated proxy URLs) → smoke →
live browser verification (console clean, SRI/CSP intact) → push.

## Definition of launch-ready (this era)
- Brand-era logo/palette/motifs live on every surface, AA-verified.
- Cinematic opening shipped within the 02 guardrails.
- Every interactive element polished to the 04/05 systems.
- Founder-gated checklist (MASTER_OPERATING_CONTEXT §5) is the ONLY remaining
  list — engineering never blocks.
