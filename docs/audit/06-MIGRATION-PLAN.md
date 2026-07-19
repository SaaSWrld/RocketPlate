<!-- Synthesized from the 2026-07-19 multi-agent consolidation audit. Execution order matters — especially M2 before M8. -->

# 06 — Migration / Consolidation Plan

Split into **launch-critical** (do before/at launch) and **post-launch**. Each milestone
has a validation gate. Engineering milestones are executable now; items marked 🔑 are
founder-gated (external accounts/credentials required).

## A. Launch-critical milestones

### M1 — Version the production backend in the repo *(fixes audit P0-4)*
The single biggest structural gap: production DDL exists only in the hosted Supabase
project. Snapshot every applied migration out of `supabase_migrations.schema_migrations`
into `supabase/migrations/*.sql` in this repo, plus a full current-schema dump as a
baseline file. **Validate:** file count matches live migration count; spot-diff
`upsert_lead` + `rate_limit_guard` DDL against live definitions.

### M2 — DD data-export gate *(fixes P0-1; BLOCKS M8)*
Determine whether DD's Supabase project (`bnqxickbbsunlmuierkc`, Lovable-managed) holds
any real leads from its build week. Anon key cannot read (RLS), so this requires the
Lovable dashboard 🔑. If rows exist in `leads` / `waitlist_signups` /
`restaurant_partner_applications`: export CSV, replay through production `upsert_lead`
/ `submit_partner_application` (preserves validation, referral codes, email queue,
first-touch attribution). **Validate:** replayed count appears in `/admin`; zero-loss
reconciliation. If Lovable shows zero rows, record that and proceed.

### M3 — Harvest DD assets + copy before archive *(P1-10)*
Copy DD's three committed JPGs into `assets/food-life/`; append the five approved copy
lines + step titles to COPY-DECK's reserve bank; note the Lovable-CDN-only assets
(logo SVG, cinematic poster) as unrecoverable-without-Lovable 🔑 if wanted.
**Validate:** images render locally; COPY-DECK diff reviewed.

### M4 — RP launch-critical fixes (from matrix + security)
1. Broken `../assets/logo.png` favicon/logo refs on partners/privacy/terms/contact
   (visible 404 on the partner page header/footer) + no favicon on flagship index.
2. `noindex`-vs-`sitemap.xml` contradiction on privacy/terms.
3. SEC-04 `esc()` on /account · SEC-05 CSV formula guard · SEC-08 `history.replaceState`
   token scrub on /account + /partners.
4. SEC-01: SRI on all four CDN scripts + CSP + HSTS in both netlify.toml files.
5. Stale-doc reconciliation (hard rule 6): BACKEND.md migration list,
   gorocketplate/BUILD-NOTES.md pre-hardening DB section, stale comment at
   gorocketplate/index.html:826, LAUNCH-REVIEW issue 5 (repo IS pushed), delta-report
   stale advisor line (SEC-03 refutation).
6. Write **ADR-005** recording the consolidation decision.
**Validate:** `node scripts/smoke.mjs` green; new favicon/link checks added to smoke;
deploy both sites; re-run smoke against live.

### M5 — Archive DD 🔑
On GitHub (Dreone6 account): archive `rocketplate-daily-delights` read-only with a
final README pointing at ADR-005. Per DD's AGENTS.md warning, disconnect the Lovable
project first (two-way sync). **Do not delete** — it's the Gate-C reference.
**Validate:** repo shows "archived" badge; Lovable site taken offline or repointed
(no live page may keep writing to the dead DB).

### M6 — Decommission the DD Supabase project 🔑 *(AFTER M2 export gate)*
Pause/delete `bnqxickbbsunlmuierkc` in Lovable. Kills SEC-02/SEC-07 by construction
and closes the split-funnel risk (P0-5). **Validate:** DD form (if still reachable
anywhere) fails closed; project no longer accepts writes.

### M7 — Existing founder launch checklist 🔑 *(unchanged from LAUNCH-REVIEW)*
DNS cutover (both domains → the two Netlify sites — and per P0-5, verify which DB each
domain-served page writes to) · netlify.app→domain URL swap + redeploy · Resend
activation · GTM container ID (the funnel is currently unmeasured — UX gap #5 calls
this the highest-leverage single action) · admin token rotation (SEC-06) · formal
legal/TCPA before paid traffic or SMS · one real end-to-end signup per site, then delete.

### M8 — Post-consolidation verification sweep
Full smoke + manual pass of every surviving surface against live deploys; `/admin`
sanity vs expectations; advisors clean; commit + push everything; update memory docs.

## B. Post-launch (Phase 2 backlog)

| Item | Source | Note |
|---|---|---|
| Role-conditional progressive lead form | DD LeadForm pattern | UX gap #3: standardize light capture + /account progressive profiling |
| Merge DD motion-spec ideas into INTERACTION-DIRECTION.md | matrix "merge" row | pacing-script format + microinteraction table; fix the -76/-72px drift |
| Flagship hero mp4 re-encode (16.6MB → go-site ratio) | eng risk | webm-first already mitigates |
| logo.png (182KB) → 5KB SVG | eng grade | referenced on every page |
| ZONES client config generated from `launch_zones` | matrix refactor row | kills the 3-file hand-sync |
| Drop legacy `waitlist` table via named migration | matrix remove row | document in BACKEND.md |
| Custom 404.html on both sites | matrix note | 10-minute nice-to-have |
| Smoke additions: write-path canary, HTML link check | eng grade | link check would have caught the logo 404s |
| /account: email-consent revoke + self-delete | UX /account gap | privacy page already promises it |
| Admin: loading state, sort/filter, replace alert() | UX /admin gap | before a second operator ever exists |
| ForDrivers/ForInvestors sections (if lead volume warrants) | DD harvest | scope, not signal, in Phase Zero |
| Gate C: framework re-eval (DD candidate) + Supabase Auth/RBAC (DD `has_role` reference) + branch rename master→main + LICENSE | ADR-001/002 + completeness P1-7/P2-16 | the scheduled re-architecture moment |

## C. Execution order & gates

```
M1 (backend versioned) ──┐
M3 (harvest)             ├─→ M4 (RP fixes + docs + ADR-005) ─→ deploy + smoke ─→ M8
M2 (export gate 🔑) ─────┴─→ M5 (archive DD 🔑) ─→ M6 (decommission DB 🔑)
M7 (founder checklist 🔑) — parallel, independent
```
Hard rule: **M6 never precedes M2.** The one destructive step in this entire plan is
gated on the data-export check.
