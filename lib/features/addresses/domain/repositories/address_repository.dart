import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/domain/entities/address_input.dart';
import 'package:bariq/features/addresses/domain/entities/zone.dart';

/// Repository contract for customer addresses and service zones.
abstract interface class AddressRepository {
  /// Loads all addresses for the current customer.
  ResultFuture<List<Address>> loadAddresses();

  /// Saves (creates or updates) an address.
  ResultFuture<Address> saveAddress(AddressInput input);

  /// Deletes an address by id.
  ResultFuture<void> deleteAddress(String addressId);

  /// Loads all serviceable zones.
  ResultFuture<List<Zone>> loadZones();
}
