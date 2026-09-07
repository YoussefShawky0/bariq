/// A customer's saved delivery address.
class Address {
  const Address({
    required this.id,
    required this.customerId,
    required this.zoneId,
    required this.zoneName,
    required this.label,
    required this.street,
    required this.isDefault,
    this.latitude,
    this.longitude,
    this.building,
    this.floor,
    this.apartment,
    this.accessNotes,
    this.readiness = const AddressReadiness(),
  });

  final String id;
  final String customerId;
  final String zoneId;
  final String zoneName;
  final String label;
  final String street;
  final bool isDefault;
  final double? latitude;
  final double? longitude;
  final String? building;
  final String? floor;
  final String? apartment;
  final String? accessNotes;
  final AddressReadiness readiness;

  /// Display name combining label and zone.
  String get displayName => '$label • $zoneName';
}

/// Readiness checklist for the service location.
class AddressReadiness {
  const AddressReadiness({
    this.hasAccess = false,
    this.hasVehicleSpace = false,
    this.noWaterNeeded = false,
    this.hasPermission = false,
  });

  factory AddressReadiness.fromJson(Map<String, dynamic> json) =>
      AddressReadiness(
        hasAccess: json['has_access'] as bool? ?? false,
        hasVehicleSpace: json['has_vehicle_space'] as bool? ?? false,
        noWaterNeeded: json['no_water_needed'] as bool? ?? false,
        hasPermission: json['has_permission'] as bool? ?? false,
      );

  final bool hasAccess;
  final bool hasVehicleSpace;
  final bool noWaterNeeded;
  final bool hasPermission;

  Map<String, dynamic> toJson() => {
    'has_access': hasAccess,
    'has_vehicle_space': hasVehicleSpace,
    'no_water_needed': noWaterNeeded,
    'has_permission': hasPermission,
  };
}
