import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class VehiclesLoadingView extends StatelessWidget {
  const VehiclesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: AppSizes.vehicleLoadingIndicator,
        child: CircularProgressIndicator(
          strokeWidth: AppSizes.vehicleLoadingStroke,
        ),
      ),
    );
  }
}

class VehiclesLoadFailureView extends StatelessWidget {
  const VehiclesLoadFailureView({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.vehiclesLoadFailed,
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.regular),
          FilledButton(onPressed: onRetry, child: const Text(AppStrings.retry)),
        ],
      ),
    );
  }
}
