import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_class.dart';

final class VehicleModel {
  const VehicleModel({
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

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    id: json['id'] as String,
    make: json['make'] as String,
    model: json['model'] as String,
    year: json['year'] as int,
    color: json['color'] as String,
    plateNumber: json['plate_number'] as String,
    vehicleClass: VehicleClass.fromApi(json['vehicle_class'] as String),
    isDefault: json['is_default'] as bool,
    createdAt: DateTime.parse(json['created_at'] as String).toUtc(),
  );

  final String id;
  final String make;
  final String model;
  final int year;
  final String color;
  final String plateNumber;
  final VehicleClass vehicleClass;
  final bool isDefault;
  final DateTime createdAt;

  Vehicle toEntity() => Vehicle(
    id: id,
    make: make,
    model: model,
    year: year,
    color: color,
    plateNumber: plateNumber,
    vehicleClass: vehicleClass,
    isDefault: isDefault,
    createdAt: createdAt,
  );
}
