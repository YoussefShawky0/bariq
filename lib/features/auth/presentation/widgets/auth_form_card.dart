import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/features/auth/domain/entities/auth_mode.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_form_card_body.dart';
import 'package:flutter/material.dart';

class AuthFormCard extends StatelessWidget {
  const AuthFormCard({
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
        child: AuthFormCardBody(
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
      ),
    );
  }
}
