import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileTermsSheet extends StatelessWidget {
  const ProfileTermsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.pageHorizontal,
          vertical: AppSpacing.pageVertical,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.aquaSurface,
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.compact),
                  child: Icon(
                    Icons.verified_user_outlined,
                    color: AppColors.aqua,
                    size: AppSizes.profileTermsIcon,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.regular),
            Text(AppStrings.termsTitle, style: AppTextStyles.title),
            SizedBox(height: AppSpacing.regular),
            Text(AppStrings.termsIntro, style: AppTextStyles.onboardingBody),
            SizedBox(height: AppSpacing.regular),
            Text(AppStrings.termsPrivacy, style: AppTextStyles.onboardingBody),
            SizedBox(height: AppSpacing.regular),
            Text(AppStrings.termsControl, style: AppTextStyles.onboardingBody),
            SizedBox(height: AppSpacing.section),
            SizedBox(
              height: AppSizes.profileButtonHeight,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(AppStrings.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showProfileTermsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    barrierColor: AppColors.scrim,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.large),
      ),
    ),
    builder: (_) => const ProfileTermsSheet(),
  );
}
