-- rocketplate.io captures lighter leads (no phone/plan/household questions).
-- Keep NOT NULL only where every capture surface collects the field.
alter table public.leads alter column phone drop not null;
alter table public.leads alter column interested_plan set default 'not_sure';
alter table public.leads alter column household_type set default 'other';