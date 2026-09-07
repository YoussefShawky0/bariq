import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_class.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicle_form_fields.dart';
import 'package:flutter/material.dart';

class VehicleFormContent extends StatelessWidget {
  const VehicleFormContent({
    required this.makeController,
    required this.modelController,
    required this.colorController,
    required this.plateController,
    required this.selectedYear,
    required this.availableYears,
    required this.selectedClass,
    required this.isDefault,
    required this.isDefaultLocked,
    required this.isLoading,
    required this.onYearChanged,
    required this.onClassChanged,
    required this.onDefaultChanged,
    required this.onSubmit,
    this.errorMessage,
    super.key,
  });

  final TextEditingController makeController;
  final TextEditingController modelController;
  final TextEditingController colorController;
  final TextEditingController plateController;
  final int selectedYear;
  final List<int> availableYears;
  final VehicleClass selectedClass;
  final bool isDefault;
  final bool isDefaultLocked;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<int?> onYearChanged;
  final ValueChanged<VehicleClass?> onClassChanged;
  final ValueChanged<bool> onDefaultChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.pageHorizontal,
          vertical: AppSpacing.pageVertical,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppSizes.vehiclesContentMaxWidth,
            ),
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.profileCardHorizontal,
                  vertical: AppSpacing.profileCardVertical,
                ),
                child: _VehicleFormBody(
                  fields: VehicleFormFields(
                    makeController: makeController,
                    modelController: modelController,
                    colorController: colorController,
                    plateController: plateController,
                    selectedYear: selectedYear,
                    availableYears: availableYears,
                    selectedClass: selectedClass,
                    isDefault: isDefault,
                    isDefaultLocked: isDefaultLocked,
                    enabled: !isLoading,
                    onYearChanged: onYearChanged,
                    onClassChanged: onClassChanged,
                    onDefaultChanged: onDefaultChanged,
                  ),
                  errorMessage: errorMessage,
                  isLoading: isLoading,
                  onSubmit: onSubmit,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VehicleFormBody extends StatelessWidget {
  const _VehicleFormBody({
    required this.fields,
    required this.isLoading,
    required this.onSubmit,
    this.errorMessage,
  });

  final Widget fields;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        fields,
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
          height: AppSizes.vehicleButtonHeight,
          child: FilledButton(
            onPressed: isLoading ? null : onSubmit,
            child: isLoading
                ? SizedBox.square(
                    dimension: AppSizes.vehicleLoadingIndicator,
                    child: CircularProgressIndicator(
                      strokeWidth: AppSizes.vehicleLoadingStroke,
                    ),
                  )
                : const Text(AppStrings.saveVehicle),
          ),
        ),
      ],
    );
  }
}
