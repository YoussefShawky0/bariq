import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/core/widgets/bariq_brand_mark.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BariqBrandMark(width: AppSizes.profileBrandWidth),
        SizedBox(height: AppSpacing.regular),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.aquaSurface,
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.regular,
              vertical: AppSpacing.compact,
            ),
            child: Text(
              AppStrings.profileStep,
              style: AppTextStyles.profileStep,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.regular),
        Text(
          AppStrings.profileTitle,
          style: AppTextStyles.authTitle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.compact),
        Text(
          AppStrings.profileSubtitle,
          style: AppTextStyles.authSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
