import 'dart:async';
import 'dart:io';

import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/service_catalog/data/datasources/service_catalog_remote_data_source.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_detail.dart';
import 'package:bariq/features/service_catalog/domain/repositories/service_catalog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class ServiceCatalogRepositoryImpl implements ServiceCatalogRepository {
  const ServiceCatalogRepositoryImpl(this._remoteDataSource, this._logger);

  final ServiceCatalogRemoteDataSource _remoteDataSource;
  final AppLogger _logger;

  @override
  ResultFuture<List<Service>> loadServices() =>
      _guard(() => _remoteDataSource.fetchServices());

  @override
  ResultFuture<ServiceDetail> loadServiceDetail(String serviceId) =>
      _guard(() async {
        final addons = await _remoteDataSource.fetchAddons(serviceId);
        final configs = await _remoteDataSource.fetchPricingConfigs(serviceId);
        final services = await _remoteDataSource.fetchServices();
        final service = services.firstWhere((s) => s.id == serviceId);

        return ServiceDetail(
          service: service,
          addons: addons,
          pricingConfigs: configs,
        );
      });

  ResultFuture<T> _guard<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Service catalog operation failed.',
        error: error.runtimeType,
        stackTrace: stackTrace,
      );
      return Left(_mapFailure(error));
    }
  }

  Failure _mapFailure(Object error) {
    if (error is SocketException || error is TimeoutException) {
      return const NetworkFailure();
    }
    if (error is PostgrestException) {
      return const BackendFailure();
    }
    return const UnexpectedFailure();
  }
}
