import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/core/widgets/bariq_brand_mark.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_form_fields.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_screen_shell.dart';
import 'package:flutter/material.dart';

class PasswordRecoveryContent extends StatelessWidget {
  const PasswordRecoveryContent({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.onSubmit,
    this.errorMessage,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final VoidCallback onSubmit;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return AuthScreenShell(
      child: AuthConstrainedContent(
        child: Column(
          children: [
            BariqBrandMark(width: AppSizes.authBrandWidth),
            SizedBox(height: AppSpacing.section),
            Text(
              AppStrings.passwordRecoveryTitle,
              style: AppTextStyles.authTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.compact),
            Text(
              AppStrings.passwordRecoveryBody,
              style: AppTextStyles.authSubtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.section),
            _PasswordRecoveryCard(
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              isLoading: isLoading,
              errorMessage: errorMessage,
              onSubmit: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordRecoveryCard extends StatelessWidget {
  const _PasswordRecoveryCard({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.onSubmit,
    this.errorMessage,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final VoidCallback onSubmit;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.authCardHorizontal,
          vertical: AppSpacing.authCardVertical,
        ),
        child: Column(
          children: [
            AuthFormFields(
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              showEmail: false,
              showConfirmationField: true,
              enabled: !isLoading,
              onSubmitted: onSubmit,
            ),
            if (errorMessage case final message?) ...[
              SizedBox(height: AppSpacing.regular),
              Text(
                message,
                style: AppTextStyles.errorCaption,
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: AppSpacing.section),
            SizedBox(
              width: double.infinity,
              height: AppSizes.authButtonHeight,
              child: FilledButton(
                onPressed: isLoading ? null : onSubmit,
                child: isLoading
                    ? SizedBox.square(
                        dimension: AppSizes.authLoadingIndicator,
                        child: CircularProgressIndicator(
                          strokeWidth: AppSizes.authLoadingStroke,
                          color: AppColors.surface,
                        ),
                      )
                    : const Text(AppStrings.saveNewPassword),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
