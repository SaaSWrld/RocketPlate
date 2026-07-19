-- Close unused raw anon INSERT paths. All frontend writes go through
-- SECURITY DEFINER RPCs (upsert_lead / submit_partner_application), which
-- bypass RLS and are unaffected by dropping these policies.
drop policy if exists "anon can join leads waitlist" on public.leads;
drop policy if exists "anon can join waitlist" on public.waitlist;
drop policy if exists "anon can apply as partner" on public.restaurant_partner_applications;

-- Validated RPC for restaurant referrals, replacing the raw table insert
-- used by gorocketplate. Rate limiting still applies via the BEFORE INSERT
-- trigger on the table (fires inside this function too).
create or replace function public.refer_restaurant(p jsonb)
returns jsonb
language plpgsql
security definer
set search_path to 'public'
as $$
declare
  v_name  text := trim(coalesce(p->>'restaurant_name',''));
  v_zip   text := nullif(trim(coalesce(p->>'zip','')), '');
  v_email text := nullif(lower(trim(coalesce(p->>'referrer_email',''))), '');
begin
  if length(v_name) < 2 or length(v_name) > 120 then
    raise exception 'invalid_name' using hint = 'Restaurant name must be 2-120 characters.';
  end if;
  if v_zip is not null and v_zip !~ '^\d{5}$' then
    v_zip := null;
  end if;
  if v_email is not null and (length(v_email) > 320 or v_email !~ '^[^@\s]+@[^@\s]+\.[^@\s]+$') then
    v_email := null;
  end if;
  insert into public.restaurant_referrals (restaurant_name, zip, referrer_email)
  values (v_name, v_zip, v_email);
  return jsonb_build_object('ok', true);
end $$;

revoke all on function public.refer_restaurant(jsonb) from public;
grant execute on function public.refer_restaurant(jsonb) to anon, authenticated;

drop policy if exists "anon can refer restaurants" on public.restaurant_referrals;

-- Pin search_path on the one remaining mutable-search-path function (advisor WARN)
alter function public.set_updated_at() set search_path = 'public';