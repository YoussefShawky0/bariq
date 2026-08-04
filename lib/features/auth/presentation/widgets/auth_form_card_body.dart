import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/auth/domain/entities/auth_mode.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_actions.dart';
import 'package:bariq/features/auth/presentation/widgets/auth_form_fields.dart';
import 'package:flutter/material.dart';

class AuthFormCardBody extends StatelessWidget {
  const AuthFormCardBody({
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
    return Column(
      children: [
        AuthFormFields(
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
          showEmail: true,
          showConfirmationField: !isSignIn,
          enabled: !isLoading,
          onSubmitted: onSubmit,
        ),
        if (isSignIn)
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: isLoading ? null : onForgotPassword,
              child: const Text(AppStrings.forgotPassword),
            ),
          )
        else
          SizedBox(height: AppSpacing.regular),
        if (errorMessage case final message?)
          _AuthMessage(message: message, isError: true),
        if (noticeMessage case final message?)
          _AuthMessage(message: message, isError: false),
        AuthPrimaryButton(
          mode: mode,
          isLoading: isLoading,
          onPressed: onSubmit,
        ),
        SizedBox(height: AppSpacing.section),
        const AuthDivider(),
        SizedBox(height: AppSpacing.section),
        AuthGoogleButton(enabled: !isLoading, onPressed: onGoogle),
        SizedBox(height: AppSpacing.regular),
        _AuthModeSwitch(
          mode: mode,
          enabled: !isLoading,
          onPressed: onToggleMode,
        ),
      ],
    );
  }
}

class _AuthMessage extends StatelessWidget {
  const _AuthMessage({required this.message, required this.isError});

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.regular),
      child: Text(
        message,
        style: isError
            ? AppTextStyles.errorCaption
            : AppTextStyles.successCaption,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _AuthModeSwitch extends StatelessWidget {
  const _AuthModeSwitch({
    required this.mode,
    required this.enabled,
    required this.onPressed,
  });

  final AuthMode mode;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isSignIn = mode == AuthMode.signIn;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Text(
          isSignIn ? AppStrings.noAccount : AppStrings.haveAccount,
          style: AppTextStyles.authCaption,
        ),
        TextButton(
          onPressed: enabled ? onPressed : null,
          child: Text(isSignIn ? AppStrings.createAccount : AppStrings.signIn),
        ),
      ],
    );
  }
}
