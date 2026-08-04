import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/bootstrap/data/datasources/bootstrap_local_data_source.dart';
import 'package:bariq/features/bootstrap/data/repositories/bootstrap_repository_impl.dart';
import 'package:bariq/features/bootstrap/domain/repositories/bootstrap_repository.dart';
import 'package:bariq/features/bootstrap/domain/usecases/resolve_initial_destination.dart';
import 'package:bariq/features/bootstrap/presentation/cubit/bootstrap_cubit.dart';
import 'package:bariq/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:bariq/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:bariq/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies({
  BootstrapRepository? bootstrapRepository,
  OnboardingRepository? onboardingRepository,
}) async {
  if (getIt.isRegistered<BootstrapCubit>()) {
    await getIt.reset();
  }

  getIt
    ..registerLazySingleton<Logger>(Logger.new)
    ..registerLazySingleton<AppLogger>(() => AppLogger(getIt()))
    ..registerLazySingleton<SharedPreferencesAsync>(SharedPreferencesAsync.new)
    ..registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new)
    ..registerLazySingleton<BootstrapLocalDataSource>(
      () => BootstrapLocalDataSourceImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<BootstrapRepository>(
      () => bootstrapRepository ?? BootstrapRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<ResolveInitialDestination>(
      () => ResolveInitialDestination(getIt()),
    )
    ..registerFactory<BootstrapCubit>(() => BootstrapCubit(getIt()))
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
