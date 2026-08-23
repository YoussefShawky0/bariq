import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/addresses/domain/entities/zone.dart';
import 'package:bariq/features/addresses/domain/repositories/address_repository.dart';

/// Loads all serviceable zones.
final class LoadZones {
  const LoadZones(this._repository);
  final AddressRepository _repository;

  ResultFuture<List<Zone>> call() => _repository.loadZones();
}
