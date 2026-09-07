import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/domain/entities/address_input.dart';
import 'package:bariq/features/addresses/domain/repositories/address_repository.dart';

/// Saves (creates or updates) a customer address.
final class SaveAddress {
  const SaveAddress(this._repository);
  final AddressRepository _repository;

  ResultFuture<Address> call(AddressInput input) =>
      _repository.saveAddress(input);
}
