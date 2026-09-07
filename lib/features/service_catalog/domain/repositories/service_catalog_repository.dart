import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_detail.dart';

/// Repository contract for the service catalog (read-only from client).
abstract interface class ServiceCatalogRepository {
  /// Loads all active services with their starting prices.
  ResultFuture<List<Service>> loadServices();

  /// Loads full detail for a specific service (addons + pricing configs).
  ResultFuture<ServiceDetail> loadServiceDetail(String serviceId);
}
