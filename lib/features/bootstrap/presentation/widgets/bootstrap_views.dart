import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/core/widgets/bariq_brand_mark.dart';
import 'package:bariq/features/bootstrap/domain/entities/app_destination.dart';
import 'package:flutter/material.dart';

class BootstrapLoadingView extends StatelessWidget {
  const BootstrapLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: BariqBrandMark())),
    );
  }
}

class BootstrapReadyView extends StatelessWidget {
  const BootstrapReadyView(this.destination, {super.key});

  final AppDestination destination;

  String get _message => switch (destination) {
    AppDestination.onboarding => AppStrings.onboardingNext,
    AppDestination.signIn => AppStrings.signInNext,
    AppDestination.home => AppStrings.homeNext,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.pageHorizontal,
              vertical: AppSpacing.pageVertical,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BariqBrandMark(),
                SizedBox(height: AppSpacing.section),
                Text(AppStrings.appName, style: AppTextStyles.brand),
                SizedBox(height: AppSpacing.compact),
                Text(
                  AppStrings.tagline,
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.spacious),
                Text(
                  AppStrings.foundationReady,
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.regular),
                Text(
                  _message,
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BootstrapFailureView extends StatelessWidget {
  const BootstrapFailureView({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.pageHorizontal,
              vertical: AppSpacing.pageVertical,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.initializationFailed,
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.regular),
                Text(
                  AppStrings.genericError,
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.section),
                FilledButton(
                  onPressed: onRetry,
                  child: const Text(AppStrings.retry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
