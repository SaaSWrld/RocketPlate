#!/usr/bin/env node
/**
 * RocketPlate production smoke test.
 * Usage: node scripts/smoke.mjs
 * Exit 0 = all green. Exit 1 = at least one failure (printed).
 * Zero dependencies by design (see CLAUDE.md rule 7).
 */

const FLAG = "https://rocketplate.netlify.app";
const GO = "https://gorocketplate.netlify.app";
const SB = "https://uhmyjevtfrynunxfsyof.supabase.co";
// Publishable key — already public in site HTML; not a secret.
const KEY = "sb_publishable_wsUbTQXWP3dYHyJDbhOmEQ_LSEPOZfO";

const failures = [];
const ok = (label) => console.log(`  ✔ ${label}`);
const fail = (label, detail) => {
  failures.push(label);
  console.error(`  ✘ ${label}${detail ? ` — ${detail}` : ""}`);
};

async function check(label, url, { status = 200, header, headerValue } = {}) {
  try {
    const r = await fetch(url, { method: "GET", redirect: "manual" });
    if (r.status !== status) return fail(label, `expected ${status}, got ${r.status}`);
    if (header) {
      const v = r.headers.get(header);
      if (!v || (headerValue && !v.includes(headerValue)))
        return fail(label, `header ${header}=${v ?? "missing"}`);
    }
    ok(label);
  } catch (e) {
    fail(label, e.message);
  }
}

async function rpc(label, fn, body, validate) {
  try {
    const r = await fetch(`${SB}/rest/v1/rpc/${fn}`, {
      method: "POST",
      headers: {
        apikey: KEY,
        Authorization: `Bearer ${KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    });
    if (!r.ok) return fail(label, `HTTP ${r.status}`);
    const data = await r.json().catch(() => null);
    if (validate && !validate(data)) return fail(label, `unexpected body: ${JSON.stringify(data)}`);
    ok(label);
  } catch (e) {
    fail(label, e.message);
  }
}

console.log("Routes — flagship");
await check("flagship /", `${FLAG}/`);
await check("flagship /partners/", `${FLAG}/partners/`);
await check("flagship /privacy/", `${FLAG}/privacy/`);
await check("flagship /terms/", `${FLAG}/terms/`);
await check("flagship /contact/", `${FLAG}/contact/`);
await check("flagship /admin/", `${FLAG}/admin/`);
await check("flagship robots.txt", `${FLAG}/robots.txt`);
await check("flagship sitemap.xml", `${FLAG}/sitemap.xml`);
await check("flagship hero webm", `${FLAG}/assets/rocketplate-hero.webm`);
await check("flagship assets/logo.png (legacy)", `${FLAG}/assets/logo.png`);
await check("flagship brand logo", `${FLAG}/assets/brand-logo.png`);
await check("flagship favicon-64", `${FLAG}/assets/favicon-64.png`);
await check("go brand logo", `${GO}/assets/brand-logo.png`);
await check("/partner 301 → /partners", `${FLAG}/partner/x`, { status: 301 });

console.log("Routes — go");
await check("go /", `${GO}/`);
await check("go robots.txt", `${GO}/robots.txt`);
await check("go hero webm", `${GO}/assets/rocketplate-hero.webm`);

console.log("Security headers");
await check("flagship nosniff", `${FLAG}/`, { header: "x-content-type-options", headerValue: "nosniff" });
await check("go nosniff", `${GO}/`, { header: "x-content-type-options", headerValue: "nosniff" });
await check("flagship CSP", `${FLAG}/`, { header: "content-security-policy", headerValue: "frame-ancestors 'none'" });
await check("go CSP", `${GO}/`, { header: "content-security-policy", headerValue: "frame-ancestors 'none'" });
await check("flagship HSTS", `${FLAG}/`, { header: "strict-transport-security", headerValue: "max-age" });
await check("assets immutable cache", `${FLAG}/assets/rocketplate-hero-poster.jpg`, { header: "cache-control", headerValue: "immutable" });

console.log("Backend");
await rpc("zip_wait_count RPC", "zip_wait_count", { p_zip: "33186" }, (d) => typeof d === "number");
await check("email worker selftest", `${SB}/functions/v1/send-emails?selftest=1`);

if (failures.length) {
  console.error(`\nSMOKE FAILED: ${failures.length} failure(s): ${failures.join(", ")}`);
  process.exit(1);
}
console.log("\nSMOKE PASSED — all checks green.");
