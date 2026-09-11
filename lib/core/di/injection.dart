import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/addresses/data/datasources/address_remote_data_source.dart';
import 'package:bariq/features/addresses/data/repositories/address_repository_impl.dart';
import 'package:bariq/features/addresses/domain/repositories/address_repository.dart';
import 'package:bariq/features/addresses/domain/usecases/delete_address.dart';
import 'package:bariq/features/addresses/domain/usecases/load_addresses.dart';
import 'package:bariq/features/addresses/domain/usecases/load_zones.dart';
import 'package:bariq/features/addresses/domain/usecases/save_address.dart';
import 'package:bariq/features/addresses/presentation/bloc/addresses_bloc.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_local_data_source.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_profile_data_source.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_session_data_source.dart';
import 'package:bariq/features/app_startup/data/repositories/app_startup_repository_impl.dart';
import 'package:bariq/features/app_startup/domain/repositories/app_startup_repository.dart';
import 'package:bariq/features/app_startup/domain/usecases/resolve_initial_destination.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:bariq/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bariq/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:bariq/features/auth/domain/usecases/request_password_reset.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:bariq/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/update_password.dart';
import 'package:bariq/features/auth/domain/usecases/watch_auth_session.dart';
import 'package:bariq/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bariq/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:bariq/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:bariq/features/booking/domain/repositories/booking_repository.dart';
import 'package:bariq/features/booking/domain/usecases/create_booking.dart';
import 'package:bariq/features/booking/domain/usecases/load_available_slots.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:bariq/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:bariq/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:bariq/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bariq/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:bariq/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bariq/features/profile/domain/repositories/profile_repository.dart';
import 'package:bariq/features/profile/domain/usecases/load_customer_profile.dart';
import 'package:bariq/features/profile/domain/usecases/save_customer_profile.dart';
import 'package:bariq/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bariq/features/service_catalog/data/datasources/service_catalog_remote_data_source.dart';
import 'package:bariq/features/service_catalog/data/repositories/service_catalog_repository_impl.dart';
import 'package:bariq/features/service_catalog/domain/repositories/service_catalog_repository.dart';
import 'package:bariq/features/service_catalog/domain/usecases/load_service_detail.dart';
import 'package:bariq/features/service_catalog/domain/usecases/load_services.dart';
import 'package:bariq/features/service_catalog/presentation/cubit/service_catalog_cubit.dart';
import 'package:bariq/features/vehicles/data/datasources/vehicle_remote_data_source.dart';
import 'package:bariq/features/vehicles/data/repositories/vehicle_repository_impl.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:bariq/features/vehicles/domain/usecases/delete_vehicle.dart';
import 'package:bariq/features/vehicles/domain/usecases/load_vehicles.dart';
import 'package:bariq/features/vehicles/domain/usecases/save_vehicle.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies({
  AppStartupRepository? appStartupRepository,
  OnboardingRepository? onboardingRepository,
  AuthRepository? authRepository,
  ProfileRepository? profileRepository,
  VehicleRepository? vehicleRepository,
  AddressRepository? addressRepository,
  ServiceCatalogRepository? serviceCatalogRepository,
  BookingRepository? bookingRepository,
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
    ..registerLazySingleton<AppStartupProfileDataSource>(
      () => SupabaseAppStartupProfileDataSource(supabaseClient),
    )
    ..registerLazySingleton<AppStartupRepository>(
      () =>
          appStartupRepository ??
          AppStartupRepositoryImpl(getIt(), getIt(), getIt(), getIt()),
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
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => SupabaseAuthRemoteDataSource(supabaseClient),
    )
    ..registerLazySingleton<AuthRepository>(
      () => authRepository ?? AuthRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<SignInWithEmail>(() => SignInWithEmail(getIt()))
    ..registerLazySingleton<SignUpWithEmail>(() => SignUpWithEmail(getIt()))
    ..registerLazySingleton<RequestPasswordReset>(
      () => RequestPasswordReset(getIt()),
    )
    ..registerLazySingleton<UpdatePassword>(() => UpdatePassword(getIt()))
    ..registerLazySingleton<SignInWithGoogle>(() => SignInWithGoogle(getIt()))
    ..registerLazySingleton<WatchAuthSession>(() => WatchAuthSession(getIt()))
    ..registerFactory<AuthBloc>(
      () => AuthBloc(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
    )
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => SupabaseProfileRemoteDataSource(supabaseClient),
    )
    ..registerLazySingleton<ProfileRepository>(
      () => profileRepository ?? ProfileRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<LoadCustomerProfile>(
      () => LoadCustomerProfile(getIt()),
    )
    ..registerLazySingleton<SaveCustomerProfile>(
      () => SaveCustomerProfile(getIt()),
    )
    ..registerFactory<ProfileBloc>(() => ProfileBloc(getIt(), getIt()))
    ..registerLazySingleton<VehicleRemoteDataSource>(
      () => SupabaseVehicleRemoteDataSource(supabaseClient),
    )
    ..registerLazySingleton<VehicleRepository>(
      () => vehicleRepository ?? VehicleRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<LoadVehicles>(() => LoadVehicles(getIt()))
    ..registerLazySingleton<SaveVehicle>(() => SaveVehicle(getIt()))
    ..registerLazySingleton<DeleteVehicle>(() => DeleteVehicle(getIt()))
    ..registerFactory<VehiclesBloc>(
      () => VehiclesBloc(getIt(), getIt(), getIt()),
    )
    ..registerLazySingleton<AddressRemoteDataSource>(
      () => SupabaseAddressRemoteDataSource(supabaseClient),
    )
    ..registerLazySingleton<AddressRepository>(
      () =>
          addressRepository ??
          AddressRepositoryImpl(getIt(), getIt(), supabaseClient),
    )
    ..registerLazySingleton<LoadAddresses>(() => LoadAddresses(getIt()))
    ..registerLazySingleton<SaveAddress>(() => SaveAddress(getIt()))
    ..registerLazySingleton<DeleteAddress>(() => DeleteAddress(getIt()))
    ..registerLazySingleton<LoadZones>(() => LoadZones(getIt()))
    ..registerFactory<AddressesBloc>(
      () => AddressesBloc(getIt(), getIt(), getIt(), getIt()),
    )
    ..registerLazySingleton<ServiceCatalogRemoteDataSource>(
      () => SupabaseServiceCatalogRemoteDataSource(supabaseClient),
    )
    ..registerLazySingleton<ServiceCatalogRepository>(
      () =>
          serviceCatalogRepository ??
          ServiceCatalogRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<LoadServices>(() => LoadServices(getIt()))
    ..registerLazySingleton<LoadServiceDetail>(() => LoadServiceDetail(getIt()))
    ..registerFactory<ServiceCatalogCubit>(() => ServiceCatalogCubit(getIt()))
    ..registerFactory<ServiceDetailCubit>(() => ServiceDetailCubit(getIt()))
    ..registerLazySingleton<BookingRemoteDataSource>(
      () => SupabaseBookingRemoteDataSource(supabaseClient),
    )
    ..registerLazySingleton<BookingRepository>(
      () => bookingRepository ?? BookingRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<LoadAvailableSlots>(
      () => LoadAvailableSlots(getIt()),
    )
    ..registerLazySingleton<CreateBooking>(() => CreateBooking(getIt()))
    ..registerFactory<BookingBloc>(() => BookingBloc(getIt(), getIt()));
}
