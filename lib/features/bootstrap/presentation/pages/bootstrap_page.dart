import 'package:bariq/features/bootstrap/domain/entities/app_destination.dart';
import 'package:bariq/features/bootstrap/presentation/cubit/bootstrap_cubit.dart';
import 'package:bariq/features/bootstrap/presentation/widgets/bootstrap_views.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bariq/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BootstrapPage extends StatelessWidget {
  const BootstrapPage({required this.onboardingCubitFactory, super.key});

  final OnboardingCubit Function() onboardingCubitFactory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BootstrapCubit, BootstrapState>(
      builder: (context, state) {
        return state.when(
          initial: BootstrapLoadingView.new,
          loading: BootstrapLoadingView.new,
          ready: (destination) => _BootstrapDestinationView(
            destination: destination,
            onboardingCubitFactory: onboardingCubitFactory,
          ),
          failure: (_) => BootstrapFailureView(
            onRetry: context.read<BootstrapCubit>().initialize,
          ),
        );
      },
    );
  }
}

class _BootstrapDestinationView extends StatelessWidget {
  const _BootstrapDestinationView({
    required this.destination,
    required this.onboardingCubitFactory,
  });

  final AppDestination destination;
  final OnboardingCubit Function() onboardingCubitFactory;

  @override
  Widget build(BuildContext context) {
    if (destination != AppDestination.onboarding) {
      return BootstrapReadyView(destination);
    }

    return BlocProvider<OnboardingCubit>(
      create: (_) => onboardingCubitFactory(),
      child: OnboardingPage(
        onCompleted: context.read<BootstrapCubit>().initialize,
      ),
    );
  }
}
