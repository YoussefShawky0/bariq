import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';

/// Loads the active customer's vehicles.
final class LoadVehicles {
  const LoadVehicles(this._repository);

  final VehicleRepository _repository;

  /// Delegates to the domain repository boundary.
  ResultFuture<List<Vehicle>> call() => _repository.loadVehicles();
}
