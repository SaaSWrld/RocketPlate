-- ============ leads: platform fields ============
alter table public.leads add column updated_at timestamptz not null default now();
alter table public.leads add column source_domain text check (char_length(source_domain) <= 120);
alter table public.leads add column referral_count integer not null default 0;
alter table public.leads rename column wants_founding_100 to founding_100_interest;

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end $$;
create trigger trg_leads_updated_at before update on public.leads
  for each row execute function public.set_updated_at();

-- referral graph: signing up with someone's code bumps their count
create or replace function public.bump_referral_count()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if new.referred_by is not null then
    update leads set referral_count = referral_count + 1
    where referral_code = new.referred_by and id <> new.id;
  end if;
  return new;
end $$;
create trigger trg_bump_referral after insert on public.leads
  for each row execute function public.bump_referral_count();

-- ============ launch_zones (public marketing data; counts stay private) ============
create table public.launch_zones (
  id uuid primary key default gen_random_uuid(),
  zip_code text unique not null check (char_length(zip_code) between 3 and 10),
  city text,
  neighborhood text,
  state text default 'FL',
  status text not null default 'future' check (status in ('priority','nearby','future','live')),
  priority_score integer not null default 0,
  target_launch_date date
);
alter table public.launch_zones enable row level security;
create policy "zones are public marketing data"
  on public.launch_zones for select to anon, authenticated using (true);

insert into public.launch_zones (zip_code, city, neighborhood, state, status, priority_score) values
  ('33186','Miami','Kendall / Pinecrest','FL','priority',100),
  ('33143','Miami',null,'FL','nearby',50), ('33155','Miami',null,'FL','nearby',50),
  ('33156','Miami',null,'FL','nearby',50), ('33157','Miami',null,'FL','nearby',50),
  ('33158','Miami',null,'FL','nearby',50), ('33165','Miami',null,'FL','nearby',50),
  ('33173','Miami',null,'FL','nearby',50), ('33176','Miami',null,'FL','nearby',50),
  ('33183','Miami',null,'FL','nearby',50), ('33185','Miami',null,'FL','nearby',50),
  ('33193','Miami',null,'FL','nearby',50), ('33196','Miami',null,'FL','nearby',50);

-- ============ restaurant partner applications ============
create table public.restaurant_partner_applications (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  business_name text not null check (char_length(business_name) between 1 and 200),
  contact_name text not null check (char_length(contact_name) between 1 and 160),
  email text not null check (email ~* '^\S+@\S+\.\S+$' and char_length(email) <= 254),
  phone text check (char_length(phone) <= 25),
  cuisine_type text check (char_length(cuisine_type) <= 120),
  address text check (char_length(address) <= 300),
  zip_code text check (char_length(zip_code) <= 10),
  website text check (char_length(website) <= 300),
  instagram text check (char_length(instagram) <= 120),
  pos_system text check (char_length(pos_system) <= 120),
  number_of_locations integer check (number_of_locations between 1 and 500),
  can_batch_2_to_4_pm boolean,
  estimated_capacity text check (char_length(estimated_capacity) <= 200),
  status text not null default 'new' check (status in ('new','reviewing','tasting','menu_setup','live','declined','on_hold')),
  notes text check (char_length(notes) <= 2000)
);
alter table public.restaurant_partner_applications enable row level security;
create policy "anon can apply as partner"
  on public.restaurant_partner_applications for insert to anon with check (true);

-- ============ email_events: Resend provider fields ============
alter table public.email_events rename column payload to metadata;
alter table public.email_events add column provider_message_id text;

create or replace function public.queue_lead_emails()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into email_events (lead_id, event_type, metadata)
  values (new.id, 'waitlist_confirmation',
          jsonb_build_object('email', new.email, 'first_name', new.first_name,
                             'zone', new.launch_zone_status));
  if new.role = 'restaurant_owner' then
    insert into email_events (lead_id, event_type, metadata)
    values (new.id, 'restaurant_partner_confirmation',
            jsonb_build_object('email', new.email, 'first_name', new.first_name));
  end if;
  if new.role = 'customer' and new.founding_100_interest then
    insert into email_events (lead_id, event_type, metadata)
    values (new.id, 'founding100_nurture',
            jsonb_build_object('email', new.email, 'first_name', new.first_name));
  end if;
  if new.launch_zone_status = 'not_yet' then
    insert into email_events (lead_id, event_type, metadata)
    values (new.id, 'area_nurture',
            jsonb_build_object('email', new.email, 'first_name', new.first_name,
                               'zip', new.zip_code));
  end if;
  return new;
end $$;

-- ============ rate limiting (server-side, per client IP) ============
create table public.submission_log (
  id bigint generated always as identity primary key,
  ip text not null,
  tbl text not null,
  created_at timestamptz not null default now()
);
create index submission_log_ip_idx on public.submission_log (ip, created_at desc);
alter table public.submission_log enable row level security; -- no policies: service-role only

create or replace function public.rate_limit_guard()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  hdrs jsonb;
  client_ip text;
  recent int;
begin
  begin
    hdrs := current_setting('request.headers', true)::jsonb;
  exception when others then hdrs := null;
  end;
  client_ip := split_part(coalesce(hdrs->>'x-forwarded-for', ''), ',', 1);
  if client_ip is null or client_ip = '' then
    return new; -- non-HTTP context (admin/service); no limit
  end if;
  select count(*) into recent from submission_log
  where ip = client_ip and created_at > now() - interval '10 minutes';
  if recent >= 10 then
    raise exception 'rate_limited' using hint = 'Too many submissions from this address. Try again in a few minutes.';
  end if;
  insert into submission_log (ip, tbl) values (client_ip, tg_table_name);
  return new;
end $$;

create trigger trg_rate_limit_leads before insert on public.leads
  for each row execute function public.rate_limit_guard();
create trigger trg_rate_limit_partner_apps before insert on public.restaurant_partner_applications
  for each row execute function public.rate_limit_guard();
create trigger trg_rate_limit_referrals before insert on public.restaurant_referrals
  for each row execute function public.rate_limit_guard();

-- ============ upsert_lead: validated insert-or-update-preferences ============
-- Duplicate emails update their own preferences instead of erroring; identity,
-- first-touch attribution (utm/referred_by/created_at/referral_code) never change.
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
  if v_email is null or v_email !~* '^\S+@\S+\.\S+$' then
    raise exception 'invalid_email';
  end if;
  if v_first is null or v_first = '' or v_last is null or v_last = '' then
    raise exception 'invalid_name';
  end if;
  if v_zip is null or char_length(v_zip) < 3 then
    raise exception 'invalid_zip';
  end if;
  if coalesce(p->>'email_consent','false') <> 'true' then
    raise exception 'consent_required';
  end if;

  insert into leads (
    first_name, last_name, email, phone, zip_code, neighborhood, role,
    interested_plan, household_type, cuisine_interests, dietary_preferences,
    feeding_count, subscribe_timeline, founding_100_interest, sms_consent,
    email_consent, referral_source, referred_by, referral_code,
    launch_zone_status, utm_source, utm_medium, utm_campaign,
    user_agent, landing_page_variant, source_domain, notes
  ) values (
    v_first, v_last, v_email,
    nullif(trim(p->>'phone'), ''), v_zip,
    nullif(trim(p->>'neighborhood'), ''),
    coalesce(nullif(p->>'role',''), 'other'),
    coalesce(nullif(p->>'interested_plan',''), 'not_sure'),
    coalesce(nullif(p->>'household_type',''), 'other'),
    coalesce((select array_agg(x) from jsonb_array_elements_text(coalesce(p->'cuisine_interests','[]'::jsonb)) x), '{}'),
    nullif(trim(p->>'dietary_preferences'), ''),
    nullif(p->>'feeding_count',''),
    nullif(p->>'subscribe_timeline',''),
    coalesce((p->>'founding_100_interest')::boolean, false),
    coalesce((p->>'sms_consent')::boolean, false),
    true,
    nullif(p->>'referral_source',''),
    nullif(p->>'referred_by',''),
    nullif(p->>'referral_code',''),
    nullif(p->>'launch_zone_status',''),
    nullif(p->>'utm_source',''), nullif(p->>'utm_medium',''), nullif(p->>'utm_campaign',''),
    left(p->>'user_agent', 400),
    nullif(p->>'landing_page_variant',''),
    nullif(p->>'source_domain',''),
    nullif(trim(p->>'notes'), '')
  )
  on conflict ((lower(email))) do update set
    first_name = excluded.first_name,
    last_name = excluded.last_name,
    phone = coalesce(excluded.phone, leads.phone),
    zip_code = excluded.zip_code,
    neighborhood = coalesce(excluded.neighborhood, leads.neighborhood),
    role = excluded.role,
    interested_plan = excluded.interested_plan,
    household_type = excluded.household_type,
    cuisine_interests = case when excluded.cuisine_interests = '{}' then leads.cuisine_interests else excluded.cuisine_interests end,
    dietary_preferences = coalesce(excluded.dietary_preferences, leads.dietary_preferences),
    feeding_count = coalesce(excluded.feeding_count, leads.feeding_count),
    subscribe_timeline = coalesce(excluded.subscribe_timeline, leads.subscribe_timeline),
    founding_100_interest = excluded.founding_100_interest,
    sms_consent = excluded.sms_consent,
    launch_zone_status = excluded.launch_zone_status,
    notes = coalesce(excluded.notes, leads.notes)
  returning * into v_row;

  v_created := (v_row.created_at = v_row.updated_at);
  return jsonb_build_object(
    'status', case when v_created then 'created' else 'updated' end,
    'referral_code', v_row.referral_code,
    'launch_zone_status', v_row.launch_zone_status
  );
end $$;
revoke all on function public.upsert_lead(jsonb) from public;
grant execute on function public.upsert_lead(jsonb) to anon;

-- ============ admin aggregates (service-role only; the future /admin reads these) ============
create view public.admin_leads_by_zip as
  select zip_code, count(*) as leads,
         count(*) filter (where founding_100_interest) as founding_interest,
         count(*) filter (where role = 'restaurant_owner') as restaurant_leads
  from leads group by zip_code order by leads desc;

create view public.admin_cuisine_demand as
  select cuisine, count(*) as picks
  from leads, unnest(cuisine_interests) as cuisine
  group by cuisine order by picks desc;

create view public.admin_zone_stats as
  select z.zip_code, z.neighborhood, z.status, z.priority_score, z.target_launch_date,
         (select count(*) from leads l where l.zip_code = z.zip_code) as real_lead_count,
         (select count(*) from restaurant_partner_applications r where r.zip_code = z.zip_code) as restaurant_partner_count
  from launch_zones z order by z.priority_score desc;

revoke all on public.admin_leads_by_zip, public.admin_cuisine_demand, public.admin_zone_stats from anon, authenticated;