create table if not exists public.places (
  id text primary key,
  name text not null,
  post text,
  type text,
  status text,
  price text,
  description text,
  oppskrift text,
  color text,
  x double precision,
  y double precision,
  created_at timestamptz default now()
);

alter table public.places add column if not exists oppskrift text;

alter table public.places enable row level security;

drop policy if exists "public read" on public.places;
drop policy if exists "public insert" on public.places;
drop policy if exists "public update" on public.places;
drop policy if exists "public delete" on public.places;

create policy "public read" on public.places for select using (true);
create policy "public insert" on public.places for insert with check (true);
create policy "public update" on public.places for update using (true);
create policy "public delete" on public.places for delete using (true);

do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'places'
  ) then
    alter publication supabase_realtime add table public.places;
  end if;
end $$;
