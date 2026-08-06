import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_class.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_input.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_rules.dart';
import 'package:flutter/widgets.dart';

final class VehicleFormController {
  VehicleFormController(Vehicle? vehicle)
    : id = vehicle?.id,
      make = TextEditingController(text: vehicle?.make),
      model = TextEditingController(text: vehicle?.model),
      color = TextEditingController(text: vehicle?.color),
      plate = TextEditingController(text: vehicle?.plateNumber),
      year = vehicle?.year ?? DateTime.now().year,
      vehicleClass = vehicle?.vehicleClass ?? VehicleClass.sedan,
      isDefault = vehicle?.isDefault ?? false;

  final String? id;
  final TextEditingController make;
  final TextEditingController model;
  final TextEditingController color;
  final TextEditingController plate;
  int year;
  VehicleClass vehicleClass;
  bool isDefault;

  List<int> get availableYears => List.generate(
    VehicleRules.latestYear(DateTime.now()) - VehicleRules.earliestYear + 1,
    (index) => VehicleRules.latestYear(DateTime.now()) - index,
    growable: false,
  );

  VehicleInput get input => VehicleInput(
    id: id,
    make: make.text,
    model: model.text,
    year: year,
    color: color.text,
    plateNumber: plate.text,
    vehicleClass: vehicleClass,
    isDefault: isDefault,
  );

  void dispose() {
    make.dispose();
    model.dispose();
    color.dispose();
    plate.dispose();
  }
}
