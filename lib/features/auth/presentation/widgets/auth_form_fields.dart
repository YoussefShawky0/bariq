import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AuthFormFields extends StatefulWidget {
  const AuthFormFields({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.showEmail,
    required this.showConfirmationField,
    required this.enabled,
    required this.onSubmitted,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool showEmail;
  final bool showConfirmationField;
  final bool enabled;
  final VoidCallback onSubmitted;

  @override
  State<AuthFormFields> createState() => _AuthFormFieldsState();
}

class _AuthFormFieldsState extends State<AuthFormFields> {
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        children: [
          if (widget.showEmail) ...[
            TextField(
              controller: widget.emailController,
              enabled: widget.enabled,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                labelText: AppStrings.email,
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
            ),
            SizedBox(height: AppSpacing.fieldGap),
          ],
          TextField(
            controller: widget.passwordController,
            enabled: widget.enabled,
            obscureText: _obscurePassword,
            textInputAction: widget.showConfirmationField
                ? TextInputAction.next
                : TextInputAction.done,
            autofillHints: widget.showConfirmationField
                ? const [AutofillHints.newPassword]
                : const [AutofillHints.password],
            onSubmitted: (_) {
              if (!widget.showConfirmationField) widget.onSubmitted();
            },
            decoration: InputDecoration(
              labelText: AppStrings.password,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: _VisibilityButton(
                obscured: _obscurePassword,
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
          if (widget.showConfirmationField) ...[
            SizedBox(height: AppSpacing.fieldGap),
            TextField(
              controller: widget.confirmPasswordController,
              enabled: widget.enabled,
              obscureText: _obscureConfirmation,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => widget.onSubmitted(),
              decoration: InputDecoration(
                labelText: AppStrings.confirmPassword,
                prefixIcon: const Icon(Icons.verified_user_outlined),
                suffixIcon: _VisibilityButton(
                  obscured: _obscureConfirmation,
                  onPressed: () => setState(
                    () => _obscureConfirmation = !_obscureConfirmation,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _VisibilityButton extends StatelessWidget {
  const _VisibilityButton({required this.obscured, required this.onPressed});

  final bool obscured;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: AppSizes.authIcon,
      onPressed: onPressed,
      icon: Icon(
        obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      ),
    );
  }
}
