begin;

alter table public.profiles
  drop constraint if exists profiles_phone_check,
  drop constraint if exists profiles_city_check,
  drop constraint if exists profiles_egyptian_mobile_check,
  drop constraint if exists profiles_egypt_governorate_check;

alter table public.profiles
  add constraint profiles_egyptian_mobile_check check (
    phone is null or phone ~ '^\+201[0125][0-9]{8}$'
  ) not valid,
  add constraint profiles_egypt_governorate_check check (
    city is null or city = any (array[
      'الإسكندرية', 'الإسماعيلية', 'الأقصر', 'البحر الأحمر', 'البحيرة',
      'الجيزة', 'الدقهلية', 'السويس', 'الشرقية', 'الغربية', 'الفيوم',
      'القاهرة', 'القليوبية', 'المنوفية', 'المنيا', 'الوادي الجديد',
      'أسوان', 'أسيوط', 'بني سويف', 'بورسعيد', 'جنوب سيناء', 'دمياط',
      'سوهاج', 'شمال سيناء', 'قنا', 'كفر الشيخ', 'مطروح'
    ]::text[])
  ) not valid;

alter table public.profiles
  validate constraint profiles_egyptian_mobile_check;

-- Keep legacy free-text cities readable. The NOT VALID constraint still
-- enforces the governorate list on every new or updated profile row.

commit;
