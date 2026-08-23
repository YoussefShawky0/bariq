import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/di/injection.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_addon.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_detail.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_pricing.dart';
import 'package:bariq/features/service_catalog/presentation/cubit/service_catalog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Detailed view for a specific service.
class ServiceDetailPage extends StatelessWidget {
  const ServiceDetailPage({required this.serviceId, super.key});

  final String serviceId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceDetailCubit>(
      create: (_) => getIt<ServiceDetailCubit>()..load(serviceId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.serviceDetailsTitle),
        ),
        body: SafeArea(
          child: BlocBuilder<ServiceDetailCubit, ServiceDetailState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator()),
                ready: (detail) => _ServiceDetailContent(detail: detail),
                failure: (failure) => Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.section),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(failure.message, style: AppTextStyles.body),
                        SizedBox(height: AppSpacing.regular),
                        FilledButton(
                          onPressed: () => context
                              .read<ServiceDetailCubit>()
                              .load(serviceId),
                          child: const Text(AppStrings.retry),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ServiceDetailContent extends StatelessWidget {
  const _ServiceDetailContent({required this.detail});

  final ServiceDetail detail;

  @override
  Widget build(BuildContext context) {
    final service = detail.service;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.pageHorizontal,
        vertical: AppSpacing.pageVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header title & duration
          Text(service.nameAr, style: AppTextStyles.authTitle),
          SizedBox(height: AppSpacing.compact),
          Row(
            children: [
              Icon(Icons.schedule_rounded, size: 18.r, color: AppColors.aqua),
              SizedBox(width: 6.w),
              Text(
                AppStrings.homeDuration(service.baseDurationMinutes),
                style: AppTextStyles.helper.copyWith(color: AppColors.navy),
              ),
              SizedBox(width: 16.w),
              Icon(Icons.water_drop_outlined, size: 18.r, color: AppColors.aqua),
              SizedBox(width: 6.w),
              Text(
                AppStrings.noWaterRequired,
                style: AppTextStyles.helper.copyWith(color: AppColors.navy),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.section),

          // Description
          if (service.descriptionAr.isNotEmpty) ...[
            Text(AppStrings.serviceInclusions, style: AppTextStyles.sectionTitle),
            SizedBox(height: AppSpacing.compact),
            Container(
              padding: EdgeInsets.all(AppSpacing.regular),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.medium),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                service.descriptionAr,
                style: AppTextStyles.body,
              ),
            ),
            SizedBox(height: AppSpacing.section),
          ],

          // Pricing per vehicle class
          if (detail.pricingConfigs.isNotEmpty) ...[
            Text(AppStrings.serviceSelectVehicleClass,
                style: AppTextStyles.sectionTitle),
            SizedBox(height: AppSpacing.compact),
            ...detail.pricingConfigs.map((pricing) => _PricingRow(pricing)),
            SizedBox(height: AppSpacing.section),
          ],

          // Add-ons
          if (detail.addons.isNotEmpty) ...[
            Text(AppStrings.serviceAddons, style: AppTextStyles.sectionTitle),
            SizedBox(height: AppSpacing.compact),
            ...detail.addons.map((addon) => _AddonCard(addon)),
            SizedBox(height: AppSpacing.section),
          ],
        ],
      ),
    );
  }
}

class _PricingRow extends StatelessWidget {
  const _PricingRow(this.pricing);
  final ServicePricing pricing;

  String _formatVehicleClass(String vClass) {
    switch (vClass.toLowerCase()) {
      case 'sedan':
        return 'سيدان';
      case 'suv':
        return 'دفع رباعي / SUV';
      case 'hatchback':
        return 'هاتشباك';
      default:
        return vClass;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.compact),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.regular,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _formatVehicleClass(pricing.vehicleClass),
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            pricing.priceDisplay,
            style: TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddonCard extends StatelessWidget {
  const _AddonCard(this.addon);
  final ServiceAddon addon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.compact),
      padding: EdgeInsets.all(AppSpacing.regular),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addon.nameAr,
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
                ),
                if (addon.descriptionAr.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(addon.descriptionAr, style: AppTextStyles.helper),
                ],
              ],
            ),
          ),
          Text(
            '+ ${addon.priceDisplay}',
            style: TextStyle(
              color: AppColors.aqua,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
