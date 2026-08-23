/// A service offered in the catalog.
class Service {
  const Service({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.iconName,
    required this.baseDurationMinutes,
    this.startingPriceMinor,
  });

  final String id;
  final String code;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String iconName;
  final int baseDurationMinutes;

  /// Lowest price across all zone/class configs (in minor units, e.g. piasters).
  final int? startingPriceMinor;

  /// Display price in EGP.
  String get startingPriceDisplay =>
      startingPriceMinor != null ? '${startingPriceMinor! ~/ 100} ج.م' : '';
}
