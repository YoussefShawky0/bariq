import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_local_data_source.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_session_data_source.dart';
import 'package:bariq/features/app_startup/data/repositories/app_startup_repository_impl.dart';
import 'package:bariq/features/app_startup/domain/repositories/app_startup_repository.dart';
import 'package:bariq/features/app_startup/domain/usecases/resolve_initial_destination.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:bariq/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:bariq/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:bariq/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies({
  AppStartupRepository? appStartupRepository,
  OnboardingRepository? onboardingRepository,
  SupabaseClient? supabaseClient,
}) async {
  if (getIt.isRegistered<AppStartupCubit>()) {
    await getIt.reset();
  }

  getIt
    ..registerLazySingleton<Logger>(Logger.new)
    ..registerLazySingleton<AppLogger>(() => AppLogger(getIt()))
    ..registerLazySingleton<SharedPreferencesAsync>(SharedPreferencesAsync.new)
    ..registerLazySingleton<AppStartupLocalDataSource>(
      () => AppStartupLocalDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<AppStartupSessionDataSource>(
      () => SupabaseAppStartupSessionDataSource(supabaseClient),
    )
    ..registerLazySingleton<AppStartupRepository>(
      () =>
          appStartupRepository ??
          AppStartupRepositoryImpl(getIt(), getIt(), getIt()),
    )
    ..registerLazySingleton<ResolveInitialDestination>(
      () => ResolveInitialDestination(getIt()),
    )
    ..registerFactory<AppStartupCubit>(() => AppStartupCubit(getIt()))
    ..registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<OnboardingRepository>(
      () => onboardingRepository ?? OnboardingRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<CompleteOnboarding>(
      () => CompleteOnboarding(getIt()),
    )
    ..registerFactory<OnboardingCubit>(() => OnboardingCubit(getIt()));
}
