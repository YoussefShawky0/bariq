import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:bariq/features/vehicles/domain/usecases/delete_vehicle.dart';
import 'package:bariq/features/vehicles/domain/usecases/load_vehicles.dart';
import 'package:bariq/features/vehicles/domain/usecases/save_vehicle.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:bariq/features/vehicles/presentation/pages/vehicles_page.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/vehicle_test_data.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  late MockVehicleRepository repository;
  late VehiclesBloc bloc;

  setUpAll(() => registerFallbackValue(vehicleInput()));

  setUp(() {
    repository = MockVehicleRepository();
    bloc = VehiclesBloc(
      LoadVehicles(repository),
      SaveVehicle(repository, now: () => DateTime.utc(2026, 8, 5)),
      DeleteVehicle(repository),
    );
  });

  tearDown(() => bloc.close());

  testWidgets('shows a clear empty state for a new customer', (tester) async {
    when(repository.loadVehicles).thenAnswer((_) async => const Right([]));

    await _pumpPage(tester, bloc);

    expect(find.text(AppStrings.emptyVehiclesTitle), findsOneWidget);
    expect(find.text(AppStrings.emptyVehiclesBody), findsOneWidget);
    expect(find.text(AppStrings.vehicleOwnershipHint), findsOneWidget);
  });

  testWidgets('adds the first vehicle and refreshes the list', (tester) async {
    when(repository.loadVehicles).thenAnswer((_) async => const Right([]));
    when(
      () => repository.saveVehicle(any()),
    ).thenAnswer((_) async => Right(vehicle()));
    await _pumpPage(tester, bloc);

    await tester.tap(find.widgetWithText(FilledButton, AppStrings.addVehicle));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, AppStrings.vehicleMake),
      'Toyota',
    );
    await tester.enterText(
      find.widgetWithText(TextField, AppStrings.vehicleModel),
      'Corolla',
    );
    await tester.enterText(
      find.widgetWithText(TextField, AppStrings.vehicleColor),
      'أبيض',
    );
    await tester.enterText(
      find.widgetWithText(TextField, AppStrings.vehiclePlate),
      'أ ب ج ١٢٣',
    );
    when(repository.loadVehicles).thenAnswer((_) async => Right([vehicle()]));
    await tester.ensureVisible(
      find.widgetWithText(FilledButton, AppStrings.saveVehicle),
    );
    final success = bloc.stream.firstWhere((state) => state is VehiclesSuccess);
    await tester.tap(find.widgetWithText(FilledButton, AppStrings.saveVehicle));
    await tester.runAsync(() => success);
    await tester.pumpAndSettle();

    expect(find.text('Toyota Corolla'), findsOneWidget);
    expect(find.text(AppStrings.defaultVehicle), findsOneWidget);
    verify(() => repository.saveVehicle(any())).called(1);
  });

  testWidgets('asks for confirmation before deleting a vehicle', (
    tester,
  ) async {
    when(repository.loadVehicles).thenAnswer((_) async => Right([vehicle()]));
    await _pumpPage(tester, bloc);

    expect(find.text('Toyota Corolla'), findsOneWidget);
    await tester.tap(find.byType(PopupMenuButton<VehicleCardAction>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.deleteVehicle).last);
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.deleteVehicleTitle), findsOneWidget);
    expect(
      find.text(AppStrings.deleteVehicleBody('Toyota Corolla')),
      findsOneWidget,
    );
    verifyNever(() => repository.deleteVehicle(any()));
  });

  testWidgets('keeps the current default selected while editing', (
    tester,
  ) async {
    when(repository.loadVehicles).thenAnswer((_) async => Right([vehicle()]));
    await _pumpPage(tester, bloc);

    await tester.tap(find.text('Toyota Corolla'));
    await tester.pumpAndSettle();

    final defaultSwitch = tester.widget<SwitchListTile>(
      find.byType(SwitchListTile),
    );
    expect(defaultSwitch.value, isTrue);
    expect(defaultSwitch.onChanged, isNull);
    expect(find.text(AppStrings.defaultVehicleLockedHint), findsOneWidget);
  });

  for (final testCase in {
    'small phone': const Size(320, 568),
    'tablet': const Size(800, 1280),
  }.entries) {
    testWidgets('renders without overflow on ${testCase.key}', (tester) async {
      when(repository.loadVehicles).thenAnswer((_) async => Right([vehicle()]));

      await _pumpPage(tester, bloc, logicalSize: testCase.value);

      expect(find.text('Toyota Corolla'), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.addVehicle), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}

Future<void> _pumpPage(
  WidgetTester tester,
  VehiclesBloc bloc, {
  Size logicalSize = AppSizes.designSize,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = logicalSize;
  addTearDown(tester.view.reset);

  await tester.runAsync(() async {
    final ready = bloc.stream.firstWhere((state) => state is VehiclesReady);
    bloc.add(const VehiclesEvent.started());
    await ready;
  });

  await tester.pumpWidget(
    BlocProvider.value(
      value: bloc,
      child: ScreenUtilInit(
        designSize: AppSizes.designSize,
        minTextAdapt: true,
        builder: (_, _) => MaterialApp(
          theme: AppTheme.light,
          home: const Directionality(
            textDirection: TextDirection.rtl,
            child: VehiclesPage(),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}
