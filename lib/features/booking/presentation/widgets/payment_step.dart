import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/booking/domain/entities/payment_method.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentStep extends StatelessWidget {
  const PaymentStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final selectedMethod = state.maybeWhen(
          drafting: (draft, _) => draft.paymentMethod,
          loadingSlots: (draft) => draft.paymentMethod,
          slotsReady: (draft, _) => draft.paymentMethod,
          submitting: (draft) => draft.paymentMethod,
          failure: (draft, _) => draft.paymentMethod,
          orElse: () => PaymentMethod.cash,
        );

        return ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.pageHorizontal,
            vertical: AppSpacing.regular,
          ),
          children: [
            Text(
              AppStrings.selectPaymentStep,
              style: AppTextStyles.sectionTitle,
            ),
            SizedBox(height: AppSpacing.regular),

            // Cash option
            InkWell(
              onTap: () {
                context.read<BookingBloc>().add(
                  const BookingEvent.paymentSelected(PaymentMethod.cash),
                );
              },
              borderRadius: BorderRadius.circular(AppRadius.medium),
              child: Container(
                padding: EdgeInsets.all(AppSpacing.regular),
                decoration: BoxDecoration(
                  color: selectedMethod == PaymentMethod.cash
                      ? AppColors.aquaSurface
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  border: Border.all(
                    color: selectedMethod == PaymentMethod.cash
                        ? AppColors.aqua
                        : AppColors.border,
                    width: selectedMethod == PaymentMethod.cash ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: selectedMethod == PaymentMethod.cash
                            ? AppColors.aqua
                            : AppColors.navySurface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.payments_outlined,
                        color: selectedMethod == PaymentMethod.cash
                            ? AppColors.surface
                            : AppColors.navy,
                        size: 24.w,
                      ),
                    ),
                    SizedBox(width: AppSpacing.regular),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.cashOnDelivery,
                            style: AppTextStyles.sectionTitle,
                          ),
                          SizedBox(height: AppSpacing.tiny),
                          Text(
                            AppStrings.cashDescription,
                            style: AppTextStyles.helper,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      selectedMethod == PaymentMethod.cash
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selectedMethod == PaymentMethod.cash
                          ? AppColors.aqua
                          : AppColors.dotInactive,
                      size: 24.w,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.regular),

            // Online payment disabled (Phase 4)
            Container(
              padding: EdgeInsets.all(AppSpacing.regular),
              decoration: BoxDecoration(
                color: AppColors.navySurface,
                borderRadius: BorderRadius.circular(AppRadius.medium),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.credit_card_outlined,
                      color: AppColors.textMuted,
                      size: 24.w,
                    ),
                  ),
                  SizedBox(width: AppSpacing.regular),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.cardPaymentSoon,
                          style: AppTextStyles.sectionTitle.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        SizedBox(height: AppSpacing.tiny),
                        Text(
                          AppStrings.cardPaymentUnavailable,
                          style: AppTextStyles.helper,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      AppStrings.cardPaymentUnavailable,
                      style: AppTextStyles.helper.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
