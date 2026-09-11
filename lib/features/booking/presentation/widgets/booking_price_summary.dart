import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Price breakdown summary for the booking review step.
class BookingPriceSummary extends StatelessWidget {
  const BookingPriceSummary({super.key, required this.draft});

  final BookingDraft draft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.regular),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('تفاصيل السعر', style: AppTextStyles.sectionTitle),
          SizedBox(height: AppSpacing.compact),
          // Service base price.
          if (draft.pricing != null)
            _PriceRow(
              label: draft.service?.nameAr ?? '',
              amount: draft.pricing!.priceMinor,
            ),
          // Add-ons.
          ...draft.addons.map(
            (addon) => _PriceRow(
              label: addon.nameAr,
              amount: addon.priceMinor,
            ),
          ),
          Divider(height: AppSpacing.section, color: AppColors.border),
          _PriceRow(
            label: 'الإجمالي',
            amount: draft.totalMinor,
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.amount,
    this.isBold = false,
  });

  final String label;
  final int amount;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final style = isBold
        ? AppTextStyles.sectionTitle
        : AppTextStyles.body;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('${amount ~/ 100} ج.م', style: style),
        ],
      ),
    );
  }
}
