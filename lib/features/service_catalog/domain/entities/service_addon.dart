/// An optional add-on for a service.
class ServiceAddon {
  const ServiceAddon({
    required this.id,
    required this.serviceId,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.priceMinor,
    required this.durationMinutes,
  });

  final String id;
  final String serviceId;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final int priceMinor;
  final int durationMinutes;

  /// Display price in EGP.
  String get priceDisplay => '${priceMinor ~/ 100} ج.م';
}
