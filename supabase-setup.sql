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

-- Saves only to the row owned by the currently authenticated account.
create or replace function public.save_aircraft_library(new_payload jsonb)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  current_user_id uuid := auth.uid();
  saved_payload jsonb;
begin
  if current_user_id is null then
    raise exception 'Authentication required';
  end if;

  insert into public.aircraft_library_sync (user_id, payload, updated_at)
  values (current_user_id, new_payload, now())
  on conflict (user_id) do update
    set payload = excluded.payload,
        updated_at = excluded.updated_at
  returning payload into saved_payload;

  return saved_payload;
end;
$$;

revoke all on function public.save_aircraft_library(jsonb) from public;
revoke all on function public.save_aircraft_library(jsonb) from anon;
grant execute on function public.save_aircraft_library(jsonb) to authenticated;
