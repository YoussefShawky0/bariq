import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Deletes an owned vehicle through the repository boundary.
final class DeleteVehicle {
  const DeleteVehicle(this._repository);

  final VehicleRepository _repository;

  /// Rejects an empty identifier before reaching the backend.
  ResultFuture<Unit> call(String id) {
    if (id.trim().isEmpty) {
      return Future.value(
        const Left(
          ValidationFailure(
            code: 'INVALID_VEHICLE_ID',
            message: 'تعذر تحديد العربية المطلوبة.',
          ),
        ),
      );
    }
    return _repository.deleteVehicle(id);
  }
}
