import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:bariq/features/app_startup/presentation/widgets/app_startup_views.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bariq/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStartupPage extends StatelessWidget {
  const AppStartupPage({required this.onboardingCubitFactory, super.key});

  final OnboardingCubit Function() onboardingCubitFactory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStartupCubit, AppStartupState>(
      builder: (context, state) {
        return state.when(
          initial: AppStartupLoadingView.new,
          loading: AppStartupLoadingView.new,
          ready: (destination) => _AppStartupDestinationView(
            destination: destination,
            onboardingCubitFactory: onboardingCubitFactory,
          ),
          failure: (_) => AppStartupFailureView(
            onRetry: context.read<AppStartupCubit>().initialize,
          ),
        );
      },
    );
  }
}

class _AppStartupDestinationView extends StatelessWidget {
  const _AppStartupDestinationView({
    required this.destination,
    required this.onboardingCubitFactory,
  });

  final AppDestination destination;
  final OnboardingCubit Function() onboardingCubitFactory;

  @override
  Widget build(BuildContext context) {
    if (destination != AppDestination.onboarding) {
      return AppStartupReadyView(destination);
    }

    return BlocProvider<OnboardingCubit>(
      create: (_) => onboardingCubitFactory(),
      child: OnboardingPage(
        onCompleted: context.read<AppStartupCubit>().initialize,
      ),
    );
  }
}
