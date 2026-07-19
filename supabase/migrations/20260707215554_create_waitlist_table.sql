create table public.waitlist (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  segment text not null check (segment in ('subscriber','restaurant','driver','investor_press')),
  name text not null check (char_length(name) between 1 and 120),
  email text not null check (email ~* '^\S+@\S+\.\S+$' and char_length(email) <= 254),
  zip text not null check (char_length(zip) between 3 and 10)
);

alter table public.waitlist enable row level security;

-- anonymous visitors may only insert (join the waitlist); no select/update/delete
create policy "anon can join waitlist"
  on public.waitlist
  for insert
  to anon
  with check (true);