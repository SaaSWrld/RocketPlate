# RocketPlate — DNS Cutover & Analytics Runbook

Everything needed to point the real domains at the live Netlify sites and turn on
Google Tag Manager. Nothing here is done automatically — these are the steps that
need your registrar login and your GTM/Resend accounts.

| Domain | Netlify site | Site ID | Primary |
|---|---|---|---|
| rocketplate.io | `rocketplate` | `fa64163e-5ea6-4062-95ce-e7fe87f519a9` | **www**.rocketplate.io |
| gorocketplate.com | `gorocketplate` | `f416765d-344f-470c-9332-748f1e7273de` | **www**.gorocketplate.com |

The code's canonical/OG tags already use the `www` hosts, so make `www` primary and
let the apex (`rocketplate.io`) redirect to it — Netlify does this automatically.

---

## 1. DNS — pick ONE option per domain

### Option A — Netlify DNS (easiest, recommended)
Delegates the whole zone to Netlify; it manages apex + www + auto-HTTPS for you.
1. Netlify → your site → **Domain management → Add a domain** → enter `rocketplate.io`.
2. Choose **"Set up Netlify DNS"** and follow the wizard.
3. Netlify shows 4 nameservers, e.g. `dns1.p0X.nsone.net` … `dns4.p0X.nsone.net`.
4. At your **registrar**, replace the domain's nameservers with those 4.
5. Repeat for `gorocketplate.com` on the `gorocketplate` site.
6. Wait for propagation (minutes–24h). HTTPS provisions automatically.

### Option B — Keep your current DNS host (add records manually)
At your DNS provider, for **each** domain:

| Record | Host/Name | Type | Value |
|---|---|---|---|
| Apex | `@` | `A` | `75.2.60.5` |
| Apex (if your host supports it, prefer over A) | `@` | `ALIAS`/`ANAME` | `rocketplate.netlify.app` |
| www | `www` | `CNAME` | `rocketplate.netlify.app` |

For gorocketplate.com use `gorocketplate.netlify.app` as the CNAME/ALIAS target.
Then in Netlify → Domain management → **Add domain** (both apex and www), and set
**www as primary**. Netlify issues Let's Encrypt HTTPS once DNS resolves (can take
up to ~an hour after records propagate).

> `75.2.60.5` is Netlify's documented apex load-balancer IP. Use ALIAS/ANAME instead
> of the A record if your provider offers it (survives IP changes).

### Verify
- `https://www.rocketplate.io` and `https://www.gorocketplate.com` load with a valid padlock.
- `http://rocketplate.io` redirects to `https://www.rocketplate.io`.
- Netlify Domain management shows "Netlify certificate" active for both.

---

## 2. Point the code at the real domains (at cutover, not before)

The sites currently use `*.netlify.app` for cross-site and profile links (so they
work **today**). Once DNS + HTTPS are live, run this once from the repo root to swap
every reference, then redeploy:

```powershell
# from C:\Users\dreon\RocketPlate.Build
Get-ChildItem -Recurse -Include *.html | ForEach-Object {
  (Get-Content $_ -Raw) `
    -replace 'https://rocketplate\.netlify\.app','https://www.rocketplate.io' `
    -replace 'https://gorocketplate\.netlify\.app','https://www.gorocketplate.com' |
  Set-Content $_ -NoNewline
}
```

Affected references (for review): the "finish your profile" + footer links and the
account-profile link on rocketplate.io; the logo/footer/back links on `/partners`;
the join/back/`SITE` links on `/account`; the partner CTA, footer, and account link
on gorocketplate. `gorocketplate`'s referral `SITE_URL` already points at
`https://www.gorocketplate.com/`.

Then redeploy both (same commands you've used): deploy the root folder to the
`rocketplate` site and the `gorocketplate/` folder to the `gorocketplate` site.

Also update the email worker's link base:
- Supabase → Edge Functions → `send-emails` → Secrets → set `SITE_URL=https://www.rocketplate.io`.

---

## 3. Google Tag Manager

The GTM loader is already installed on all three public surfaces (rocketplate.io
home, `/partners`, gorocketplate.com), **guarded** so it does nothing until you add
your container ID. `dataLayer` is already collecting events in the meantime.

### Activate
1. Create a GTM container at tagmanager.google.com (Web). Copy the ID `GTM-XXXXXXX`.
2. Replace `GTM-XXXXXXX` with your real ID in the `<head>` GTM block of **three files**:
   `index.html`, `partners/index.html`, `gorocketplate/index.html`.
   (One line each; search `GTM-XXXXXXX`.)
3. Redeploy both sites.
4. In GTM, connect GA4 (add your GA4 Measurement ID via a GA4 Configuration tag) and
   publish the container.

### Custom events already firing to `dataLayer` (build GTM triggers on these)
All are pushed as `{ event: "rp_<name>", ...props, variant }`:

| Event | Fires when | Useful props |
|---|---|---|
| `rp_lead_created` | new waitlist signup | `zone`, `role`, `plan` |
| `rp_lead_updated` | existing email resubmits | `zone` |
| `rp_success_shown` | success state shown (go) | `zone`, `duplicate` |
| `rp_form_submit` / CTA clicks | any `[data-track]` click (go) | — |
| `rp_zip_result` / `rp_zip_console` | ZIP checker used | `zip`, `zone` |
| `rp_quick_capture_submit` | hero quick capture (go) | `has_zip`, `has_email` |
| `rp_copy_referral`, `rp_share_*` | referral link copied / shared | — |
| `rp_restaurant_referred` | restaurant suggested in success (go) | — |

Recommended GA4 conversions: `rp_lead_created` (primary) and `rp_success_shown`.
The `variant` prop (`rocketplate-io-v1` / `gorocketplate-v1`) lets you compare the
two sites' funnels; `zone` lets you segment by launch priority.

> Optional: GTM's `<noscript>` iframe fallback was omitted to keep activation a
> single-line edit. If you want no-JS coverage, paste the standard
> `<noscript>…ns.html?id=GTM-XXXXXXX…</noscript>` right after each `<body>`.

---

## 4. Post-cutover checklist
- [ ] Both domains resolve over HTTPS, apex → www redirect works
- [ ] Ran the netlify.app → real-domain swap + redeployed both sites
- [ ] `send-emails` `SITE_URL` secret updated
- [ ] GTM ID set in all 3 files, container published, GA4 connected
- [ ] Submitted one real test signup on each site; confirmed the row in `/admin`
      and (once Resend is keyed) the confirmation email; then deleted the test row
- [ ] Rotated the admin token (see BACKEND.md) so the chat-shared one is retired
