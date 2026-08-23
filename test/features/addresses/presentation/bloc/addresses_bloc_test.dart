import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/addresses/domain/repositories/address_repository.dart';
import 'package:bariq/features/addresses/domain/usecases/delete_address.dart';
import 'package:bariq/features/addresses/domain/usecases/load_addresses.dart';
import 'package:bariq/features/addresses/domain/usecases/load_zones.dart';
import 'package:bariq/features/addresses/domain/usecases/save_address.dart';
import 'package:bariq/features/addresses/presentation/bloc/addresses_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/address_test_data.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

void main() {
  late MockAddressRepository repository;

  setUpAll(() => registerFallbackValue(testAddressInput()));

  setUp(() {
    repository = MockAddressRepository();
    when(repository.loadZones)
        .thenAnswer((_) async => Right([testZone()]));
  });

  AddressesBloc buildBloc() => AddressesBloc(
        LoadAddresses(repository),
        SaveAddress(repository),
        DeleteAddress(repository),
        LoadZones(repository),
      );

  blocTest<AddressesBloc, AddressesState>(
    'loads the current customer addresses and zones',
    build: () {
      when(repository.loadAddresses)
          .thenAnswer((_) async => Right([testAddress()]));
      return buildBloc();
    },
    act: (bloc) => bloc.add(const AddressesEvent.started()),
    expect: () => [isA<AddressesLoading>(), isA<AddressesReady>()],
  );

  blocTest<AddressesBloc, AddressesState>(
    'emits failure state when loading addresses fails',
    build: () {
      when(repository.loadAddresses)
          .thenAnswer((_) async => const Left(NetworkFailure()));
      return buildBloc();
    },
    act: (bloc) => bloc.add(const AddressesEvent.started()),
    expect: () => [isA<AddressesLoading>(), isA<AddressesLoadFailure>()],
  );

  blocTest<AddressesBloc, AddressesState>(
    'saves and reloads addresses list',
    build: () {
      when(() => repository.saveAddress(any()))
          .thenAnswer((_) async => Right(testAddress()));
      when(repository.loadAddresses)
          .thenAnswer((_) async => Right([testAddress()]));
      return buildBloc();
    },
    seed: () => const AddressesState.ready([]),
    act: (bloc) => bloc.add(AddressesEvent.submitted(testAddressInput())),
    expect: () => [isA<AddressesSaving>(), isA<AddressesSuccess>()],
    verify: (_) => verify(repository.loadAddresses).called(1),
  );

  blocTest<AddressesBloc, AddressesState>(
    'deletes and reloads addresses list',
    build: () {
      when(() => repository.deleteAddress('address-id-1'))
          .thenAnswer((_) async => const Right(null));
      when(repository.loadAddresses)
          .thenAnswer((_) async => const Right([]));
      return buildBloc();
    },
    seed: () => AddressesState.ready([testAddress()]),
    act: (bloc) =>
        bloc.add(const AddressesEvent.deleteConfirmed('address-id-1')),
    expect: () => [isA<AddressesDeleting>(), isA<AddressesSuccess>()],
  );
}
