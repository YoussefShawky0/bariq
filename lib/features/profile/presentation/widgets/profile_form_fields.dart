import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/profile/domain/entities/egypt_governorates.dart';
import 'package:bariq/features/profile/domain/entities/egyptian_mobile_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileFormFields extends StatelessWidget {
  const ProfileFormFields({
    required this.email,
    required this.fullNameController,
    required this.phoneController,
    required this.selectedGovernorate,
    required this.areaController,
    required this.onGovernorateChanged,
    required this.enabled,
    super.key,
  });

  final String email;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final String? selectedGovernorate;
  final TextEditingController areaController;
  final ValueChanged<String?> onGovernorateChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: email,
          readOnly: true,
          enabled: false,
          decoration: const InputDecoration(
            labelText: AppStrings.email,
            prefixIcon: Icon(Icons.alternate_email_rounded),
          ),
        ),
        SizedBox(height: AppSpacing.fieldGap),
        TextField(
          controller: fullNameController,
          enabled: enabled,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          autofillHints: const [AutofillHints.name],
          decoration: const InputDecoration(
            labelText: AppStrings.fullName,
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        SizedBox(height: AppSpacing.section),
        Text(
          AppStrings.bookingDetailsSection,
          style: AppTextStyles.sectionTitle,
        ),
        SizedBox(height: AppSpacing.tiny),
        Text(AppStrings.bookingDetailsHint, style: AppTextStyles.helper),
        SizedBox(height: AppSpacing.regular),
        TextField(
          controller: phoneController,
          enabled: enabled,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          textDirection: TextDirection.ltr,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(
              EgyptianMobileNumber.maxLocalDigits,
            ),
          ],
          autofillHints: const [AutofillHints.telephoneNumberNational],
          decoration: const InputDecoration(
            labelText: AppStrings.phoneNumber,
            hintText: AppStrings.phoneHint,
            helperText: AppStrings.phoneUnverifiedHint,
            prefixText: AppStrings.egyptCountryCodePrefix,
            prefixIcon: Icon(Icons.phone_outlined),
          ),
        ),
        SizedBox(height: AppSpacing.fieldGap),
        DropdownButtonFormField<String>(
          initialValue: selectedGovernorate,
          isExpanded: true,
          items: EgyptGovernorates.values
              .map(
                (governorate) => DropdownMenuItem(
                  value: governorate,
                  child: Text(governorate),
                ),
              )
              .toList(growable: false),
          onChanged: enabled ? onGovernorateChanged : null,
          decoration: const InputDecoration(
            labelText: AppStrings.city,
            hintText: AppStrings.governorateHint,
            prefixIcon: Icon(Icons.location_city_outlined),
          ),
        ),
        SizedBox(height: AppSpacing.fieldGap),
        TextField(
          controller: areaController,
          enabled: enabled,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: AppStrings.area,
            prefixIcon: Icon(Icons.place_outlined),
          ),
        ),
      ],
    );
  }
}
