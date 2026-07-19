create extension if not exists pgcrypto with schema extensions;

-- per-record access tokens (unguessable; would be emailed as a magic link)
alter table public.leads add column access_token uuid not null default gen_random_uuid();
alter table public.restaurant_partner_applications add column access_token uuid not null default gen_random_uuid();
alter table public.restaurant_partner_applications add column updated_at timestamptz not null default now();
create trigger trg_partner_apps_updated_at before update on public.restaurant_partner_applications
  for each row execute function public.set_updated_at();

-- ============ admin credentials (bcrypt hash; no plaintext stored) ============
create table public.admin_credentials (
  id int primary key default 1,
  token_hash text not null,
  constraint one_row check (id = 1)
);
alter table public.admin_credentials enable row level security; -- no policies: definer-only

-- ============ subscriber dashboard RPCs (per-token) ============
create or replace function public.get_my_lead(p_token uuid)
returns jsonb language plpgsql security definer set search_path = public as $$
declare l leads%rowtype;
begin
  select * into l from leads where access_token = p_token;
  if not found then raise exception 'not_found'; end if;
  return jsonb_build_object(
    'first_name', l.first_name, 'last_name', l.last_name, 'email', l.email,
    'phone', l.phone, 'zip_code', l.zip_code, 'neighborhood', l.neighborhood,
    'role', l.role, 'interested_plan', l.interested_plan, 'household_type', l.household_type,
    'cuisine_interests', l.cuisine_interests, 'dietary_preferences', l.dietary_preferences,
    'feeding_count', l.feeding_count, 'subscribe_timeline', l.subscribe_timeline,
    'founding_100_interest', l.founding_100_interest, 'sms_consent', l.sms_consent,
    'launch_zone_status', l.launch_zone_status, 'referral_code', l.referral_code,
    'referral_count', l.referral_count, 'created_at', l.created_at
  );
end $$;
revoke all on function public.get_my_lead(uuid) from public;
grant execute on function public.get_my_lead(uuid) to anon;

create or replace function public.update_my_lead(p_token uuid, p jsonb)
returns jsonb language plpgsql security definer set search_path = public as $$
declare l leads%rowtype;
begin
  update leads set
    phone = coalesce(nullif(trim(p->>'phone'),''), phone),
    zip_code = coalesce(nullif(trim(p->>'zip_code'),''), zip_code),
    neighborhood = case when p ? 'neighborhood' then nullif(trim(p->>'neighborhood'),'') else neighborhood end,
    interested_plan = coalesce(nullif(p->>'interested_plan',''), interested_plan),
    household_type = coalesce(nullif(p->>'household_type',''), household_type),
    cuisine_interests = case when p ? 'cuisine_interests'
        then coalesce((select array_agg(x) from jsonb_array_elements_text(p->'cuisine_interests') x), '{}')
        else cuisine_interests end,
    dietary_preferences = case when p ? 'dietary_preferences' then nullif(trim(p->>'dietary_preferences'),'') else dietary_preferences end,
    feeding_count = case when p ? 'feeding_count' then nullif(p->>'feeding_count','') else feeding_count end,
    subscribe_timeline = case when p ? 'subscribe_timeline' then nullif(p->>'subscribe_timeline','') else subscribe_timeline end,
    founding_100_interest = coalesce((p->>'founding_100_interest')::boolean, founding_100_interest),
    sms_consent = coalesce((p->>'sms_consent')::boolean, sms_consent)
  where access_token = p_token
  returning * into l;
  if not found then raise exception 'not_found'; end if;
  return jsonb_build_object('status','updated');
end $$;
revoke all on function public.update_my_lead(uuid, jsonb) from public;
grant execute on function public.update_my_lead(uuid, jsonb) to anon;

-- ============ restaurant partner submit + status RPCs ============
create or replace function public.submit_partner_application(p jsonb)
returns jsonb language plpgsql security definer set search_path = public as $$
declare v_email text := lower(trim(p->>'email')); a restaurant_partner_applications%rowtype;
begin
  if v_email is null or v_email !~* '^\S+@\S+\.\S+$' then raise exception 'invalid_email'; end if;
  if coalesce(trim(p->>'business_name'),'') = '' then raise exception 'invalid_business'; end if;
  if coalesce(trim(p->>'contact_name'),'') = '' then raise exception 'invalid_contact'; end if;
  insert into restaurant_partner_applications (
    business_name, contact_name, email, phone, cuisine_type, address, zip_code,
    website, instagram, pos_system, number_of_locations, can_batch_2_to_4_pm, estimated_capacity, notes
  ) values (
    trim(p->>'business_name'), trim(p->>'contact_name'), v_email,
    nullif(trim(p->>'phone'),''), nullif(trim(p->>'cuisine_type'),''),
    nullif(trim(p->>'address'),''), nullif(trim(p->>'zip_code'),''),
    nullif(trim(p->>'website'),''), nullif(trim(p->>'instagram'),''),
    nullif(trim(p->>'pos_system'),''), (p->>'number_of_locations')::int,
    (p->>'can_batch_2_to_4_pm')::boolean, nullif(trim(p->>'estimated_capacity'),''),
    nullif(trim(p->>'notes'),'')
  ) returning * into a;
  return jsonb_build_object('status','created','access_token', a.access_token);
end $$;
revoke all on function public.submit_partner_application(jsonb) from public;
grant execute on function public.submit_partner_application(jsonb) to anon;

create or replace function public.get_my_application(p_token uuid)
returns jsonb language plpgsql security definer set search_path = public as $$
declare a restaurant_partner_applications%rowtype;
begin
  select * into a from restaurant_partner_applications where access_token = p_token;
  if not found then raise exception 'not_found'; end if;
  return jsonb_build_object(
    'business_name', a.business_name, 'contact_name', a.contact_name, 'email', a.email,
    'phone', a.phone, 'cuisine_type', a.cuisine_type, 'zip_code', a.zip_code,
    'number_of_locations', a.number_of_locations, 'can_batch_2_to_4_pm', a.can_batch_2_to_4_pm,
    'estimated_capacity', a.estimated_capacity, 'status', a.status,
    'created_at', a.created_at, 'updated_at', a.updated_at
  );
end $$;
revoke all on function public.get_my_application(uuid) from public;
grant execute on function public.get_my_application(uuid) to anon;