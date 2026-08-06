import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_input.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:bariq/features/vehicles/domain/usecases/delete_vehicle.dart';
import 'package:bariq/features/vehicles/domain/usecases/load_vehicles.dart';
import 'package:bariq/features/vehicles/domain/usecases/save_vehicle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/vehicle_test_data.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  late MockVehicleRepository repository;

  setUpAll(() => registerFallbackValue(vehicleInput()));

  setUp(() => repository = MockVehicleRepository());

  test('load delegates to the repository', () async {
    final vehicles = [vehicle()];
    when(repository.loadVehicles).thenAnswer((_) async => Right(vehicles));

    final result = await LoadVehicles(repository)();

    expect(result.getRight().toNullable(), same(vehicles));
  });

  test('save trims and normalizes accepted input', () async {
    when(
      () => repository.saveVehicle(any()),
    ).thenAnswer((_) async => Right(vehicle()));

    await SaveVehicle(repository, now: () => DateTime.utc(2026, 8, 5))(
      vehicleInput(
        make: '  Toyota  ',
        model: ' Corolla ',
        color: ' أبيض ',
        plateNumber: ' أ   ب  ج ١٢٣ ',
      ),
    );

    final captured =
        verify(() => repository.saveVehicle(captureAny())).captured.single
            as VehicleInput;
    expect(captured.make, 'Toyota');
    expect(captured.model, 'Corolla');
    expect(captured.color, 'أبيض');
    expect(captured.plateNumber, 'أ ب ج ١٢٣');
  });

  for (final testCase in {
    'make': (input: vehicleInput(make: 'A'), code: 'INVALID_VEHICLE_MAKE'),
    'model': (input: vehicleInput(model: ''), code: 'INVALID_VEHICLE_MODEL'),
    'year': (input: vehicleInput(year: 1949), code: 'INVALID_VEHICLE_YEAR'),
    'color': (input: vehicleInput(color: ''), code: 'INVALID_VEHICLE_COLOR'),
    'plate': (
      input: vehicleInput(plateNumber: ''),
      code: 'INVALID_VEHICLE_PLATE',
    ),
  }.entries) {
    test('save rejects invalid ${testCase.key}', () async {
      final result = await SaveVehicle(
        repository,
        now: () => DateTime.utc(2026, 8, 5),
      )(testCase.value.input);

      final failure = result.getLeft().toNullable();
      expect(failure, isA<ValidationFailure>());
      expect(failure?.code, testCase.value.code);
      verifyNever(() => repository.saveVehicle(any()));
    });
  }

  test('delete rejects an empty id without repository access', () async {
    final result = await DeleteVehicle(repository)('  ');

    expect(result.getLeft().toNullable(), isA<ValidationFailure>());
    verifyNever(() => repository.deleteVehicle(any()));
  });

  test('delete delegates a valid id', () async {
    when(
      () => repository.deleteVehicle('vehicle-id'),
    ).thenAnswer((_) async => const Right(unit));

    final result = await DeleteVehicle(repository)('vehicle-id');

    expect(result.getRight().toNullable(), unit);
  });
}
