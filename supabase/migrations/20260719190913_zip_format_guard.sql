-- Audit SEC-04 follow-through: ZIPs must be digits (5-10 chars covers ZIP+4 forms).
-- Belt-and-suspenders under the client esc() fix: a stored ZIP can never carry markup.
alter table public.leads
  add constraint leads_zip_numeric check (zip_code ~ '^\d{3,10}$');
alter table public.restaurant_partner_applications
  add constraint partner_apps_zip_numeric check (zip_code is null or zip_code ~ '^\d{3,10}$');
alter table public.restaurant_referrals
  add constraint referrals_zip_numeric check (zip is null or zip ~ '^\d{3,10}$');