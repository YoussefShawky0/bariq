import 'dart:async';

import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/service_catalog/data/datasources/service_catalog_remote_data_source.dart';
import 'package:bariq/features/service_catalog/data/repositories/service_catalog_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/service_test_data.dart';

class MockServiceCatalogRemoteDataSource extends Mock
    implements ServiceCatalogRemoteDataSource {}

class MockAppLogger extends Mock implements AppLogger {}

void main() {
  late MockServiceCatalogRemoteDataSource remoteDataSource;
  late MockAppLogger logger;
  late ServiceCatalogRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockServiceCatalogRemoteDataSource();
    logger = MockAppLogger();
    repository = ServiceCatalogRepositoryImpl(remoteDataSource, logger);
  });

  void stubLogger() {
    when(
      () => logger.error(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);
  }

  test('loads services from remote data source', () async {
    when(
      remoteDataSource.fetchServices,
    ).thenAnswer((_) async => [testService()]);

    final result = await repository.loadServices();

    final services = result.getRight().toNullable();
    expect(services, hasLength(1));
    expect(services?.single.code, 'exterior_wash');
  });

  test('loads complete service detail with addons and pricing', () async {
    when(
      remoteDataSource.fetchServices,
    ).thenAnswer((_) async => [testService()]);
    when(
      () => remoteDataSource.fetchAddons('service-1'),
    ).thenAnswer((_) async => [testServiceAddon()]);
    when(
      () => remoteDataSource.fetchPricingConfigs('service-1'),
    ).thenAnswer((_) async => [testServicePricing()]);

    final result = await repository.loadServiceDetail('service-1');

    final detail = result.getRight().toNullable();
    expect(detail, isNotNull);
    expect(detail?.service.id, 'service-1');
    expect(detail?.addons, hasLength(1));
    expect(detail?.pricingConfigs, hasLength(1));
  });

  test('maps timeout to a network failure', () async {
    when(remoteDataSource.fetchServices).thenThrow(TimeoutException('timeout'));
    stubLogger();

    final result = await repository.loadServices();

    expect(result.getLeft().toNullable(), isA<NetworkFailure>());
  });
}
