import 'package:bariq/features/vehicles/domain/entities/vehicle_class.dart';

/// A customer-owned vehicle returned by the server-authoritative catalog.
final class Vehicle {
  const Vehicle({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
    required this.vehicleClass,
    required this.isDefault,
    required this.createdAt,
  });

  final String id;
  final String make;
  final String model;
  final int year;
  final String color;
  final String plateNumber;
  final VehicleClass vehicleClass;
  final bool isDefault;
  final DateTime createdAt;

  /// Compact display name shared by list and confirmation surfaces.
  String get displayName => '$make $model';
}
