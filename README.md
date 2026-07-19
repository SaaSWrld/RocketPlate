# RocketPlate

Hot-dinner subscription startup, launching in Miami-Dade (Kendall/Pinecrest, ZIP 33186).
This repo is the production launch platform: two static marketing/conversion sites on
Netlify backed by one Supabase lead platform.

**RocketPlate is a long-term software company, not a coding project.** Every change must
leave the repo cleaner, faster, more secure, better documented, and easier to extend.
See [CLAUDE.md](CLAUDE.md) for the engineering constitution and [docs/adr/](docs/adr/)
for why the architecture is the way it is.

## Live surfaces

| Surface | URL | Source |
|---|---|---|
| Company site | https://rocketplate.netlify.app → rocketplate.io | repo root (`index.html`) |
| Conversion site | https://gorocketplate.netlify.app → gorocketplate.com | `gorocketplate/` |
| Partner program + application | `/partners/` | `partners/` |
| Admin dashboard (token-gated) | `/admin/` | `admin/` |
| Subscriber self-service (magic link) | `/account?token=…` | `account/` |
| Legal | `/privacy` `/terms` `/contact` | respective folders |

## Architecture (one paragraph)

Both sites are dependency-light static HTML (no build step — see ADR-001) that talk to
Supabase project `uhmyjevtfrynunxfsyof` exclusively through validated SECURITY DEFINER
RPCs (`upsert_lead`, `submit_partner_application`, … — see ADR-002 and BACKEND.md).
No service-role key exists client-side; people-data tables have no public read policies;
public writes are rate-limited by DB trigger. A Supabase Edge Function (`send-emails`)
drains the `email_events` queue via Resend (dormant until secrets are set). Deploys go
to Netlify (ADR-003); heavy motion (three.js) is desktop-only and idle-loaded.

## Deploying

Preferred (once repo is linked in Netlify UI): `git push` → CI deploys both sites.
Manual fallback: Netlify MCP `deploy-site` op → run the returned npx command from the
site's folder (root for flagship, `gorocketplate/` for go). **Gotcha:** normalize the
returned proxy URL — `//proxy/` → `/proxy/` or uploads fail with 400/404.

## Verifying

`node scripts/smoke.mjs` — checks every public route, security headers, and backend
RPC health against production. Run after every deploy. CI runs it daily
(`.github/workflows/smoke.yml`).

## Documentation map

- [BACKEND.md](BACKEND.md) — schema, RPCs, RLS model, email worker ops
- [LAUNCH-REVIEW.md](LAUNCH-REVIEW.md) — QA state, known issues, launch checklist
- [ROCKETPLATE_CURRENT_STATE_DELTA.md](ROCKETPLATE_CURRENT_STATE_DELTA.md) — verified state vs. V2 master prompt, gate verdicts
- [ROCKETPLATE_FOUNDER_ACTIONS.md](ROCKETPLATE_FOUNDER_ACTIONS.md) — founder-only setup items
- [DNS-AND-ANALYTICS.md](DNS-AND-ANALYTICS.md) — domain cutover + GTM runbook
- [COPY-DECK.md](COPY-DECK.md) / [DESIGN-DIRECTIONS.md](DESIGN-DIRECTIONS.md) / [INTERACTION-DIRECTION.md](INTERACTION-DIRECTION.md) — brand, copy, motion
- [docs/adr/](docs/adr/) — architecture decision records
