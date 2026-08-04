import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:bariq/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bariq/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockOnboardingRepository repository;

  setUp(() {
    repository = MockOnboardingRepository();
  });

  testWidgets('renders the photo-led convenience screen first', (tester) async {
    await _pumpOnboarding(tester, repository: repository);

    expect(find.text(AppStrings.onboardingConvenienceTitle), findsOneWidget);
    expect(find.text(AppStrings.onboardingConvenienceBody), findsOneWidget);
    expect(find.text(AppStrings.next), findsOneWidget);
    expect(find.text(AppStrings.skip), findsOneWidget);
  });

  testWidgets('moves through expertise and tracking screens', (tester) async {
    await _pumpOnboarding(tester, repository: repository);

    await tester.tap(find.text(AppStrings.next));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.onboardingExpertiseTitle), findsOneWidget);

    await tester.tap(find.text(AppStrings.next));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.onboardingTrackingTitle), findsOneWidget);
    expect(find.text(AppStrings.startNow), findsOneWidget);
  });

  testWidgets('completes onboarding from the final screen', (tester) async {
    var completionCalls = 0;
    when(
      repository.completeOnboarding,
    ).thenAnswer((_) async => const Right(unit));
    await _pumpOnboarding(
      tester,
      repository: repository,
      onCompleted: () async => completionCalls += 1,
    );

    await tester.tap(find.text(AppStrings.next));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.next));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.startNow));
    await tester.pumpAndSettle();

    expect(completionCalls, 1);
  });

  testWidgets('skips onboarding from the first screen', (tester) async {
    var completionCalls = 0;
    when(
      repository.completeOnboarding,
    ).thenAnswer((_) async => const Right(unit));
    await _pumpOnboarding(
      tester,
      repository: repository,
      onCompleted: () async => completionCalls += 1,
    );

    await tester.tap(find.text(AppStrings.skip));
    await tester.pumpAndSettle();

    expect(completionCalls, 1);
  });

  testWidgets('shows retry when persistence fails', (tester) async {
    when(
      repository.completeOnboarding,
    ).thenAnswer((_) async => const Left(CacheFailure()));
    await _pumpOnboarding(tester, repository: repository);

    await tester.tap(find.text(AppStrings.skip));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.onboardingSaveFailed), findsOneWidget);
    expect(find.text(AppStrings.retry), findsOneWidget);
  });

  for (final testCase in {
    'small phone': const Size(320, 568),
    'tablet': const Size(800, 1280),
  }.entries) {
    testWidgets('renders without overflow on ${testCase.key}', (tester) async {
      await _pumpOnboarding(
        tester,
        repository: repository,
        logicalSize: testCase.value,
      );

      expect(tester.takeException(), isNull);
      expect(find.text(AppStrings.onboardingConvenienceTitle), findsOneWidget);
    });
  }
}

Future<void> _pumpOnboarding(
  WidgetTester tester, {
  required OnboardingRepository repository,
  Future<void> Function()? onCompleted,
  Size logicalSize = AppSizes.designSize,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = logicalSize;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: AppSizes.designSize,
      minTextAdapt: true,
      builder: (_, child) => MaterialApp(
        locale: AppStrings.arabicLocale,
        theme: AppTheme.light,
        home: BlocProvider(
          create: (_) => OnboardingCubit(CompleteOnboarding(repository)),
          child: child,
        ),
      ),
      child: OnboardingPage(onCompleted: onCompleted ?? () async {}),
    ),
  );
  await tester.pumpAndSettle();
}
