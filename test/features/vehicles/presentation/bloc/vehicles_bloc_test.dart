import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:bariq/features/vehicles/domain/usecases/delete_vehicle.dart';
import 'package:bariq/features/vehicles/domain/usecases/load_vehicles.dart';
import 'package:bariq/features/vehicles/domain/usecases/save_vehicle.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/vehicle_test_data.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  late MockVehicleRepository repository;

  setUpAll(() => registerFallbackValue(vehicleInput()));

  setUp(() => repository = MockVehicleRepository());

  VehiclesBloc buildBloc() => VehiclesBloc(
    LoadVehicles(repository),
    SaveVehicle(repository, now: () => DateTime.utc(2026, 8, 5)),
    DeleteVehicle(repository),
  );

  blocTest<VehiclesBloc, VehiclesState>(
    'loads the current customer vehicles',
    build: () {
      when(repository.loadVehicles).thenAnswer((_) async => Right([vehicle()]));
      return buildBloc();
    },
    act: (bloc) => bloc.add(const VehiclesEvent.started()),
    expect: () => [isA<VehiclesLoading>(), isA<VehiclesReady>()],
  );

  blocTest<VehiclesBloc, VehiclesState>(
    'preserves a safe load failure state',
    build: () {
      when(
        repository.loadVehicles,
      ).thenAnswer((_) async => const Left(NetworkFailure()));
      return buildBloc();
    },
    act: (bloc) => bloc.add(const VehiclesEvent.started()),
    expect: () => [isA<VehiclesLoading>(), isA<VehiclesLoadFailure>()],
  );

  blocTest<VehiclesBloc, VehiclesState>(
    'saves then reloads the server-authoritative list',
    build: () {
      when(
        () => repository.saveVehicle(any()),
      ).thenAnswer((_) async => Right(vehicle()));
      when(repository.loadVehicles).thenAnswer((_) async => Right([vehicle()]));
      return buildBloc();
    },
    seed: () => const VehiclesState.ready([]),
    act: (bloc) => bloc.add(VehiclesEvent.submitted(vehicleInput())),
    expect: () => [isA<VehiclesSaving>(), isA<VehiclesSuccess>()],
    verify: (_) => verify(repository.loadVehicles).called(1),
  );

  blocTest<VehiclesBloc, VehiclesState>(
    'keeps the list available when save validation fails',
    build: buildBloc,
    seed: () => VehiclesState.ready([vehicle()]),
    act: (bloc) => bloc.add(VehiclesEvent.submitted(vehicleInput(make: ''))),
    expect: () => [isA<VehiclesSaving>(), isA<VehiclesFailure>()],
    verify: (_) => verifyNever(() => repository.saveVehicle(any())),
  );

  blocTest<VehiclesBloc, VehiclesState>(
    'deletes then reloads the remaining vehicles',
    build: () {
      when(
        () => repository.deleteVehicle('vehicle-id'),
      ).thenAnswer((_) async => const Right(unit));
      when(repository.loadVehicles).thenAnswer((_) async => const Right([]));
      return buildBloc();
    },
    seed: () => VehiclesState.ready([vehicle()]),
    act: (bloc) => bloc.add(const VehiclesEvent.deleteConfirmed('vehicle-id')),
    expect: () => [isA<VehiclesDeleting>(), isA<VehiclesSuccess>()],
  );
}
