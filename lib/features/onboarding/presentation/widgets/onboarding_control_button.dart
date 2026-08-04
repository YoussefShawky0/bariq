import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingControlButton extends StatelessWidget {
  const OnboardingControlButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.onboardingButtonHeight,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.navy,
          foregroundColor: AppColors.surface,
          disabledBackgroundColor: AppColors.navy,
          disabledForegroundColor: AppColors.surface,
          textStyle: AppTextStyles.onboardingButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.onboardingButton),
          ),
        ),
        child: isLoading ? const _OnboardingLoadingIndicator() : Text(label),
      ),
    );
  }
}

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(textStyle: AppTextStyles.onboardingSkip),
      child: Text(label, style: AppTextStyles.onboardingSkip),
    );
  }
}

class _OnboardingLoadingIndicator extends StatelessWidget {
  const _OnboardingLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppSizes.onboardingLoadingIndicator,
      child: CircularProgressIndicator(
        color: AppColors.surface,
        strokeWidth: AppSizes.onboardingLoadingStroke,
      ),
    );
  }
}
