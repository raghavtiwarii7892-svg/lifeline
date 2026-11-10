-- Lifeline: medical department structure (category + specialty).
-- Additive only: existing rows are NOT modified (both columns stay NULL and appear
-- under "Earlier records" in the app). stage and obg_gynae columns are kept.
alter table public.medical_records
  add column if not exists category text,
  add column if not exists specialty text;

alter table public.medical_records drop constraint if exists medical_records_category_chk;
alter table public.medical_records add constraint medical_records_category_chk check (
  (category is null and specialty is null)
  or (category = 'medical'    and specialty in ('internal-medicine','dermatology','psychiatry','pmr'))
  or (category = 'surgical'   and specialty in ('general-surgery','ent','ophthalmology','orthopaedics'))
  or (category = 'pediatrics' and specialty in ('general-pediatrics','neonatology','pediatric-subspecialties'))
  or (category = 'obgyn'      and specialty in ('obstetrics','gynaecology','reproductive-medicine'))
  or (category = 'opd'        and specialty in ('general-opd','specialty-opd','follow-up'))
  or (category = 'reports'    and specialty in ('laboratory','radiology','pathology','documents'))
);
-- Existing RLS policies are unchanged. Verify your insert policy still requires an
-- approved, unexpired access grant for the inserting doctor.
 
