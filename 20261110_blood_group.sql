-- Optional blood group on profiles. Safe to run if you already added the column.
alter table public.profiles add column if not exists blood_group text;
alter table public.profiles drop constraint if exists profiles_blood_group_chk;
alter table public.profiles add constraint profiles_blood_group_chk
  check (blood_group is null or blood_group in ('A+','A-','B+','B-','AB+','AB-','O+','O-'));
