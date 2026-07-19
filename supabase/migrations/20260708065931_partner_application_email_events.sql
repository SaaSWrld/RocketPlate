-- partner applications get their own confirmation email event
alter table public.email_events alter column lead_id drop not null;
alter table public.email_events add column application_id uuid references public.restaurant_partner_applications(id) on delete cascade;
alter table public.email_events add constraint email_events_subject_check
  check (lead_id is not null or application_id is not null);

create or replace function public.queue_partner_app_email()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into email_events (application_id, event_type, metadata)
  values (new.id, 'restaurant_partner_confirmation',
          jsonb_build_object('email', new.email, 'first_name', new.contact_name,
                             'business', new.business_name, 'access_token', new.access_token));
  return new;
end $$;
create trigger trg_queue_partner_app_email
  after insert on public.restaurant_partner_applications
  for each row execute function public.queue_partner_app_email();