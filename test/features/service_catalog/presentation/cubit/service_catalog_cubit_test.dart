import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/service_catalog/domain/repositories/service_catalog_repository.dart';
import 'package:bariq/features/service_catalog/domain/usecases/load_service_detail.dart';
import 'package:bariq/features/service_catalog/domain/usecases/load_services.dart';
import 'package:bariq/features/service_catalog/presentation/cubit/service_catalog_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/service_test_data.dart';

class MockServiceCatalogRepository extends Mock
    implements ServiceCatalogRepository {}

void main() {
  late MockServiceCatalogRepository repository;

  setUp(() {
    repository = MockServiceCatalogRepository();
  });

  group('ServiceCatalogCubit', () {
    ServiceCatalogCubit buildCubit() =>
        ServiceCatalogCubit(LoadServices(repository));

    blocTest<ServiceCatalogCubit, ServiceCatalogState>(
      'loads services catalog',
      build: () {
        when(repository.loadServices)
            .thenAnswer((_) async => Right([testService()]));
        return buildCubit();
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<ServiceCatalogLoading>(),
        isA<ServiceCatalogReady>(),
      ],
    );

    blocTest<ServiceCatalogCubit, ServiceCatalogState>(
      'emits failure state on repository error',
      build: () {
        when(repository.loadServices)
            .thenAnswer((_) async => const Left(NetworkFailure()));
        return buildCubit();
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<ServiceCatalogLoading>(),
        isA<ServiceCatalogFailure>(),
      ],
    );
  });

  group('ServiceDetailCubit', () {
    ServiceDetailCubit buildDetailCubit() =>
        ServiceDetailCubit(LoadServiceDetail(repository));

    blocTest<ServiceDetailCubit, ServiceDetailState>(
      'loads service details with pricing and addons',
      build: () {
        when(() => repository.loadServiceDetail('service-1'))
            .thenAnswer((_) async => Right(testServiceDetail()));
        return buildDetailCubit();
      },
      act: (cubit) => cubit.load('service-1'),
      expect: () => [
        isA<ServiceDetailLoading>(),
        isA<ServiceDetailReady>(),
      ],
    );
  });
}
