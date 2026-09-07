/// Pricing for a service in a specific zone and vehicle class.
class ServicePricing {
  const ServicePricing({
    required this.serviceId,
    required this.zoneId,
    required this.vehicleClass,
    required this.priceMinor,
    required this.durationMinutes,
  });

  final String serviceId;
  final String zoneId;
  final String vehicleClass;
  final int priceMinor;
  final int durationMinutes;

  /// Display price in EGP.
  String get priceDisplay => '${priceMinor ~/ 100} ج.م';
}
