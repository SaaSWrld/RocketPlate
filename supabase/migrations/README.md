# Supabase migrations — versioned source of truth

Project: `uhmyjevtfrynunxfsyof` (us-east-1). These nine files were snapshotted
2026-07-19 from the live `supabase_migrations.schema_migrations` history and are
**byte-identical** (md5-verified) to what production applied, in order.

This closes audit finding P0-4 ("the backend had no versioned source of truth").
Rule going forward (hard rule 3, clarified): every DDL change is a new file here,
applied via Supabase migrations — the repo and the live history must never diverge.

Note: the `send-emails` Edge Function source is not a migration; its deployed code
is documented in BACKEND.md (v2, 2026-07-08). Consider vendoring it under
`supabase/functions/` at the next edit.

Disaster recovery: applying these files in order to a fresh project reproduces the
schema, RLS posture, RPCs, triggers, views, and seeds (launch_zones). Data and the
`admin_credentials` row are not included — re-seed the admin token per BACKEND.md.
