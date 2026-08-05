import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/core/widgets/bariq_brand_mark.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_screen_shell.dart';
import 'package:flutter/material.dart';

class ProfileLoadingView extends StatelessWidget {
  const ProfileLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreenShell(
      child: Column(
        children: [
          BariqBrandMark(width: AppSizes.profileBrandWidth),
          SizedBox(height: AppSpacing.section),
          SizedBox.square(
            dimension: AppSizes.profileLoadingIndicator,
            child: CircularProgressIndicator(
              strokeWidth: AppSizes.profileLoadingStroke,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileLoadFailureView extends StatelessWidget {
  const ProfileLoadFailureView({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ProfileScreenShell(
      child: Column(
        children: [
          BariqBrandMark(width: AppSizes.profileBrandWidth),
          SizedBox(height: AppSpacing.section),
          Text(
            AppStrings.profileLoadFailed,
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.regular),
          SizedBox(
            height: AppSizes.profileButtonHeight,
            child: FilledButton(
              onPressed: onRetry,
              child: const Text(AppStrings.retryProfile),
            ),
          ),
        ],
      ),
    );
  }
}
