/// Egypt-only governorates supported by the current customer address flow.
abstract final class EgyptGovernorates {
  /// All 27 Egyptian governorates in Arabic, ordered for quick scanning.
  static const List<String> values = [
    'الإسكندرية',
    'الإسماعيلية',
    'الأقصر',
    'البحر الأحمر',
    'البحيرة',
    'الجيزة',
    'الدقهلية',
    'السويس',
    'الشرقية',
    'الغربية',
    'الفيوم',
    'القاهرة',
    'القليوبية',
    'المنوفية',
    'المنيا',
    'الوادي الجديد',
    'أسوان',
    'أسيوط',
    'بني سويف',
    'بورسعيد',
    'جنوب سيناء',
    'دمياط',
    'سوهاج',
    'شمال سيناء',
    'قنا',
    'كفر الشيخ',
    'مطروح',
  ];

  /// Whether [value] is a supported canonical governorate name.
  static bool contains(String value) => values.contains(value.trim());
}
