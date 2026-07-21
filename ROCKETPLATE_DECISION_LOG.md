# ROCKETPLATE_DECISION_LOG.md

Significant decisions and their rationale. Newest first. Open decisions at top
until resolved. (Mirror major entries to `AI-BOS/DECISION_LOG.md`.)

## RESOLVED — founder ruling 2026-07-21

| # | Decision | Ruling |
|---|---|---|
| O1 | **Character name** | **BYTE.3.3** is canonical. The blueprint's "Lift / L.I.F.T.-3.3" is superseded by BYTE.3.3; reconcile canon + copy to BYTE.3.3 (keep the corrected chest-nameplate render as-is). |
| O2 | **Platform architecture** | **Next.js (App Router) app-first.** Build the real connected platform now; Gate A lives inside it. No throwaway static rework. |
| O3 | **Host** | **Vercel**, connected to `SaaSWrld/RocketPlate` for git-based CD. One host, no duplicates. |
| O4 | **Canonical domain** | `gorocketplate.com` primary; `rocketplate.io` → redirect (default unless founder changes). |
| O5 | **Homepage design contest** | **Run after the backend is back:** 3 art-directed homepage directions per `WEB_DESIGN_LAWS.md`, founder picks the winner. |

## DECIDED

| Date | Decision | Rationale |
|---|---|---|
| 2026-07-21 | **Canonical name = BYTE.3.3; Next.js app-first on Vercel; contest after backend** | Founder ruling on O1–O3, O5 (see above). |
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
