import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/repositories/service_catalog_repository.dart';

/// Loads all active services.
final class LoadServices {
  const LoadServices(this._repository);
  final ServiceCatalogRepository _repository;

  ResultFuture<List<Service>> call() => _repository.loadServices();
}
