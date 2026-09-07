import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class VehiclesEmptyView extends StatelessWidget {
  const VehiclesEmptyView({required this.onAdd, super.key});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.section,
            vertical: AppSpacing.spacious,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.directions_car_filled_outlined,
                size: AppSizes.vehicleEmptyIcon,
                color: AppColors.aqua,
              ),
              SizedBox(height: AppSpacing.regular),
              Text(
                AppStrings.emptyVehiclesTitle,
                style: AppTextStyles.title,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.compact),
              Text(
                AppStrings.emptyVehiclesBody,
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.section),
              FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_rounded),
                label: const Text(AppStrings.addVehicle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
