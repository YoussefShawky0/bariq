import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/profile/domain/entities/egypt_governorates.dart';
import 'package:bariq/features/profile/domain/entities/profile_input.dart';
import 'package:bariq/features/profile/domain/repositories/profile_repository.dart';
import 'package:bariq/features/profile/domain/usecases/load_customer_profile.dart';
import 'package:bariq/features/profile/domain/usecases/save_customer_profile.dart';
import 'package:bariq/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bariq/features/profile/presentation/pages/profile_completion_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/customer_profile_test_data.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository repository;
  late ProfileBloc bloc;

  setUpAll(() {
    registerFallbackValue(
      const ProfileInput(
        fullName: 'يوسف شوقي',
        phone: '',
        city: '',
        area: '',
        acceptedTerms: true,
      ),
    );
  });

  setUp(() {
    repository = MockProfileRepository();
    when(
      repository.loadCurrentProfile,
    ).thenAnswer((_) async => Right(customerProfile()));
    bloc = ProfileBloc(
      LoadCustomerProfile(repository),
      SaveCustomerProfile(repository),
    );
  });

  tearDown(() => bloc.close());

  testWidgets('renders required and optional profile fields', (tester) async {
    await _pumpPage(tester, bloc: bloc);

    expect(find.text(AppStrings.profileTitle), findsOneWidget);
    expect(find.text(AppStrings.fullName), findsOneWidget);
    expect(find.text(AppStrings.phoneNumber), findsOneWidget);
    expect(find.text(AppStrings.city), findsOneWidget);
    expect(find.text(AppStrings.area), findsOneWidget);
    expect(find.text(AppStrings.saveAndContinue), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    final phone = tester.widget<TextField>(
      find.widgetWithText(TextField, AppStrings.phoneNumber),
    );
    expect(phone.decoration?.prefixText, AppStrings.egyptCountryCodePrefix);
  });

  testWidgets('shows only Egyptian governorates in the location list', (
    tester,
  ) async {
    await _pumpPage(tester, bloc: bloc);

    final dropdown = find.byType(DropdownButtonFormField<String>);
    final button = find.descendant(
      of: dropdown,
      matching: find.byType(DropdownButton<String>),
    );
    final field = tester.widget<DropdownButton<String>>(button);
    final values = field.items!.map((item) => item.value).toList();

    expect(values, EgyptGovernorates.values);
  });

  testWidgets('shows domain validation without calling the backend', (
    tester,
  ) async {
    await _pumpPage(tester, bloc: bloc);

    final button = find.widgetWithText(
      FilledButton,
      AppStrings.saveAndContinue,
    );
    await tester.ensureVisible(button);
    final failureState = bloc.stream.firstWhere(
      (state) => state is ProfileFailure,
    );
    await tester.tap(button);
    await tester.runAsync(() => failureState);
    await tester.pump();

    expect(find.text('اكتب اسمك بالكامل من حرفين على الأقل.'), findsOneWidget);
    verifyNever(() => repository.saveCurrentProfile(any()));
  });

  testWidgets('completes the profile with minimum required data', (
    tester,
  ) async {
    var completed = false;
    when(() => repository.saveCurrentProfile(any())).thenAnswer(
      (_) async =>
          Right(customerProfile(fullName: 'يوسف شوقي', completed: true)),
    );
    await _pumpPage(
      tester,
      bloc: bloc,
      onCompleted: () async => completed = true,
    );

    await tester.enterText(
      find.widgetWithText(TextField, AppStrings.fullName),
      'يوسف شوقي',
    );
    final checkbox = find.byType(Checkbox);
    await tester.ensureVisible(checkbox);
    await tester.tap(checkbox);
    await tester.pump();
    final button = find.widgetWithText(
      FilledButton,
      AppStrings.saveAndContinue,
    );
    await tester.ensureVisible(button);
    final completedState = bloc.stream.firstWhere(
      (state) => state is ProfileCompleted,
    );
    await tester.tap(button);
    await tester.runAsync(() => completedState);
    await tester.pump();

    expect(completed, isTrue);
  });

  for (final testCase in {
    'small phone': const Size(320, 568),
    'tablet': const Size(800, 1280),
  }.entries) {
    testWidgets('renders without overflow on ${testCase.key}', (tester) async {
      await _pumpPage(tester, bloc: bloc, logicalSize: testCase.value);

      expect(tester.takeException(), isNull);
      expect(find.text(AppStrings.profileTitle), findsOneWidget);
    });
  }
}

Future<void> _pumpPage(
  WidgetTester tester, {
  required ProfileBloc bloc,
  Size logicalSize = AppSizes.designSize,
  Future<void> Function()? onCompleted,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = logicalSize;
  addTearDown(tester.view.reset);

  await tester.runAsync(() async {
    final ready = bloc.stream.firstWhere((state) => state is ProfileReady);
    bloc.add(const ProfileEvent.started());
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
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: ProfileCompletionPage(
              onCompleted: onCompleted ?? () async {},
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}
