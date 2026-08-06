import 'dart:async';

import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/vehicles/data/datasources/vehicle_remote_data_source.dart';
import 'package:bariq/features/vehicles/data/repositories/vehicle_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../helpers/vehicle_test_data.dart';

class MockVehicleRemoteDataSource extends Mock
    implements VehicleRemoteDataSource {}

class MockAppLogger extends Mock implements AppLogger {}

void main() {
  late MockVehicleRemoteDataSource remoteDataSource;
  late MockAppLogger logger;
  late VehicleRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(vehicleInput()));

  setUp(() {
    remoteDataSource = MockVehicleRemoteDataSource();
    logger = MockAppLogger();
    repository = VehicleRepositoryImpl(remoteDataSource, logger);
  });

  void stubLogger() {
    when(
      () => logger.error(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);
  }

  test('maps remote vehicle models into domain entities', () async {
    when(
      remoteDataSource.loadVehicles,
    ).thenAnswer((_) async => [vehicleModel()]);

    final result = await repository.loadVehicles();

    final loaded = result.getRight().toNullable();
    expect(loaded, hasLength(1));
    expect(loaded?.single.displayName, 'Toyota Corolla');
  });

  test('maps a saved remote model into a domain entity', () async {
    when(
      () => remoteDataSource.saveVehicle(any()),
    ).thenAnswer((_) async => vehicleModel());

    final result = await repository.saveVehicle(vehicleInput());

    expect(result.getRight().toNullable()?.id, 'vehicle-id');
  });

  test('maps duplicate plates to a safe validation failure', () async {
    when(() => remoteDataSource.saveVehicle(any())).thenThrow(
      const PostgrestException(message: 'private detail', code: '23505'),
    );
    stubLogger();

    final result = await repository.saveVehicle(vehicleInput());
    final failure = result.getLeft().toNullable();

    expect(failure, isA<ValidationFailure>());
    expect(failure?.code, 'DUPLICATE_VEHICLE_PLATE');
    expect(failure?.message, isNot(contains('private detail')));
  });

  test('maps a timeout to a network failure', () async {
    when(remoteDataSource.loadVehicles).thenThrow(TimeoutException('slow'));
    stubLogger();

    final result = await repository.loadVehicles();

    expect(result.getLeft().toNullable(), isA<NetworkFailure>());
  });

  test('returns unit after remote deletion', () async {
    when(
      () => remoteDataSource.deleteVehicle('vehicle-id'),
    ).thenAnswer((_) async {});

    final result = await repository.deleteVehicle('vehicle-id');

    expect(result.getRight().toNullable(), isNotNull);
  });
}
