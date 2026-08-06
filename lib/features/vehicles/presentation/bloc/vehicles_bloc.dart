import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_input.dart';
import 'package:bariq/features/vehicles/domain/usecases/delete_vehicle.dart';
import 'package:bariq/features/vehicles/domain/usecases/load_vehicles.dart';
import 'package:bariq/features/vehicles/domain/usecases/save_vehicle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicles_bloc.freezed.dart';

enum VehicleMutation { save, delete }

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  VehiclesBloc(this._loadVehicles, this._saveVehicle, this._deleteVehicle)
    : super(const VehiclesState.initial()) {
    on<VehiclesStarted>(_onStarted);
    on<VehicleSubmitted>(_onSubmitted);
    on<VehicleDeleteConfirmed>(_onDeleteConfirmed);
  }

  final LoadVehicles _loadVehicles;
  final SaveVehicle _saveVehicle;
  final DeleteVehicle _deleteVehicle;

  Future<void> _onStarted(
    VehiclesStarted event,
    Emitter<VehiclesState> emit,
  ) async {
    emit(const VehiclesState.loading());
    final result = await _loadVehicles();
    result.match(
      (failure) => emit(VehiclesState.loadFailure(failure)),
      (vehicles) => emit(VehiclesState.ready(vehicles)),
    );
  }

  Future<void> _onSubmitted(
    VehicleSubmitted event,
    Emitter<VehiclesState> emit,
  ) async {
    final vehicles = _currentVehicles;
    if (vehicles == null || state is VehiclesSaving) {
      return;
    }
    emit(VehiclesState.saving(vehicles));
    final result = await _saveVehicle(event.input);
    await result.match(
      (failure) async =>
          emit(VehiclesState.failure(vehicles, failure, VehicleMutation.save)),
      (_) => _reloadAfterMutation(emit, vehicles, VehicleMutation.save),
    );
  }

  Future<void> _onDeleteConfirmed(
    VehicleDeleteConfirmed event,
    Emitter<VehiclesState> emit,
  ) async {
    final vehicles = _currentVehicles;
    if (vehicles == null || state is VehiclesDeleting) {
      return;
    }
    emit(VehiclesState.deleting(vehicles, event.id));
    final result = await _deleteVehicle(event.id);
    await result.match(
      (failure) async => emit(
        VehiclesState.failure(vehicles, failure, VehicleMutation.delete),
      ),
      (_) => _reloadAfterMutation(emit, vehicles, VehicleMutation.delete),
    );
  }

  Future<void> _reloadAfterMutation(
    Emitter<VehiclesState> emit,
    List<Vehicle> previous,
    VehicleMutation mutation,
  ) async {
    final refreshed = await _loadVehicles();
    refreshed.match(
      (failure) => emit(VehiclesState.failure(previous, failure, mutation)),
      (vehicles) => emit(VehiclesState.success(vehicles, mutation)),
    );
  }

  List<Vehicle>? get _currentVehicles => state.maybeWhen(
    ready: (vehicles) => vehicles,
    saving: (vehicles) => vehicles,
    deleting: (vehicles, _) => vehicles,
    success: (vehicles, _) => vehicles,
    failure: (vehicles, _, _) => vehicles,
    orElse: () => null,
  );
}

@freezed
sealed class VehiclesEvent with _$VehiclesEvent {
  const factory VehiclesEvent.started() = VehiclesStarted;

  const factory VehiclesEvent.submitted(VehicleInput input) = VehicleSubmitted;

  const factory VehiclesEvent.deleteConfirmed(String id) =
      VehicleDeleteConfirmed;
}

@freezed
sealed class VehiclesState with _$VehiclesState {
  const factory VehiclesState.initial() = VehiclesInitial;
  const factory VehiclesState.loading() = VehiclesLoading;
  const factory VehiclesState.ready(List<Vehicle> vehicles) = VehiclesReady;
  const factory VehiclesState.saving(List<Vehicle> vehicles) = VehiclesSaving;
  const factory VehiclesState.deleting(
    List<Vehicle> vehicles,
    String vehicleId,
  ) = VehiclesDeleting;
  const factory VehiclesState.success(
    List<Vehicle> vehicles,
    VehicleMutation mutation,
  ) = VehiclesSuccess;
  const factory VehiclesState.loadFailure(Failure failure) =
      VehiclesLoadFailure;
  const factory VehiclesState.failure(
    List<Vehicle> vehicles,
    Failure failure,
    VehicleMutation mutation,
  ) = VehiclesFailure;
}
