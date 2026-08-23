import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Service card for the home screen list (Figma style).
class HomeServiceCard extends StatelessWidget {
  const HomeServiceCard({
    required this.service,
    required this.onTap,
    super.key,
  });

  final Service service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.profileCardHorizontal,
          vertical: 16.h,
        ),
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
                    service.nameAr,
                    style: AppTextStyles.vehicleName,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    service.descriptionAr.isNotEmpty
                        ? service.descriptionAr
                        : '${service.baseDurationMinutes} دقيقة',
                    style: AppTextStyles.helper,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (service.startingPriceMinor != null)
              Text(
                service.startingPriceDisplay,
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
