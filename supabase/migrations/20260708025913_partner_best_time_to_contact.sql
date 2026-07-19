alter table public.restaurant_partner_applications
  add column best_time_to_contact text check (char_length(best_time_to_contact) <= 60);

create or replace function public.submit_partner_application(p jsonb)
returns jsonb language plpgsql security definer set search_path = public as $$
declare v_email text := lower(trim(p->>'email')); a restaurant_partner_applications%rowtype;
begin
  if v_email is null or v_email !~* '^\S+@\S+\.\S+$' then raise exception 'invalid_email'; end if;
  if coalesce(trim(p->>'business_name'),'') = '' then raise exception 'invalid_business'; end if;
  if coalesce(trim(p->>'contact_name'),'') = '' then raise exception 'invalid_contact'; end if;
  insert into restaurant_partner_applications (
    business_name, contact_name, email, phone, cuisine_type, address, zip_code,
    website, instagram, pos_system, number_of_locations, can_batch_2_to_4_pm,
    estimated_capacity, best_time_to_contact, notes
  ) values (
    trim(p->>'business_name'), trim(p->>'contact_name'), v_email,
    nullif(trim(p->>'phone'),''), nullif(trim(p->>'cuisine_type'),''),
    nullif(trim(p->>'address'),''), nullif(trim(p->>'zip_code'),''),
    nullif(trim(p->>'website'),''), nullif(trim(p->>'instagram'),''),
    nullif(trim(p->>'pos_system'),''), (p->>'number_of_locations')::int,
    (p->>'can_batch_2_to_4_pm')::boolean, nullif(trim(p->>'estimated_capacity'),''),
    nullif(trim(p->>'best_time_to_contact'),''), nullif(trim(p->>'notes'),'')
  ) returning * into a;
  return jsonb_build_object('status','created','access_token', a.access_token);
end $$;
revoke all on function public.submit_partner_application(jsonb) from public;
grant execute on function public.submit_partner_application(jsonb) to anon;