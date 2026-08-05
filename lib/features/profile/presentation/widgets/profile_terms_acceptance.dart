import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileTermsAcceptance extends StatelessWidget {
  const ProfileTermsAcceptance({
    required this.value,
    required this.enabled,
    required this.onChanged,
    required this.onViewTerms,
    super.key,
  });

  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final VoidCallback onViewTerms;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: enabled ? (next) => onChanged(next ?? false) : null,
        ),
        SizedBox(width: AppSpacing.compact),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.termsAgreement, style: AppTextStyles.authCaption),
              TextButton(
                onPressed: onViewTerms,
                child: Text(
                  AppStrings.viewTerms,
                  style: AppTextStyles.authLink,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
