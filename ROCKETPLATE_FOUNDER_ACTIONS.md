# ROCKETPLATE — FOUNDER ACTION CHECKLIST
Exact, minimal founder-controlled items. Everything not on this list is Claude-executable.
**Safe-to-paste guide:** 🟢 = fine to paste into Claude chat · 🔴 = enter ONLY in the provider dashboard, never in chat/code/Git.

## Launch-critical (Gate B)

### 1. DNS cutover — registrar
- **Why:** sites live only on *.netlify.app; emails/OG/canonicals point to real domains.
- **Where:** your registrar for rocketplate.io + gorocketplate.com → records per DNS-AND-ANALYTICS.md §1 (Netlify DNS or A/CNAME).
- **Paste safety:** 🟢 (DNS values aren't secrets).
- **Verify:** https://www.rocketplate.io loads with HTTPS green.
- **Without it:** sites work on netlify.app; email links & SEO point at unlaunched domains.

### 2. Resend — email delivery
- **Why:** confirmations queue but don't send (worker dormant, verified safe).
- **Where:** resend.com → verify sending domain (add their SPF/DKIM records at registrar) → create API key → put `RESEND_API_KEY`, `FROM_EMAIL`, `SITE_URL` in Supabase Dashboard → Edge Functions → send-emails → Secrets.
- **Paste safety:** 🔴 API key goes in Supabase secrets only. Domain/FROM_EMAIL 🟢.
- **Verify:** tell Claude "secrets are set" → I run `?selftest=1` (expect `hasResendKey:true`), then `?dryRun=1`, then real inbox tests + schedule the cron.
- **Without it:** signups still captured; nobody gets emails.

### 3. Approve the security hardening batch — say the word in chat
- **What:** `harden_public_write_paths` migration + go-site referral form switch to the new RPC + delete the labeled e2e test lead. Blocked by session permissions, not by risk — reviewed and reversible.
- **Verify:** I rerun advisors (expect WARNs cleared) + live-test the referral form.

### 4. GitHub re-auth — backup + keep-alive
- **Why:** push to github.com/SaaSWrld/RocketPlate fails on a stale Dreone6 credential; keep-alive workflow (prevents Supabase auto-pause) activates on push.
- **Where:** GitHub Desktop → File → Options → Accounts → sign out/in. Confirm Dreone6 can write to the SaaSWrld repo. Then tell Claude.
- **Paste safety:** 🔴 never paste a PAT into chat; if you make one, put it in Windows Credential Manager via `git push` prompt.
- **Verify:** I push and confirm; then (recommended) link both Netlify sites to the repo (Site → Build & deploy → Link repository; publish dir `/` and `gorocketplate`) so deploys become `git push`.

### 5. Rotate the admin token (2 min)
- **Why:** the current token was pasted in a chat on 2026-07-07.
- **Where:** Supabase → SQL editor → run the UPDATE in BACKEND.md with a NEW token you generate.
- **Paste safety:** 🔴 the new token is yours alone — don't paste it anywhere, including here.
- **Verify:** /admin rejects old token, accepts new.

## Important, not blocking

### 6. GTM container ID — analytics
- **Where:** tagmanager.google.com → create container → paste `GTM-XXXXXXX` ID 🟢 in chat; I wire it into 3 files + document events; publish container with GA4.
- **Without it:** zero analytics (site functions fine).

### 7. Brand asset drop (V2 §7)
- **What exists in repo:** logo.png only. V2 references stickers, bags, magnets, SVGs, slogan variants — none are in the repo.
- **Where:** drop files in `RocketPlate.Build/brand-assets/` (any structure) and tell Claude; I'll build the manifest + integrate.

### 8. Decisions parked for you (answer whenever)
- Buy **rocketplate.com**? (~$10–15/yr; .io is fine for pilot; .com = long-term brand insurance)
- Formal privacy/terms + TCPA review — needed before paid ads/SMS, not before organic waitlist.
- Supabase Pro ($25/mo) — removes pause risk permanently + adds PITR; keep-alive workflow covers us free meanwhile.
