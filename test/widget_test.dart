import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/domain/repositories/app_startup_repository.dart';
import 'package:bariq/features/app_startup/domain/usecases/resolve_initial_destination.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:bariq/features/app_startup/presentation/pages/app_startup_page.dart';
import 'package:bariq/features/auth/domain/entities/auth_session_status.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:bariq/features/auth/domain/usecases/request_password_reset.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:bariq/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/update_password.dart';
import 'package:bariq/features/auth/domain/usecases/watch_auth_session.dart';
import 'package:bariq/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:bariq/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bariq/features/profile/domain/repositories/profile_repository.dart';
import 'package:bariq/features/profile/domain/usecases/load_customer_profile.dart';
import 'package:bariq/features/profile/domain/usecases/save_customer_profile.dart';
import 'package:bariq/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:bariq/features/vehicles/domain/usecases/delete_vehicle.dart';
import 'package:bariq/features/vehicles/domain/usecases/load_vehicles.dart';
import 'package:bariq/features/vehicles/domain/usecases/save_vehicle.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/customer_profile_test_data.dart';

class MockAppStartupRepository extends Mock implements AppStartupRepository {}

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockProfileRepository extends Mock implements ProfileRepository {}

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  late MockAppStartupRepository repository;
  late MockOnboardingRepository onboardingRepository;
  late MockAuthRepository authRepository;
  late MockProfileRepository profileRepository;
  late MockVehicleRepository vehicleRepository;
  late AppStartupCubit cubit;

  setUp(() {
    repository = MockAppStartupRepository();
    onboardingRepository = MockOnboardingRepository();
    authRepository = MockAuthRepository();
    profileRepository = MockProfileRepository();
    vehicleRepository = MockVehicleRepository();
    when(authRepository.watchSession).thenAnswer((_) => const Stream.empty());
    when(
      vehicleRepository.loadVehicles,
    ).thenAnswer((_) async => const Right([]));
    cubit = AppStartupCubit(ResolveInitialDestination(repository));
  });

  tearDown(() async {
    await cubit.close();
  });

  testWidgets('renders the resolved app startup destination', (tester) async {
    when(
      repository.resolveInitialDestination,
    ).thenAnswer((_) async => const Right(AppDestination.onboarding));

    await tester.pumpWidget(
      _TestApp(
        cubit: cubit,
        onboardingCubitFactory: () =>
            OnboardingCubit(CompleteOnboarding(onboardingRepository)),
        authBlocFactory: () => _buildAuthBloc(authRepository),
        profileBlocFactory: () => _buildProfileBloc(profileRepository),
        vehiclesBlocFactory: () => _buildVehiclesBloc(vehicleRepository),
      ),
    );
    await cubit.initialize();
    await tester.pump();

    expect(find.text(AppStrings.onboardingConvenienceTitle), findsOneWidget);
    expect(find.text(AppStrings.next), findsOneWidget);
    expect(find.text(AppStrings.skip), findsOneWidget);
  });

  testWidgets('renders a retry action when app startup fails', (tester) async {
    when(
      repository.resolveInitialDestination,
    ).thenAnswer((_) async => const Left(CacheFailure()));

    await tester.pumpWidget(
      _TestApp(
        cubit: cubit,
        onboardingCubitFactory: () =>
            OnboardingCubit(CompleteOnboarding(onboardingRepository)),
        authBlocFactory: () => _buildAuthBloc(authRepository),
        profileBlocFactory: () => _buildProfileBloc(profileRepository),
        vehiclesBlocFactory: () => _buildVehiclesBloc(vehicleRepository),
      ),
    );
    await cubit.initialize();
    await tester.pump();

    expect(find.text(AppStrings.initializationFailed), findsOneWidget);
    expect(find.text(AppStrings.retry), findsOneWidget);
  });

  testWidgets('prioritizes a cold-start password recovery link', (
    tester,
  ) async {
    when(
      repository.resolveInitialDestination,
    ).thenAnswer((_) async => const Right(AppDestination.home));
    when(authRepository.watchSession).thenAnswer(
      (_) => Stream.value(const Right(AuthSessionStatus.passwordRecovery)),
    );

    await tester.pumpWidget(
      _TestApp(
        cubit: cubit,
        onboardingCubitFactory: () =>
            OnboardingCubit(CompleteOnboarding(onboardingRepository)),
        authBlocFactory: () => _buildAuthBloc(authRepository),
        profileBlocFactory: () => _buildProfileBloc(profileRepository),
        vehiclesBlocFactory: () => _buildVehiclesBloc(vehicleRepository),
      ),
    );
    await cubit.initialize();
    await tester.pumpAndSettle();
    await tester.pump();

    expect(find.text(AppStrings.passwordRecoveryTitle), findsOneWidget);
    expect(find.text(AppStrings.saveNewPassword), findsOneWidget);
  });

  testWidgets('routes an authenticated incomplete customer to profile', (
    tester,
  ) async {
    when(
      repository.resolveInitialDestination,
    ).thenAnswer((_) async => const Right(AppDestination.profileCompletion));
    when(
      profileRepository.loadCurrentProfile,
    ).thenAnswer((_) async => Right(customerProfile()));

    await tester.pumpWidget(
      _TestApp(
        cubit: cubit,
        onboardingCubitFactory: () =>
            OnboardingCubit(CompleteOnboarding(onboardingRepository)),
        authBlocFactory: () => _buildAuthBloc(authRepository),
        profileBlocFactory: () => _buildProfileBloc(profileRepository),
        vehiclesBlocFactory: () => _buildVehiclesBloc(vehicleRepository),
      ),
    );
    await cubit.initialize();
    await tester.pump();
    await tester.pump();

    expect(find.text(AppStrings.profileTitle), findsOneWidget);
    expect(find.text(AppStrings.saveAndContinue), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({
    required this.cubit,
    required this.onboardingCubitFactory,
    required this.authBlocFactory,
    required this.profileBlocFactory,
    required this.vehiclesBlocFactory,
  });

  final AppStartupCubit cubit;
  final OnboardingCubit Function() onboardingCubitFactory;
  final AuthBloc Function() authBlocFactory;
  final ProfileBloc Function() profileBlocFactory;
  final VehiclesBloc Function() vehiclesBlocFactory;

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
      child: AppStartupPage(
        onboardingCubitFactory: onboardingCubitFactory,
        authBlocFactory: authBlocFactory,
        profileBlocFactory: profileBlocFactory,
        vehiclesBlocFactory: vehiclesBlocFactory,
      ),
    );
  }
}

AuthBloc _buildAuthBloc(AuthRepository repository) => AuthBloc(
  SignInWithEmail(repository),
  SignUpWithEmail(repository),
  RequestPasswordReset(repository),
  UpdatePassword(repository),
  SignInWithGoogle(repository),
  WatchAuthSession(repository),
);

ProfileBloc _buildProfileBloc(ProfileRepository repository) => ProfileBloc(
  LoadCustomerProfile(repository),
  SaveCustomerProfile(repository),
);

VehiclesBloc _buildVehiclesBloc(VehicleRepository repository) => VehiclesBloc(
  LoadVehicles(repository),
  SaveVehicle(repository),
  DeleteVehicle(repository),
);
