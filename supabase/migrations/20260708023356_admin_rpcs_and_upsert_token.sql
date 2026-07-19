-- admin auth helper: bcrypt compare against stored hash
create or replace function public.is_admin(p_token text)
returns boolean language sql stable security definer set search_path = public, extensions as $$
  select exists(select 1 from admin_credentials where token_hash = crypt(p_token, token_hash))
$$;

-- ============ admin dashboard aggregates (token-gated) ============
create or replace function public.admin_dashboard(p_token text)
returns jsonb language plpgsql security definer set search_path = public as $$
begin
  if not is_admin(p_token) then raise exception 'unauthorized'; end if;
  return jsonb_build_object(
    'totals', (select jsonb_build_object(
        'leads', count(*),
        'founding_interest', count(*) filter (where founding_100_interest),
        'sms_opt_in', count(*) filter (where sms_consent),
        'last_7d', count(*) filter (where created_at > now() - interval '7 days')
      ) from leads),
    'by_role', (select coalesce(jsonb_object_agg(role, c), '{}') from (select role, count(*) c from leads group by role) t),
    'by_zone', (select coalesce(jsonb_object_agg(coalesce(launch_zone_status,'unknown'), c), '{}') from (select launch_zone_status, count(*) c from leads group by launch_zone_status) t),
    'by_zip', (select coalesce(jsonb_agg(row_to_json(x)), '[]') from admin_leads_by_zip x),
    'cuisine', (select coalesce(jsonb_agg(row_to_json(x)), '[]') from admin_cuisine_demand x),
    'zones', (select coalesce(jsonb_agg(row_to_json(x)), '[]') from admin_zone_stats x),
    'by_variant', (select coalesce(jsonb_object_agg(coalesce(landing_page_variant,'unknown'), c), '{}') from (select landing_page_variant, count(*) c from leads group by landing_page_variant) t),
    'partner_apps', (select count(*) from restaurant_partner_applications),
    'partner_by_status', (select coalesce(jsonb_object_agg(status, c), '{}') from (select status, count(*) c from restaurant_partner_applications group by status) t),
    'partners', (select coalesce(jsonb_agg(row_to_json(r) order by (r).created_at desc), '[]')
                 from (select id, created_at, business_name, contact_name, email, phone, cuisine_type, zip_code, number_of_locations, can_batch_2_to_4_pm, status from restaurant_partner_applications) r),
    'recent_leads', (select coalesce(jsonb_agg(row_to_json(t)), '[]')
                     from (select first_name, last_name, email, zip_code, role, interested_plan, launch_zone_status, founding_100_interest, referral_count, source_domain, created_at
                           from leads order by created_at desc limit 50) t)
  );
end $$;
revoke all on function public.admin_dashboard(text) from public;
grant execute on function public.admin_dashboard(text) to anon;

-- ============ admin CSV export (full rows, token-gated) ============
create or replace function public.admin_export_leads(p_token text)
returns setof leads language plpgsql security definer set search_path = public as $$
begin
  if not is_admin(p_token) then raise exception 'unauthorized'; end if;
  return query select * from leads order by created_at desc;
end $$;
revoke all on function public.admin_export_leads(text) from public;
grant execute on function public.admin_export_leads(text) to anon;

create or replace function public.admin_export_partners(p_token text)
returns setof restaurant_partner_applications language plpgsql security definer set search_path = public as $$
begin
  if not is_admin(p_token) then raise exception 'unauthorized'; end if;
  return query select * from restaurant_partner_applications order by created_at desc;
end $$;
revoke all on function public.admin_export_partners(text) from public;
grant execute on function public.admin_export_partners(text) to anon;

-- ============ upsert_lead: also return the subscriber's access_token ============
create or replace function public.upsert_lead(p jsonb)
returns jsonb language plpgsql security definer set search_path = public as $$
declare
  v_email text := lower(trim(p->>'email'));
  v_first text := trim(p->>'first_name');
  v_last  text := trim(p->>'last_name');
  v_zip   text := trim(p->>'zip_code');
  v_row   leads%rowtype;
  v_created boolean;
begin
  if v_email is null or v_email !~* '^\S+@\S+\.\S+$' then raise exception 'invalid_email'; end if;
  if v_first is null or v_first = '' or v_last is null or v_last = '' then raise exception 'invalid_name'; end if;
  if v_zip is null or char_length(v_zip) < 3 then raise exception 'invalid_zip'; end if;
  if coalesce(p->>'email_consent','false') <> 'true' then raise exception 'consent_required'; end if;

  insert into leads (
    first_name, last_name, email, phone, zip_code, neighborhood, role,
    interested_plan, household_type, cuisine_interests, dietary_preferences,
    feeding_count, subscribe_timeline, founding_100_interest, sms_consent,
    email_consent, referral_source, referred_by, referral_code,
    launch_zone_status, utm_source, utm_medium, utm_campaign,
    user_agent, landing_page_variant, source_domain, notes
  ) values (
    v_first, v_last, v_email,
    nullif(trim(p->>'phone'), ''), v_zip, nullif(trim(p->>'neighborhood'), ''),
    coalesce(nullif(p->>'role',''), 'other'),
    coalesce(nullif(p->>'interested_plan',''), 'not_sure'),
    coalesce(nullif(p->>'household_type',''), 'other'),
    coalesce((select array_agg(x) from jsonb_array_elements_text(coalesce(p->'cuisine_interests','[]'::jsonb)) x), '{}'),
    nullif(trim(p->>'dietary_preferences'), ''), nullif(p->>'feeding_count',''), nullif(p->>'subscribe_timeline',''),
    coalesce((p->>'founding_100_interest')::boolean, false),
    coalesce((p->>'sms_consent')::boolean, false), true,
    nullif(p->>'referral_source',''), nullif(p->>'referred_by',''), nullif(p->>'referral_code',''),
    nullif(p->>'launch_zone_status',''),
    nullif(p->>'utm_source',''), nullif(p->>'utm_medium',''), nullif(p->>'utm_campaign',''),
    left(p->>'user_agent', 400), nullif(p->>'landing_page_variant',''),
    nullif(p->>'source_domain',''), nullif(trim(p->>'notes'), '')
  )
  on conflict ((lower(email))) do update set
    first_name = excluded.first_name, last_name = excluded.last_name,
    phone = coalesce(excluded.phone, leads.phone), zip_code = excluded.zip_code,
    neighborhood = coalesce(excluded.neighborhood, leads.neighborhood),
    role = excluded.role, interested_plan = excluded.interested_plan, household_type = excluded.household_type,
    cuisine_interests = case when excluded.cuisine_interests = '{}' then leads.cuisine_interests else excluded.cuisine_interests end,
    dietary_preferences = coalesce(excluded.dietary_preferences, leads.dietary_preferences),
    feeding_count = coalesce(excluded.feeding_count, leads.feeding_count),
    subscribe_timeline = coalesce(excluded.subscribe_timeline, leads.subscribe_timeline),
    founding_100_interest = excluded.founding_100_interest, sms_consent = excluded.sms_consent,
    launch_zone_status = excluded.launch_zone_status, notes = coalesce(excluded.notes, leads.notes)
  returning * into v_row;

  v_created := (v_row.created_at = v_row.updated_at);
  return jsonb_build_object(
    'status', case when v_created then 'created' else 'updated' end,
    'referral_code', v_row.referral_code,
    'launch_zone_status', v_row.launch_zone_status,
    'access_token', v_row.access_token
  );
end $$;
revoke all on function public.upsert_lead(jsonb) from public;
grant execute on function public.upsert_lead(jsonb) to anon;