# ROCKETPLATE_DECISION_LOG.md

Significant decisions and their rationale. Newest first. Open decisions at top
until resolved. (Mirror major entries to `AI-BOS/DECISION_LOG.md`.)

## OPEN — awaiting founder ruling (2026-07-21)

| # | Decision | Options | Recommendation |
|---|---|---|---|
| O1 | **Character name** | `Lift` (L.I.F.T.-3.3, blueprint) vs `MO/MØ` vs `BYTE.3.3` (repo canon) vs other | Pick one now; reconcile all canon docs + assets to match. (Blueprint Q46.) |
| O2 | **Platform architecture** | (i) Next.js app-first; (ii) static Gate A now + app in parallel | (i) if we want it done right once; (ii) if "live tonight" matters more. See AUDIT §6. |
| O3 | **Host** | Vercel vs Netlify (ONE) | Vercel if Next.js (blueprint assumes it); Netlify fine for static Gate A. No duplicates. |
| O4 | **Canonical domain** | `gorocketplate.com` primary, `rocketplate.io` redirect | Confirm both registered + where DNS is managed. |
| O5 | **Homepage design contest** | N agent-built variants to compare | Run 3 art-directed directions after backend is back; founder picks winner. |

## DECIDED

| Date | Decision | Rationale |
|---|---|---|
| 2026-07-21 | **Restart clean from `SaaSWrld/RocketPlate`; treat blueprint V4 as source of truth** | Founder teardown; repo is the one surviving asset. Blueprint staged at `docs/`. |
| 2026-07-21 | **AI-BOS is read-first via a pointer (Option A), not copied per-project** | Single source of truth, no duplication (founder's "no duplicates" rule). Pointer added to `CLAUDE.md`. |
| 2026-07-21 | **Adopt `WEB_DESIGN_LAWS.md` as enforceable front-end design law** | Fixes the recurring "generic AI" output by giving Claude explicit design context (the Jack Roberts lesson). |
| 2026-07-21 | **Audit before rebuild (Prompt 1)** | Blueprint priority rule 1 + AI-BOS "audit first." Produced this doc set instead of redesigning. |
| 2026-07-18 | **RPC-only public writes; no secrets client-side** | Security constitution (ADR-002). Carried forward. |
| 2026-07-18 | **Phase Zero: validate demand via waitlist before building payments** | AI-BOS North Star; Gate C billing stays flag-off. |

## Notable prior decision reversed by teardown

- The **Vercel-git reconnect** path (point the domain's Vercel project at
  `SaaSWrld`) is moot — those projects were deleted. New host + DNS decision (O3/O4)
  supersedes it.
