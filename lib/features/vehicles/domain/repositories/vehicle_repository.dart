import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_input.dart';
import 'package:fpdart/fpdart.dart';

/// Customer vehicle persistence boundary.
abstract interface class VehicleRepository {
  /// Loads only vehicles owned by the active customer.
  ResultFuture<List<Vehicle>> loadVehicles();

  /// Creates or updates one owned vehicle and returns the server result.
  ResultFuture<Vehicle> saveVehicle(VehicleInput input);

  /// Deletes one owned vehicle while preserving the default invariant.
  ResultFuture<Unit> deleteVehicle(String id);
}
