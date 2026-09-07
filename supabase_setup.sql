create table public.places (
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

alter table public.places enable row level security;

-- Public map: anyone with the page can read/write, same trust model as the
-- existing client-side admin PIN (no real auth). Tighten later if needed.
create policy "public read" on public.places for select using (true);
create policy "public insert" on public.places for insert with check (true);
create policy "public update" on public.places for update using (true);
create policy "public delete" on public.places for delete using (true);

alter publication supabase_realtime add table public.places;

-- If you already ran the block above once, just run this line to add the
-- new "Oppskrift" (recipe) field to your existing table:
-- alter table public.places add column if not exists oppskrift text;
