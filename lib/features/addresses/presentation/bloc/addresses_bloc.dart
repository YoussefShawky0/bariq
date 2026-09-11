import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/domain/entities/address_input.dart';
import 'package:bariq/features/addresses/domain/entities/zone.dart';
import 'package:bariq/features/addresses/domain/usecases/delete_address.dart';
import 'package:bariq/features/addresses/domain/usecases/load_addresses.dart';
import 'package:bariq/features/addresses/domain/usecases/load_zones.dart';
import 'package:bariq/features/addresses/domain/usecases/save_address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'addresses_bloc.freezed.dart';

enum AddressMutation { save, delete }

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc(
    this._loadAddresses,
    this._saveAddress,
    this._deleteAddress,
    this._loadZones,
  ) : super(const AddressesState.initial()) {
    on<AddressesStarted>(_onStarted);
    on<AddressSubmitted>(_onSubmitted);
    on<AddressDeleteConfirmed>(_onDeleteConfirmed);
  }

  final LoadAddresses _loadAddresses;
  final SaveAddress _saveAddress;
  final DeleteAddress _deleteAddress;
  final LoadZones _loadZones;

  /// Cached zones loaded during startup.
  List<Zone> _zones = const [];

  /// Accessor for zones to be used by the form page.
  List<Zone> get zones => _zones;

  Future<void> _onStarted(
    AddressesStarted event,
    Emitter<AddressesState> emit,
  ) async {
    emit(const AddressesState.loading());

    // Load zones and addresses.
    final zonesResult = await _loadZones();
    final addressesResult = await _loadAddresses();

    zonesResult.match(
      (failure) {
        emit(AddressesState.loadFailure(failure));
      },
      (zones) {
        _zones = zones;
        addressesResult.match(
          (failure) => emit(AddressesState.loadFailure(failure)),
          (addresses) => emit(AddressesState.ready(addresses)),
        );
      },
    );
  }

  Future<void> _onSubmitted(
    AddressSubmitted event,
    Emitter<AddressesState> emit,
  ) async {
    final addresses = _currentAddresses;
    if (addresses == null || state is AddressesSaving) return;

    emit(AddressesState.saving(addresses));
    final result = await _saveAddress(event.input);
    await result.match(
      (failure) async => emit(
        AddressesState.failure(addresses, failure, AddressMutation.save),
      ),
      (_) => _reloadAfterMutation(emit, addresses, AddressMutation.save),
    );
  }

  Future<void> _onDeleteConfirmed(
    AddressDeleteConfirmed event,
    Emitter<AddressesState> emit,
  ) async {
    final addresses = _currentAddresses;
    if (addresses == null || state is AddressesDeleting) return;

    emit(AddressesState.deleting(addresses, event.id));
    final result = await _deleteAddress(event.id);
    await result.match(
      (failure) async => emit(
        AddressesState.failure(addresses, failure, AddressMutation.delete),
      ),
      (_) => _reloadAfterMutation(emit, addresses, AddressMutation.delete),
    );
  }

  Future<void> _reloadAfterMutation(
    Emitter<AddressesState> emit,
    List<Address> previous,
    AddressMutation mutation,
  ) async {
    final refreshed = await _loadAddresses();
    refreshed.match(
      (failure) => emit(AddressesState.failure(previous, failure, mutation)),
      (addresses) => emit(AddressesState.success(addresses, mutation)),
    );
  }

  List<Address>? get _currentAddresses => state.maybeWhen(
    ready: (addresses) => addresses,
    saving: (addresses) => addresses,
    deleting: (addresses, _) => addresses,
    success: (addresses, _) => addresses,
    failure: (addresses, _, _) => addresses,
    orElse: () => null,
  );
}

@freezed
sealed class AddressesEvent with _$AddressesEvent {
  const factory AddressesEvent.started() = AddressesStarted;
  const factory AddressesEvent.submitted(AddressInput input) = AddressSubmitted;
  const factory AddressesEvent.deleteConfirmed(String id) =
      AddressDeleteConfirmed;
}

@freezed
sealed class AddressesState with _$AddressesState {
  const factory AddressesState.initial() = AddressesInitial;
  const factory AddressesState.loading() = AddressesLoading;
  const factory AddressesState.ready(List<Address> addresses) = AddressesReady;
  const factory AddressesState.saving(List<Address> addresses) =
      AddressesSaving;
  const factory AddressesState.deleting(
    List<Address> addresses,
    String addressId,
  ) = AddressesDeleting;
  const factory AddressesState.success(
    List<Address> addresses,
    AddressMutation mutation,
  ) = AddressesSuccess;
  const factory AddressesState.loadFailure(Failure failure) =
      AddressesLoadFailure;
  const factory AddressesState.failure(
    List<Address> addresses,
    Failure failure,
    AddressMutation mutation,
  ) = AddressesFailure;
}
