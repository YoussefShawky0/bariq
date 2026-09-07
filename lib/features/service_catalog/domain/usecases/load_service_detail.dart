import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_detail.dart';
import 'package:bariq/features/service_catalog/domain/repositories/service_catalog_repository.dart';

/// Loads full detail for a specific service.
final class LoadServiceDetail {
  const LoadServiceDetail(this._repository);
  final ServiceCatalogRepository _repository;

  ResultFuture<ServiceDetail> call(String serviceId) =>
      _repository.loadServiceDetail(serviceId);
}
