import 'dart:async';

import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:bariq/features/app_startup/presentation/widgets/app_startup_destination_view.dart';
import 'package:bariq/features/app_startup/presentation/widgets/app_startup_views.dart';
import 'package:bariq/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bariq/features/auth/presentation/pages/auth_page.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bariq/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStartupPage extends StatelessWidget {
  const AppStartupPage({
    required this.onboardingCubitFactory,
    required this.authBlocFactory,
    required this.profileBlocFactory,
    required this.vehiclesBlocFactory,
    super.key,
  });

  final OnboardingCubit Function() onboardingCubitFactory;
  final AuthBloc Function() authBlocFactory;
  final ProfileBloc Function() profileBlocFactory;
  final VehiclesBloc Function() vehiclesBlocFactory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => authBlocFactory(),
      child: _AppStartupAuthCoordinator(
        onboardingCubitFactory: onboardingCubitFactory,
        profileBlocFactory: profileBlocFactory,
        vehiclesBlocFactory: vehiclesBlocFactory,
      ),
    );
  }
}

class _AppStartupAuthCoordinator extends StatelessWidget {
  const _AppStartupAuthCoordinator({
    required this.onboardingCubitFactory,
    required this.profileBlocFactory,
    required this.vehiclesBlocFactory,
  });

  final OnboardingCubit Function() onboardingCubitFactory;
  final ProfileBloc Function() profileBlocFactory;
  final VehiclesBloc Function() vehiclesBlocFactory;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (_, current) => current is AuthAuthenticated,
      listener: (context, _) {
        final startupState = context.read<AppStartupCubit>().state;
        final requiresRefresh = startupState.maybeWhen(
          ready: (destination) => destination == AppDestination.signIn,
          orElse: () => false,
        );
        if (requiresRefresh) {
          unawaited(context.read<AppStartupCubit>().initialize());
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) =>
            _isPasswordRecovery(previous) || _isPasswordRecovery(current),
        builder: (context, authState) {
          if (_isPasswordRecovery(authState)) {
            return const AuthPage();
          }
          return _AppStartupStateView(
            onboardingCubitFactory: onboardingCubitFactory,
            profileBlocFactory: profileBlocFactory,
            vehiclesBlocFactory: vehiclesBlocFactory,
          );
        },
      ),
    );
  }
}

class _AppStartupStateView extends StatelessWidget {
  const _AppStartupStateView({
    required this.onboardingCubitFactory,
    required this.profileBlocFactory,
    required this.vehiclesBlocFactory,
  });

  final OnboardingCubit Function() onboardingCubitFactory;
  final ProfileBloc Function() profileBlocFactory;
  final VehiclesBloc Function() vehiclesBlocFactory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStartupCubit, AppStartupState>(
      builder: (context, state) {
        return state.when(
          initial: AppStartupLoadingView.new,
          loading: AppStartupLoadingView.new,
          ready: (destination) => AppStartupDestinationView(
            destination: destination,
            onboardingCubitFactory: onboardingCubitFactory,
            profileBlocFactory: profileBlocFactory,
            vehiclesBlocFactory: vehiclesBlocFactory,
          ),
          failure: (_) => AppStartupFailureView(
            onRetry: context.read<AppStartupCubit>().initialize,
          ),
        );
      },
    );
  }
}

bool _isPasswordRecovery(AuthState state) =>
    state is AuthPasswordRecovery ||
    state is AuthPasswordUpdating ||
    state is AuthPasswordUpdateFailure;
