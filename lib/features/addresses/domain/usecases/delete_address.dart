import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/addresses/domain/repositories/address_repository.dart';

/// Deletes a customer address by id.
final class DeleteAddress {
  const DeleteAddress(this._repository);
  final AddressRepository _repository;

  ResultFuture<void> call(String addressId) =>
      _repository.deleteAddress(addressId);
}
