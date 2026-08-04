import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/bootstrap/domain/entities/app_destination.dart';
import 'package:bariq/features/bootstrap/domain/repositories/bootstrap_repository.dart';
import 'package:bariq/features/bootstrap/domain/usecases/resolve_initial_destination.dart';
import 'package:bariq/features/bootstrap/presentation/cubit/bootstrap_cubit.dart';
import 'package:bariq/features/bootstrap/presentation/pages/bootstrap_page.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:bariq/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockBootstrapRepository extends Mock implements BootstrapRepository {}

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockBootstrapRepository repository;
  late MockOnboardingRepository onboardingRepository;
  late BootstrapCubit cubit;

  setUp(() {
    repository = MockBootstrapRepository();
    onboardingRepository = MockOnboardingRepository();
    cubit = BootstrapCubit(ResolveInitialDestination(repository));
  });

  tearDown(() async {
    await cubit.close();
  });

  testWidgets('renders the resolved bootstrap destination', (tester) async {
    when(
      repository.resolveInitialDestination,
    ).thenAnswer((_) async => const Right(AppDestination.onboarding));

    await tester.pumpWidget(
      _TestApp(
        cubit: cubit,
        onboardingCubitFactory: () =>
            OnboardingCubit(CompleteOnboarding(onboardingRepository)),
      ),
    );
    await cubit.initialize();
    await tester.pump();

    expect(find.text(AppStrings.onboardingConvenienceTitle), findsOneWidget);
    expect(find.text(AppStrings.next), findsOneWidget);
    expect(find.text(AppStrings.skip), findsOneWidget);
  });

  testWidgets('renders a retry action when bootstrap fails', (tester) async {
    when(
      repository.resolveInitialDestination,
    ).thenAnswer((_) async => const Left(CacheFailure()));

    await tester.pumpWidget(
      _TestApp(
        cubit: cubit,
        onboardingCubitFactory: () =>
            OnboardingCubit(CompleteOnboarding(onboardingRepository)),
      ),
    );
    await cubit.initialize();
    await tester.pump();

    expect(find.text(AppStrings.initializationFailed), findsOneWidget);
    expect(find.text(AppStrings.retry), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.cubit, required this.onboardingCubitFactory});

  final BootstrapCubit cubit;
  final OnboardingCubit Function() onboardingCubitFactory;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppSizes.designSize,
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          theme: AppTheme.light,
          home: BlocProvider.value(value: cubit, child: child),
        );
      },
      child: BootstrapPage(onboardingCubitFactory: onboardingCubitFactory),
    );
  }
}
