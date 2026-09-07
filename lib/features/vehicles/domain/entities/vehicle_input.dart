import 'package:bariq/features/vehicles/domain/entities/vehicle_class.dart';

/// User-entered values used to create or update a vehicle.
final class VehicleInput {
  const VehicleInput({
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
    required this.vehicleClass,
    required this.isDefault,
    this.id,
  });

  final String? id;
  final String make;
  final String model;
  final int year;
  final String color;
  final String plateNumber;
  final VehicleClass vehicleClass;
  final bool isDefault;
}
