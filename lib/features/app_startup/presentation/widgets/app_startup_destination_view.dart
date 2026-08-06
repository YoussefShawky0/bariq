import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:bariq/features/auth/presentation/pages/auth_page.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bariq/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:bariq/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bariq/features/profile/presentation/pages/profile_completion_page.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:bariq/features/vehicles/presentation/pages/vehicles_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStartupDestinationView extends StatelessWidget {
  const AppStartupDestinationView({
    required this.destination,
    required this.onboardingCubitFactory,
    required this.profileBlocFactory,
    required this.vehiclesBlocFactory,
    super.key,
  });

  final AppDestination destination;
  final OnboardingCubit Function() onboardingCubitFactory;
  final ProfileBloc Function() profileBlocFactory;
  final VehiclesBloc Function() vehiclesBlocFactory;

  @override
  Widget build(BuildContext context) {
    return switch (destination) {
      AppDestination.onboarding => BlocProvider<OnboardingCubit>(
        create: (_) => onboardingCubitFactory(),
        child: OnboardingPage(
          onCompleted: context.read<AppStartupCubit>().initialize,
        ),
      ),
      AppDestination.signIn => const AuthPage(),
      AppDestination.profileCompletion => BlocProvider<ProfileBloc>(
        create: (_) => profileBlocFactory()..add(const ProfileEvent.started()),
        child: ProfileCompletionPage(
          onCompleted: context.read<AppStartupCubit>().initialize,
        ),
      ),
      AppDestination.home => BlocProvider<VehiclesBloc>(
        create: (_) =>
            vehiclesBlocFactory()..add(const VehiclesEvent.started()),
        child: const VehiclesPage(),
      ),
    };
  }
}
