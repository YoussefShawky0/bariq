import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/di/injection.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/addresses/domain/repositories/address_repository.dart';
import 'package:bariq/features/addresses/presentation/bloc/addresses_bloc.dart';
import 'package:bariq/features/booking/domain/repositories/booking_repository.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:bariq/features/booking/presentation/pages/booking_wizard_page.dart';
import 'package:bariq/features/booking/presentation/widgets/step_indicator.dart';
import 'package:bariq/features/service_catalog/domain/repositories/service_catalog_repository.dart';
import 'package:bariq/features/service_catalog/presentation/cubit/service_catalog_cubit.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/booking_test_data.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}
class MockAddressRepository extends Mock implements AddressRepository {}
class MockServiceCatalogRepository extends Mock implements ServiceCatalogRepository {}
class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  late MockVehicleRepository vehicleRepo;
  late MockAddressRepository addressRepo;
  late MockServiceCatalogRepository serviceRepo;
  late MockBookingRepository bookingRepo;

  setUp(() async {
    vehicleRepo = MockVehicleRepository();
    addressRepo = MockAddressRepository();
    serviceRepo = MockServiceCatalogRepository();
    bookingRepo = MockBookingRepository();

    await configureDependencies(
      vehicleRepository: vehicleRepo,
      addressRepository: addressRepo,
      serviceCatalogRepository: serviceRepo,
      bookingRepository: bookingRepo,
    );

    when(vehicleRepo.loadVehicles).thenAnswer((_) async => Right([testVehicle()]));
    when(addressRepo.loadAddresses).thenAnswer((_) async => Right([testAddress()]));
    when(addressRepo.loadZones).thenAnswer((_) async => const Right([]));
    when(serviceRepo.loadServices).thenAnswer((_) async => Right([testService()]));
  });

  testWidgets('renders step indicator and initial vehicle step title', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = AppSizes.designSize;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: AppSizes.designSize,
        minTextAdapt: true,
        builder: (_, child) => MaterialApp(
          theme: AppTheme.light,
          home: MultiBlocProvider(
            providers: [
              BlocProvider<BookingBloc>(
                create: (_) => getIt<BookingBloc>()..add(const BookingEvent.started()),
              ),
              BlocProvider<VehiclesBloc>(
                create: (_) => getIt<VehiclesBloc>()..add(const VehiclesEvent.started()),
              ),
              BlocProvider<AddressesBloc>(
                create: (_) => getIt<AddressesBloc>()..add(const AddressesEvent.started()),
              ),
              BlocProvider<ServiceCatalogCubit>(
                create: (_) => getIt<ServiceCatalogCubit>()..load(),
              ),
            ],
            child: const BookingWizardPage(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(StepIndicator), findsOneWidget);
    expect(find.text(AppStrings.selectVehicleStep), findsOneWidget);
    expect(find.text('Toyota Corolla 2022'), findsOneWidget);
  });
}
