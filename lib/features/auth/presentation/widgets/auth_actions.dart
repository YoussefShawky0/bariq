import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/auth/domain/entities/auth_mode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    required this.mode,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final AuthMode mode;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.authButtonHeight,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox.square(
                dimension: AppSizes.authLoadingIndicator,
                child: CircularProgressIndicator(
                  strokeWidth: AppSizes.authLoadingStroke,
                  color: AppColors.surface,
                ),
              )
            : Text(
                mode == AuthMode.signIn
                    ? AppStrings.signIn
                    : AppStrings.createAccount,
              ),
      ),
    );
  }
}

class AuthGoogleButton extends StatelessWidget {
  const AuthGoogleButton({
    required this.enabled,
    required this.onPressed,
    super.key,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.authButtonHeight,
      child: OutlinedButton.icon(
        onPressed: enabled ? onPressed : null,
        icon: const FaIcon(FontAwesomeIcons.google, size: 20),
        label: const Text(AppStrings.continueWithGoogle),
      ),
    );
  }
}

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.regular),
          child: Text(
            AppStrings.orContinueWith,
            style: AppTextStyles.authCaption,
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}
