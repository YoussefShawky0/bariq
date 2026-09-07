import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_class.dart';
import 'package:flutter/material.dart';

class VehicleChoiceRow extends StatelessWidget {
  const VehicleChoiceRow({
    required this.selectedYear,
    required this.availableYears,
    required this.selectedClass,
    required this.enabled,
    required this.onYearChanged,
    required this.onClassChanged,
    super.key,
  });

  final int selectedYear;
  final List<int> availableYears;
  final VehicleClass selectedClass;
  final bool enabled;
  final ValueChanged<int?> onYearChanged;
  final ValueChanged<VehicleClass?> onClassChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: selectedYear,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: AppStrings.vehicleYear,
            ),
            items: availableYears
                .map(
                  (year) => DropdownMenuItem(value: year, child: Text('$year')),
                )
                .toList(growable: false),
            onChanged: enabled ? onYearChanged : null,
          ),
        ),
        SizedBox(width: AppSpacing.regular),
        Expanded(
          child: DropdownButtonFormField<VehicleClass>(
            initialValue: selectedClass,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: AppStrings.vehicleClassLabel,
            ),
            items: VehicleClass.values
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item.arabicLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(growable: false),
            onChanged: enabled ? onClassChanged : null,
          ),
        ),
      ],
    );
  }
}
