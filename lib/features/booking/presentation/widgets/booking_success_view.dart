import 'package:bariq/core/config/app_router.dart';
import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/booking/domain/entities/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BookingSuccessView extends StatelessWidget {
  const BookingSuccessView({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.pageHorizontal,
          vertical: AppSpacing.regular,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                color: AppColors.successSurface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 56.w,
              ),
            ),
            SizedBox(height: AppSpacing.section),
            Text(
              AppStrings.bookingConfirmed,
              style: AppTextStyles.title,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.compact),
            Text(
              '${AppStrings.bookingCode}: ${booking.id.substring(0, 8).toUpperCase()}',
              style: AppTextStyles.helper,
            ),
            SizedBox(height: AppSpacing.regular),
            Container(
              padding: EdgeInsets.all(AppSpacing.regular),
              decoration: BoxDecoration(
                color: AppColors.navySurface,
                borderRadius: BorderRadius.circular(AppRadius.medium),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.totalPrice, style: AppTextStyles.body),
                      Text(
                        '${booking.totalMinor ~/ 100} ج.م',
                        style: AppTextStyles.sectionTitle.copyWith(
                          color: AppColors.aqua,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.tiny),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.payment, style: AppTextStyles.body),
                      Text(
                        AppStrings.cashOnDelivery,
                        style: AppTextStyles.helper,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.spacious),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.aqua,
                  foregroundColor: AppColors.surface,
                ),
                onPressed: () => context.go(AppRoutes.home),
                child: Text(AppStrings.goToHome, style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
