import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_input.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_rules.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Validates, normalizes, and saves customer vehicle input.
final class SaveVehicle {
  SaveVehicle(this._repository, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final VehicleRepository _repository;
  final DateTime Function() _now;

  /// Returns a localized validation failure before any backend call.
  ResultFuture<Vehicle> call(VehicleInput input) {
    final normalized = _normalize(input);
    final failure = _validate(normalized);
    return failure == null
        ? _repository.saveVehicle(normalized)
        : Future.value(Left(failure));
  }

  VehicleInput _normalize(VehicleInput input) => VehicleInput(
    id: input.id,
    make: input.make.trim(),
    model: input.model.trim(),
    year: input.year,
    color: input.color.trim(),
    plateNumber: input.plateNumber.trim().replaceAll(RegExp(r'\s+'), ' '),
    vehicleClass: input.vehicleClass,
    isDefault: input.isDefault,
  );

  ValidationFailure? _validate(VehicleInput input) {
    if (input.make.length < VehicleRules.minMakeLength ||
        input.make.length > VehicleRules.maxMakeLength) {
      return const ValidationFailure(
        code: 'INVALID_VEHICLE_MAKE',
        message: 'اكتب ماركة العربية من حرفين على الأقل.',
      );
    }
    if (input.model.length < VehicleRules.minModelLength ||
        input.model.length > VehicleRules.maxModelLength) {
      return const ValidationFailure(
        code: 'INVALID_VEHICLE_MODEL',
        message: 'اكتب موديل العربية.',
      );
    }
    if (input.year < VehicleRules.earliestYear ||
        input.year > VehicleRules.latestYear(_now())) {
      return ValidationFailure(
        code: 'INVALID_VEHICLE_YEAR',
        message:
            'اختَر سنة بين ${VehicleRules.earliestYear} و${VehicleRules.latestYear(_now())}.',
      );
    }
    if (input.color.length < VehicleRules.minColorLength ||
        input.color.length > VehicleRules.maxColorLength) {
      return const ValidationFailure(
        code: 'INVALID_VEHICLE_COLOR',
        message: 'اكتب لون العربية.',
      );
    }
    if (input.plateNumber.length < VehicleRules.minPlateLength ||
        input.plateNumber.length > VehicleRules.maxPlateLength) {
      return const ValidationFailure(
        code: 'INVALID_VEHICLE_PLATE',
        message: 'اكتب رقم اللوحة بشكل صحيح.',
      );
    }
    return null;
  }
}
