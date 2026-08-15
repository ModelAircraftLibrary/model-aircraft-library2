-- Run this once in Supabase: SQL Editor -> New query -> Run.
-- Row Level Security keeps every collection private to its signed-in owner.

create table if not exists public.aircraft_library_sync (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.aircraft_library_sync enable row level security;

drop policy if exists "Users can read their own aircraft library" on public.aircraft_library_sync;
create policy "Users can read their own aircraft library"
on public.aircraft_library_sync for select to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own aircraft library" on public.aircraft_library_sync;
create policy "Users can create their own aircraft library"
on public.aircraft_library_sync for insert to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own aircraft library" on public.aircraft_library_sync;
create policy "Users can update their own aircraft library"
on public.aircraft_library_sync for update to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

revoke all on table public.aircraft_library_sync from anon;
grant select, insert, update on table public.aircraft_library_sync to authenticated;
