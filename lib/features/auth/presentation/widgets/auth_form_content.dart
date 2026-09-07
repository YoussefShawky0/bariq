import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/core/widgets/bariq_brand_mark.dart';
import 'package:bariq/features/auth/domain/entities/auth_mode.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_form_card.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_screen_shell.dart';
import 'package:flutter/material.dart';

class AuthFormContent extends StatelessWidget {
  const AuthFormContent({
    required this.mode,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.onSubmit,
    required this.onGoogle,
    required this.onForgotPassword,
    required this.onToggleMode,
    this.errorMessage,
    this.noticeMessage,
    super.key,
  });

  final AuthMode mode;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onGoogle;
  final VoidCallback onForgotPassword;
  final VoidCallback onToggleMode;
  final String? errorMessage;
  final String? noticeMessage;

  @override
  Widget build(BuildContext context) {
    final isSignIn = mode == AuthMode.signIn;
    return AuthScreenShell(
      child: AuthConstrainedContent(
        child: Column(
          children: [
            BariqBrandMark(width: AppSizes.authBrandWidth),
            SizedBox(height: AppSpacing.section),
            Text(
              isSignIn ? AppStrings.signInTitle : AppStrings.signUpTitle,
              style: AppTextStyles.authTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.compact),
            Text(
              isSignIn ? AppStrings.signInSubtitle : AppStrings.signUpSubtitle,
              style: AppTextStyles.authSubtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.section),
            AuthFormCard(
              mode: mode,
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              isLoading: isLoading,
              errorMessage: errorMessage,
              noticeMessage: noticeMessage,
              onSubmit: onSubmit,
              onGoogle: onGoogle,
              onForgotPassword: onForgotPassword,
              onToggleMode: onToggleMode,
            ),
            SizedBox(height: AppSpacing.regular),
            Text(
              AppStrings.secureAuthHint,
              style: AppTextStyles.authCaption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
