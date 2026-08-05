import 'dart:typed_data';

import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/profile/domain/entities/customer_profile.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_avatar_picker.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_form_card.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_form_fields.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_header.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_screen_shell.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_terms_acceptance.dart';
import 'package:flutter/material.dart';

class ProfileFormContent extends StatelessWidget {
  const ProfileFormContent({
    required this.profile,
    required this.fullNameController,
    required this.phoneController,
    required this.selectedGovernorate,
    required this.areaController,
    required this.selectedAvatar,
    required this.acceptedTerms,
    required this.isLoading,
    required this.onPickAvatar,
    required this.onGovernorateChanged,
    required this.onTermsChanged,
    required this.onViewTerms,
    required this.onSubmit,
    this.errorMessage,
    super.key,
  });

  final CustomerProfile profile;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final String? selectedGovernorate;
  final TextEditingController areaController;
  final Uint8List? selectedAvatar;
  final bool acceptedTerms;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onPickAvatar;
  final ValueChanged<String?> onGovernorateChanged;
  final ValueChanged<bool> onTermsChanged;
  final VoidCallback onViewTerms;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return ProfileScreenShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProfileHeader(),
          SizedBox(height: AppSpacing.section),
          ProfileFormCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileAvatarPicker(
                  selectedBytes: selectedAvatar,
                  currentUrl: profile.avatarUrl,
                  onPressed: onPickAvatar,
                  enabled: !isLoading,
                ),
                SizedBox(height: AppSpacing.regular),
                ProfileFormFields(
                  email: profile.email,
                  fullNameController: fullNameController,
                  phoneController: phoneController,
                  selectedGovernorate: selectedGovernorate,
                  areaController: areaController,
                  onGovernorateChanged: onGovernorateChanged,
                  enabled: !isLoading,
                ),
                SizedBox(height: AppSpacing.regular),
                ProfileTermsAcceptance(
                  value: acceptedTerms,
                  enabled: !isLoading,
                  onChanged: onTermsChanged,
                  onViewTerms: onViewTerms,
                ),
                if (errorMessage != null) ...[
                  SizedBox(height: AppSpacing.compact),
                  Text(
                    errorMessage!,
                    style: AppTextStyles.errorCaption,
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: AppSpacing.regular),
                SizedBox(
                  height: AppSizes.profileButtonHeight,
                  child: FilledButton(
                    onPressed: isLoading ? null : onSubmit,
                    child: isLoading
                        ? SizedBox.square(
                            dimension: AppSizes.profileLoadingIndicator,
                            child: CircularProgressIndicator(
                              strokeWidth: AppSizes.profileLoadingStroke,
                            ),
                          )
                        : const Text(AppStrings.saveAndContinue),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.regular),
          Text(
            AppStrings.profileSecureHint,
            style: AppTextStyles.authCaption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
