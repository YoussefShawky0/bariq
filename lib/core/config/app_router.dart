import 'package:bariq/core/di/injection.dart';
import 'package:bariq/features/addresses/presentation/bloc/addresses_bloc.dart';
import 'package:bariq/features/addresses/presentation/pages/address_form_page.dart';
import 'package:bariq/features/addresses/presentation/pages/addresses_page.dart';
import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:bariq/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bariq/features/auth/presentation/pages/auth_page.dart';
import 'package:bariq/features/home/presentation/pages/home_page.dart';
import 'package:bariq/features/home/presentation/pages/main_shell.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bariq/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:bariq/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bariq/features/profile/presentation/pages/profile_completion_page.dart';
import 'package:bariq/features/service_catalog/presentation/pages/service_detail_page.dart';
import 'package:bariq/features/service_catalog/presentation/pages/services_page.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:bariq/features/vehicles/presentation/pages/vehicle_form_page.dart';
import 'package:bariq/features/vehicles/presentation/pages/vehicles_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Route path constants for type-safe navigation.
abstract final class AppRoutes {
  static const String startup = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String profileCompletion = '/profile-completion';
  static const String home = '/home';
  static const String vehicles = '/vehicles';
  static const String vehicleAdd = '/vehicles/add';
  static const String addresses = '/addresses';
  static const String addressAdd = '/addresses/add';
  static const String services = '/services';

  static String vehicleEdit(String id) => '/vehicles/$id/edit';
  static String serviceDetail(String id) => '/services/$id';
}

/// Creates the application router driven by [AppStartupCubit] state.
GoRouter createAppRouter(AppStartupCubit startupCubit) {
  return GoRouter(
    initialLocation: AppRoutes.startup,
    refreshListenable: _StartupRefreshNotifier(startupCubit),
    redirect: (context, state) => _redirect(startupCubit, state),
    routes: [
      // Startup splash — shown while cubit resolves destination.
      GoRoute(path: AppRoutes.startup, builder: (_, _) => const _StartupView()),

      // Pre-auth routes.
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, _) => BlocProvider<OnboardingCubit>(
          create: (_) => getIt<OnboardingCubit>(),
          child: OnboardingPage(onCompleted: startupCubit.initialize),
        ),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (_, _) => BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
          child: const AuthPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.profileCompletion,
        builder: (_, _) => BlocProvider<ProfileBloc>(
          create: (_) =>
              getIt<ProfileBloc>()..add(const ProfileEvent.started()),
          child: ProfileCompletionPage(onCompleted: startupCubit.initialize),
        ),
      ),

      // Main app shell with bottom navigation.
      ShellRoute(
        builder: (_, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (_, _) => const NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: AppRoutes.vehicles,
            pageBuilder: (_, _) => NoTransitionPage(
              child: BlocProvider<VehiclesBloc>(
                create: (_) =>
                    getIt<VehiclesBloc>()..add(const VehiclesEvent.started()),
                child: const VehiclesPage(),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.addresses,
            pageBuilder: (_, _) => NoTransitionPage(
              child: BlocProvider<AddressesBloc>(
                create: (_) =>
                    getIt<AddressesBloc>()..add(const AddressesEvent.started()),
                child: const AddressesPage(),
              ),
            ),
          ),
          GoRoute(
            path: AppRoutes.services,
            pageBuilder: (_, _) =>
                const NoTransitionPage(child: ServicesPage()),
          ),
        ],
      ),

      // Detail / form routes outside shell (full-screen).
      GoRoute(
        path: AppRoutes.vehicleAdd,
        builder: (_, _) => const VehicleFormPage(),
      ),
      GoRoute(
        path: '/vehicles/:id/edit',
        builder: (_, state) =>
            VehicleFormPage(vehicle: state.extra as Vehicle?),
      ),
      GoRoute(
        path: AppRoutes.addressAdd,
        builder: (_, _) => const AddressFormPage(),
      ),
      GoRoute(
        path: '/services/:id',
        builder: (_, state) =>
            ServiceDetailPage(serviceId: state.pathParameters['id']!),
      ),
    ],
  );
}

/// Redirect logic driven by [AppStartupCubit] state.
String? _redirect(AppStartupCubit cubit, GoRouterState state) {
  final startupState = cubit.state;

  // While loading/initial, stay on startup.
  if (startupState is AppStartupInitial || startupState is AppStartupLoading) {
    return state.matchedLocation == AppRoutes.startup
        ? null
        : AppRoutes.startup;
  }

  // On failure, stay on startup (shows error view).
  if (startupState is AppStartupFailure) {
    return state.matchedLocation == AppRoutes.startup
        ? null
        : AppRoutes.startup;
  }

  // Resolved destination.
  if (startupState is AppStartupReady) {
    final destination = startupState.destination;
    final targetPath = switch (destination) {
      AppDestination.onboarding => AppRoutes.onboarding,
      AppDestination.signIn => AppRoutes.auth,
      AppDestination.profileCompletion => AppRoutes.profileCompletion,
      AppDestination.home => AppRoutes.home,
    };

    // If already at a valid post-home location, don't redirect.
    if (destination == AppDestination.home) {
      final loc = state.matchedLocation;
      if (loc == AppRoutes.home ||
          loc.startsWith('/vehicles') ||
          loc.startsWith('/addresses') ||
          loc.startsWith('/services')) {
        return null;
      }
    }

    return state.matchedLocation == targetPath ? null : targetPath;
  }

  return null;
}

/// Converts [AppStartupCubit] stream to a [ChangeNotifier] for GoRouter.
class _StartupRefreshNotifier extends ChangeNotifier {
  _StartupRefreshNotifier(AppStartupCubit cubit) {
    _subscription = cubit.stream.listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    (_subscription as dynamic).cancel();
    super.dispose();
  }
}

/// Minimal startup view shown while [AppStartupCubit] resolves.
class _StartupView extends StatelessWidget {
  const _StartupView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStartupCubit, AppStartupState>(
      builder: (context, state) {
        return state.when(
          initial: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          ready: (_) => const SizedBox.shrink(), // redirect handles this
          failure: (failure) => Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(failure.message),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: context.read<AppStartupCubit>().initialize,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
