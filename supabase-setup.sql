-- ALREADY APPLIED to the Supabase project "alquds-website" (rwtuaaalynqqrcibxeej).
-- Kept in the repo as a record / for rebuilding the database in a new project.
create table public.admins (user_id uuid primary key references auth.users(id) on delete cascade);
create table public.listings (
  id uuid primary key default gen_random_uuid(),
  cat text not null check (cat in ('sale','rent','stay')),
  type text not null, title text not null,
  loc text default '', meta text default '', price text default '', description text default '',
  images text[] default '{}', created_at timestamptz default now());
create index listings_created_idx on public.listings (created_at desc);
create table public.settings (id int primary key default 1 check (id = 1), data jsonb not null default '{}'::jsonb);
insert into public.settings (id, data) values (1, '{}');

create schema if not exists private;
create function private.is_admin() returns boolean
language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.admins where user_id = (select auth.uid())) $$;
revoke execute on function private.is_admin() from public, anon;
grant usage on schema private to authenticated;
grant execute on function private.is_admin() to authenticated;

alter table public.admins enable row level security;
alter table public.listings enable row level security;
alter table public.settings enable row level security;
create policy "admin reads own row" on public.admins for select to authenticated using (user_id = (select auth.uid()));
create policy "public reads listings" on public.listings for select to anon, authenticated using (true);
create policy "admin inserts listings" on public.listings for insert to authenticated with check (private.is_admin());
create policy "admin updates listings" on public.listings for update to authenticated using (private.is_admin()) with check (private.is_admin());
create policy "admin deletes listings" on public.listings for delete to authenticated using (private.is_admin());
create policy "public reads settings" on public.settings for select to anon, authenticated using (true);
create policy "admin inserts settings" on public.settings for insert to authenticated with check (private.is_admin());
create policy "admin updates settings" on public.settings for update to authenticated using (private.is_admin()) with check (private.is_admin());

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('listing-images', 'listing-images', true, 5242880, array['image/jpeg','image/png','image/webp']);
create policy "admin selects images" on storage.objects for select to authenticated using (bucket_id = 'listing-images' and private.is_admin());
create policy "admin uploads images" on storage.objects for insert to authenticated with check (bucket_id = 'listing-images' and private.is_admin());
create policy "admin edits images" on storage.objects for update to authenticated using (bucket_id = 'listing-images' and private.is_admin());
create policy "admin deletes images" on storage.objects for delete to authenticated using (bucket_id = 'listing-images' and private.is_admin());

-- Grant admin rights AFTER creating the user in Supabase → Authentication → Users:
-- insert into public.admins (user_id) select id from auth.users where email = 'CLIENT_EMAIL_HERE';
