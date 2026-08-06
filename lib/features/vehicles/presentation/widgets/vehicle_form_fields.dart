import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_class.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicle_choice_row.dart';
import 'package:flutter/material.dart';

class VehicleFormFields extends StatelessWidget {
  const VehicleFormFields({
    required this.makeController,
    required this.modelController,
    required this.colorController,
    required this.plateController,
    required this.selectedYear,
    required this.availableYears,
    required this.selectedClass,
    required this.isDefault,
    required this.isDefaultLocked,
    required this.enabled,
    required this.onYearChanged,
    required this.onClassChanged,
    required this.onDefaultChanged,
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
  final bool enabled;
  final ValueChanged<int?> onYearChanged;
  final ValueChanged<VehicleClass?> onClassChanged;
  final ValueChanged<bool> onDefaultChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: makeController,
          enabled: enabled,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: AppStrings.vehicleMake),
        ),
        SizedBox(height: AppSpacing.fieldGap),
        TextField(
          controller: modelController,
          enabled: enabled,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: AppStrings.vehicleModel),
        ),
        SizedBox(height: AppSpacing.fieldGap),
        VehicleChoiceRow(
          selectedYear: selectedYear,
          availableYears: availableYears,
          selectedClass: selectedClass,
          enabled: enabled,
          onYearChanged: onYearChanged,
          onClassChanged: onClassChanged,
        ),
        SizedBox(height: AppSpacing.fieldGap),
        TextField(
          controller: colorController,
          enabled: enabled,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: AppStrings.vehicleColor),
        ),
        SizedBox(height: AppSpacing.fieldGap),
        TextField(
          controller: plateController,
          enabled: enabled,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: AppStrings.vehiclePlate,
            hintText: AppStrings.vehiclePlateHint,
          ),
        ),
        SizedBox(height: AppSpacing.compact),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          value: isDefault,
          onChanged: enabled && !isDefaultLocked ? onDefaultChanged : null,
          title: const Text(AppStrings.makeDefaultVehicle),
          subtitle: Text(
            isDefaultLocked
                ? AppStrings.defaultVehicleLockedHint
                : AppStrings.makeDefaultVehicleHint,
          ),
        ),
      ],
    );
  }
}
