import 'dart:async';

import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/addresses/data/datasources/address_remote_data_source.dart';
import 'package:bariq/features/addresses/data/repositories/address_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../helpers/address_test_data.dart';

class MockAddressRemoteDataSource extends Mock
    implements AddressRemoteDataSource {}

class MockAppLogger extends Mock implements AppLogger {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

void main() {
  late MockAddressRemoteDataSource remoteDataSource;
  late MockAppLogger logger;
  late MockSupabaseClient supabaseClient;
  late MockGoTrueClient auth;
  late MockUser user;
  late AddressRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(testAddressInput()));

  setUp(() {
    remoteDataSource = MockAddressRemoteDataSource();
    logger = MockAppLogger();
    supabaseClient = MockSupabaseClient();
    auth = MockGoTrueClient();
    user = MockUser();

    when(() => supabaseClient.auth).thenReturn(auth);
    when(() => auth.currentUser).thenReturn(user);
    when(() => user.id).thenReturn('customer-id');

    repository = AddressRepositoryImpl(
      remoteDataSource,
      logger,
      supabaseClient,
    );
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

  test('loads addresses from remote data source', () async {
    when(remoteDataSource.fetchAddresses)
        .thenAnswer((_) async => [testAddress()]);

    final result = await repository.loadAddresses();

    final loaded = result.getRight().toNullable();
    expect(loaded, hasLength(1));
    expect(loaded?.single.label, 'البيت');
  });

  test('inserts a new address when id is null', () async {
    when(() => remoteDataSource.insertAddress(any(), 'customer-id'))
        .thenAnswer((_) async => testAddress());

    final result = await repository.saveAddress(testAddressInput());

    expect(result.getRight().toNullable()?.id, 'address-id-1');
  });

  test('updates an address when id is provided', () async {
    final input = testAddressInput(id: 'existing-id');
    when(() => remoteDataSource.updateAddress(input))
        .thenAnswer((_) async => testAddress(id: 'existing-id'));

    final result = await repository.saveAddress(input);

    expect(result.getRight().toNullable()?.id, 'existing-id');
  });

  test('maps address limit check violation to validation failure', () async {
    when(() => remoteDataSource.insertAddress(any(), any())).thenThrow(
      const PostgrestException(
        message: 'Maximum 10 addresses allowed per customer.',
        code: 'check_violation',
      ),
    );
    stubLogger();

    final result = await repository.saveAddress(testAddressInput());
    final failure = result.getLeft().toNullable();

    expect(failure, isA<ValidationFailure>());
    expect(failure?.code, 'ADDRESS_LIMIT_REACHED');
  });

  test('maps timeout to a network failure', () async {
    when(remoteDataSource.fetchAddresses)
        .thenThrow(TimeoutException('connection timed out'));
    stubLogger();

    final result = await repository.loadAddresses();

    expect(result.getLeft().toNullable(), isA<NetworkFailure>());
  });

  test('deletes an address remotely', () async {
    when(() => remoteDataSource.deleteAddress('address-id-1'))
        .thenAnswer((_) async {});

    final result = await repository.deleteAddress('address-id-1');

    expect(result.isRight(), isTrue);
  });

  test('loads serviceable zones', () async {
    when(remoteDataSource.fetchZones)
        .thenAnswer((_) async => [testZone()]);

    final result = await repository.loadZones();

    final zones = result.getRight().toNullable();
    expect(zones, hasLength(1));
    expect(zones?.single.code, 'cairo');
  });
}
