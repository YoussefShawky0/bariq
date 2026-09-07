import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/core/widgets/bariq_brand_mark.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_screen_shell.dart';
import 'package:flutter/material.dart';

class AuthFeedbackContent extends StatelessWidget {
  const AuthFeedbackContent({
    required this.title,
    required this.body,
    required this.email,
    required this.onBackToSignIn,
    super.key,
  });

  final String title;
  final String body;
  final String email;
  final VoidCallback onBackToSignIn;

  @override
  Widget build(BuildContext context) {
    return AuthScreenShell(
      child: AuthConstrainedContent(
        child: Column(
          children: [
            BariqBrandMark(width: AppSizes.authBrandWidth),
            SizedBox(height: AppSpacing.spacious),
            Icon(
              Icons.mark_email_read_outlined,
              color: AppColors.success,
              size: AppSizes.authFeedbackIcon,
            ),
            SizedBox(height: AppSpacing.section),
            Text(
              title,
              style: AppTextStyles.authTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.compact),
            Text(
              body,
              style: AppTextStyles.authSubtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.regular),
            Text(
              AppStrings.emailSentTo(email),
              style: AppTextStyles.successCaption,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.spacious),
            SizedBox(
              width: double.infinity,
              height: AppSizes.authButtonHeight,
              child: FilledButton(
                onPressed: onBackToSignIn,
                child: const Text(AppStrings.backToSignIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
