import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/domain/repositories/address_repository.dart';

/// Loads all addresses for the current customer.
final class LoadAddresses {
  const LoadAddresses(this._repository);
  final AddressRepository _repository;

  ResultFuture<List<Address>> call() => _repository.loadAddresses();
}
