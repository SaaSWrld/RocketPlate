-- ============ leads: gorocketplate.com waitlist ============
create table public.leads (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  first_name text not null check (char_length(first_name) between 1 and 80),
  last_name text not null check (char_length(last_name) between 1 and 80),
  email text not null check (email ~* '^\S+@\S+\.\S+$' and char_length(email) <= 254),
  phone text not null check (char_length(phone) between 7 and 25),
  zip_code text not null check (char_length(zip_code) between 3 and 10),
  neighborhood text check (char_length(neighborhood) <= 120),
  role text not null check (role in ('customer','restaurant_owner','driver_operator','investor_press','other')),
  interested_plan text not null check (interested_plan in ('5_meals','7_meals','not_sure')),
  household_type text not null check (household_type in ('individual','couple','family','office','student','senior','other')),
  cuisine_interests text[] not null default '{}',
  dietary_preferences text check (char_length(dietary_preferences) <= 300),
  feeding_count text check (char_length(feeding_count) <= 40),
  subscribe_timeline text check (subscribe_timeline in ('immediately','within_month','within_3_months','just_curious')),
  wants_founding_100 boolean not null default false,
  sms_consent boolean not null default false,
  email_consent boolean not null default false,
  referral_source text check (char_length(referral_source) <= 120),
  referred_by text check (char_length(referred_by) <= 40),
  referral_code text check (char_length(referral_code) <= 20),
  launch_zone_status text check (launch_zone_status in ('priority','nearby','not_yet')),
  notes text check (char_length(notes) <= 1000),
  utm_source text check (char_length(utm_source) <= 120),
  utm_medium text check (char_length(utm_medium) <= 120),
  utm_campaign text check (char_length(utm_campaign) <= 120),
  user_agent text check (char_length(user_agent) <= 400),
  landing_page_variant text check (char_length(landing_page_variant) <= 60)
);
create unique index leads_email_unique on public.leads (lower(email));
create index leads_zip_idx on public.leads (zip_code);

alter table public.leads enable row level security;
create policy "anon can join leads waitlist"
  on public.leads for insert to anon with check (true);

-- ============ email_events: Resend-ready queue ============
create table public.email_events (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  lead_id uuid not null references public.leads(id) on delete cascade,
  event_type text not null check (event_type in (
    'waitlist_confirmation',        -- 1. on every signup
    'founding100_nurture',          -- 2. customer who wants Founding 100
    'restaurant_partner_confirmation', -- 3. role = restaurant_owner
    'zip_launch_announcement',      -- 4. sent by campaign when a ZIP goes live
    'area_nurture',                 -- 5. launch_zone_status = not_yet
    'card_on_file_invite',          -- 6. pre-launch, sent by campaign
    'launch_conversion'             -- 7. subscription launch, sent by campaign
  )),
  status text not null default 'queued' check (status in ('queued','sent','failed','skipped')),
  payload jsonb,
  sent_at timestamptz
);
create index email_events_status_idx on public.email_events (status, event_type);
alter table public.email_events enable row level security;
-- no policies: service-role only (the Resend sender worker)

-- trigger: queue the automatic events on signup
create or replace function public.queue_lead_emails()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into email_events (lead_id, event_type, payload)
  values (new.id, 'waitlist_confirmation',
          jsonb_build_object('email', new.email, 'first_name', new.first_name,
                             'zone', new.launch_zone_status));
  if new.role = 'restaurant_owner' then
    insert into email_events (lead_id, event_type, payload)
    values (new.id, 'restaurant_partner_confirmation',
            jsonb_build_object('email', new.email, 'first_name', new.first_name));
  end if;
  if new.role = 'customer' and new.wants_founding_100 then
    insert into email_events (lead_id, event_type, payload)
    values (new.id, 'founding100_nurture',
            jsonb_build_object('email', new.email, 'first_name', new.first_name));
  end if;
  if new.launch_zone_status = 'not_yet' then
    insert into email_events (lead_id, event_type, payload)
    values (new.id, 'area_nurture',
            jsonb_build_object('email', new.email, 'first_name', new.first_name,
                               'zip', new.zip_code));
  end if;
  return new;
end $$;
create trigger trg_queue_lead_emails
  after insert on public.leads
  for each row execute function public.queue_lead_emails();

-- ============ real aggregate count for "people waiting in your area" ============
create or replace function public.zip_wait_count(p_zip text)
returns integer language sql stable security definer set search_path = public as
$$ select count(*)::int from leads where zip_code = p_zip $$;
revoke all on function public.zip_wait_count(text) from public;
grant execute on function public.zip_wait_count(text) to anon;

-- ============ restaurant referrals from the success state ============
create table public.restaurant_referrals (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  restaurant_name text not null check (char_length(restaurant_name) between 1 and 160),
  note text check (char_length(note) <= 500),
  zip text check (char_length(zip) <= 10),
  referrer_email text check (char_length(referrer_email) <= 254)
);
alter table public.restaurant_referrals enable row level security;
create policy "anon can refer restaurants"
  on public.restaurant_referrals for insert to anon with check (true);