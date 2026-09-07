import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class VehiclesHeader extends StatelessWidget {
  const VehiclesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppStrings.vehiclesSubtitle, style: AppTextStyles.body),
          SizedBox(height: AppSpacing.compact),
          Text(AppStrings.vehicleOwnershipHint, style: AppTextStyles.helper),
        ],
      ),
    );
  }
}
