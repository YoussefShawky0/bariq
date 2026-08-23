import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/addresses/domain/repositories/address_repository.dart';
import 'package:bariq/features/addresses/domain/usecases/delete_address.dart';
import 'package:bariq/features/addresses/domain/usecases/load_addresses.dart';
import 'package:bariq/features/addresses/domain/usecases/load_zones.dart';
import 'package:bariq/features/addresses/domain/usecases/save_address.dart';
import 'package:bariq/features/addresses/presentation/bloc/addresses_bloc.dart';
import 'package:bariq/features/addresses/presentation/pages/addresses_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/address_test_data.dart';

class MockAddressRepository extends Mock implements AddressRepository {}

void main() {
  late MockAddressRepository repository;
  late AddressesBloc bloc;

  setUpAll(() => registerFallbackValue(testAddressInput()));

  setUp(() {
    repository = MockAddressRepository();
    when(repository.loadZones)
        .thenAnswer((_) async => Right([testZone()]));
    bloc = AddressesBloc(
      LoadAddresses(repository),
      SaveAddress(repository),
      DeleteAddress(repository),
      LoadZones(repository),
    );
  });

  tearDown(() => bloc.close());

  testWidgets('shows empty state when no addresses exist', (tester) async {
    when(repository.loadAddresses)
        .thenAnswer((_) async => const Right([]));

    await _pumpPage(tester, bloc);

    expect(find.text(AppStrings.emptyAddressesTitle), findsOneWidget);
    expect(find.text(AppStrings.emptyAddressesBody), findsOneWidget);
  });

  testWidgets('renders saved address card with default badge', (tester) async {
    when(repository.loadAddresses)
        .thenAnswer((_) async => Right([testAddress()]));

    await _pumpPage(tester, bloc);

    expect(find.text('البيت'), findsOneWidget);
    expect(find.text(AppStrings.defaultAddress), findsOneWidget);
  });

  testWidgets('shows delete confirmation dialog on delete press', (tester) async {
    when(repository.loadAddresses)
        .thenAnswer((_) async => Right([testAddress()]));

    await _pumpPage(tester, bloc);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.deleteAddressTitle), findsOneWidget);
    expect(find.text(AppStrings.deleteAddressBody('البيت')), findsOneWidget);
  });
}

Future<void> _pumpPage(
  WidgetTester tester,
  AddressesBloc bloc, {
  Size logicalSize = AppSizes.designSize,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = logicalSize;
  addTearDown(tester.view.reset);

  await tester.runAsync(() async {
    final ready = bloc.stream.firstWhere((state) => state is AddressesReady);
    bloc.add(const AddressesEvent.started());
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
            child: AddressesPage(),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}
