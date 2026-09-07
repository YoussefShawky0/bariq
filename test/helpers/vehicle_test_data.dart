import 'package:bariq/features/vehicles/data/models/vehicle_model.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_class.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_input.dart';

Vehicle vehicle({
  String id = 'vehicle-id',
  String make = 'Toyota',
  String model = 'Corolla',
  bool isDefault = true,
}) => Vehicle(
  id: id,
  make: make,
  model: model,
  year: 2022,
  color: 'أبيض',
  plateNumber: 'أ ب ج ١٢٣',
  vehicleClass: VehicleClass.sedan,
  isDefault: isDefault,
  createdAt: DateTime.utc(2026, 8, 5),
);

VehicleInput vehicleInput({
  String? id,
  String make = 'Toyota',
  String model = 'Corolla',
  int year = 2022,
  String color = 'أبيض',
  String plateNumber = 'أ ب ج ١٢٣',
  bool isDefault = true,
}) => VehicleInput(
  id: id,
  make: make,
  model: model,
  year: year,
  color: color,
  plateNumber: plateNumber,
  vehicleClass: VehicleClass.sedan,
  isDefault: isDefault,
);

VehicleModel vehicleModel({String id = 'vehicle-id', bool isDefault = true}) =>
    VehicleModel(
      id: id,
      make: 'Toyota',
      model: 'Corolla',
      year: 2022,
      color: 'أبيض',
      plateNumber: 'أ ب ج ١٢٣',
      vehicleClass: VehicleClass.sedan,
      isDefault: isDefault,
      createdAt: DateTime.utc(2026, 8, 5),
    );
