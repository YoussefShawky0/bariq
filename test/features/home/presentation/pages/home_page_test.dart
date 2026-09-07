import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/di/injection.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/home/presentation/pages/home_page.dart';
import 'package:bariq/features/service_catalog/domain/repositories/service_catalog_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/service_test_data.dart';

class MockServiceCatalogRepository extends Mock
    implements ServiceCatalogRepository {}

void main() {
  late MockServiceCatalogRepository repository;

  setUp(() async {
    repository = MockServiceCatalogRepository();
    await configureDependencies(serviceCatalogRepository: repository);
  });

  testWidgets('renders featured banner and service catalog on home page', (
    tester,
  ) async {
    when(
      repository.loadServices,
    ).thenAnswer((_) async => Right([testService()]));

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = AppSizes.designSize;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: AppSizes.designSize,
        minTextAdapt: true,
        builder: (_, _) => MaterialApp(
          theme: AppTheme.light,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: HomePage(),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();

    expect(find.text(AppStrings.homeFeaturedTag), findsOneWidget);
    expect(find.text(AppStrings.homeServicesTitle), findsOneWidget);
    expect(find.text('غسيل خارجي'), findsOneWidget);
  });
}
