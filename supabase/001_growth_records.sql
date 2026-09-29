-- Isolated per-account state. No existing application's tables are changed.
create table public.yg_growth_records (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null check (jsonb_typeof(state) = 'object' and octet_length(state::text) < 1048576),
  revision integer not null default 1,
  updated_at timestamptz not null default now()
);
alter table public.yg_growth_records enable row level security;
revoke all on public.yg_growth_records from anon;
grant select,insert,update,delete on public.yg_growth_records to authenticated;
create policy yg_owner_select on public.yg_growth_records for select to authenticated using ((select auth.uid())=user_id);
create policy yg_owner_insert on public.yg_growth_records for insert to authenticated with check ((select auth.uid())=user_id);
create policy yg_owner_update on public.yg_growth_records for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
create policy yg_owner_delete on public.yg_growth_records for delete to authenticated using ((select auth.uid())=user_id);
