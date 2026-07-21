# ROCKETPLATE_LAUNCH_CHECKLIST.md — Gate A (public discovery + lead capture)

Derived from blueprint §28 "Definition of Done." Gate A is the only near-term
launch target; B/C/D are in `ROCKETPLATE_PHASE_2_BACKLOG.md`. Check items only
when verified on the **real deploy** (constitution rule 4).

## Infrastructure relaunch (blocking — all deleted 2026-07-21)

- [ ] New Supabase project created (record ref + region)
- [ ] 10 migrations applied cleanly, in order
- [ ] Security advisors run, zero criticals
- [ ] `send-emails` edge function recreated **and committed to repo**
- [ ] Resend API key set in Supabase secrets (never in Git)
- [ ] New project ref + publishable key swapped in `index.html`, `scripts/smoke.mjs`, dashboards
- [ ] One host chosen; Gate A deployed
- [ ] Domain repointed (founder DNS) to the chosen host
- [ ] Canonical domain + redirects configured

## Gate A functionality (blueprint §28)

- [ ] Public pages load; mobile works
- [ ] ZIP service-area check returns correct served / near / unsupported states
- [ ] Explorer waitlist saves **real** Supabase data (no fake counts)
- [ ] Explorer confirmation email delivers (branded, correct sender domain)
- [ ] Duplicate email+ZIP updates the record, no uncontrolled duplicates
- [ ] Founding Crew card-on-file via Stripe SetupIntent — **no charge** (Gate A scope: card saved, "you have not been charged" shown) *(may defer to Gate-A.2 if Stripe not yet configured — flag explicitly)*
- [ ] Founding confirmation email delivers
- [ ] Restaurant application saves + confirms
- [ ] Restaurant waitlist saves + confirms
- [ ] Admin can see all submissions (real records)
- [ ] Legal + support links work (privacy, terms, subscription/cancellation disclosures, contact)
- [ ] Analytics events fire (view, ZIP, waitlist, founding, restaurant)
- [ ] No critical dead ends; no exposed secrets; accessibility basics pass (§8 design law)

## Quality gates (constitution + design law)

- [ ] `node scripts/smoke.mjs` green against the real deploy
- [ ] WCAG AA on all text/UI (no white-on-bright-orange failures)
- [ ] Reduced-motion + data-saver paths work; 3D has poster/video fallback, no blank canvas
- [ ] Performance: LCP fast, media lazy/gated, no CLS
- [ ] No fake data anywhere; representative imagery labeled

## Founder actions gating Gate A

- [ ] Approve new Supabase project
- [ ] Provide Resend API key
- [ ] Choose host; later change DNS
- [ ] Rule on open decisions O1–O5 (`ROCKETPLATE_DECISION_LOG.md`)
- [ ] (If Founding Crew card-on-file is in Gate A) provide Stripe **test** keys first
