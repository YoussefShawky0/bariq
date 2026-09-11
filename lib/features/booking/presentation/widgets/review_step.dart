import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewStep extends StatelessWidget {
  const ReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        state.whenOrNull(
          failure: (_, failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: AppColors.error,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        final draft = state.maybeWhen(
          drafting: (draft, _) => draft,
          loadingSlots: (draft) => draft,
          slotsReady: (draft, _) => draft,
          submitting: (draft) => draft,
          failure: (draft, _) => draft,
          orElse: () => null,
        );

        if (draft == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final isSubmitting = state is BookingSubmitting;

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.pageHorizontal,
                  vertical: AppSpacing.regular,
                ),
                children: [
                  Text(
                    AppStrings.bookingSummary,
                    style: AppTextStyles.sectionTitle,
                  ),
                  SizedBox(height: AppSpacing.regular),

                  // Vehicle row
                  if (draft.vehicle != null)
                    _SummaryCard(
                      icon: Icons.directions_car,
                      title: AppStrings.vehicle,
                      content:
                          '${draft.vehicle!.make} ${draft.vehicle!.model} (${draft.vehicle!.plateNumber})',
                      onEdit: () => context
                          .read<BookingBloc>()
                          .add(const BookingEvent.stepChanged(BookingStep.vehicle)),
                    ),

                  // Service row
                  if (draft.service != null)
                    _SummaryCard(
                      icon: Icons.local_car_wash,
                      title: AppStrings.service,
                      content:
                          '${draft.service!.nameAr} • ${draft.pricing?.priceDisplay ?? ''}',
                      onEdit: () => context
                          .read<BookingBloc>()
                          .add(const BookingEvent.stepChanged(BookingStep.service)),
                    ),

                  // Addons row
                  if (draft.addons.isNotEmpty)
                    _SummaryCard(
                      icon: Icons.add_circle_outline,
                      title: AppStrings.addons,
                      content: draft.addons
                          .map((a) => '${a.nameAr} (${a.priceDisplay})')
                          .join('\n'),
                      onEdit: () => context
                          .read<BookingBloc>()
                          .add(const BookingEvent.stepChanged(BookingStep.service)),
                    ),

                  // Address row
                  if (draft.address != null)
                    _SummaryCard(
                      icon: Icons.location_on,
                      title: AppStrings.address,
                      content:
                          '${draft.address!.label} • ${draft.address!.zoneName}\n${draft.address!.street}',
                      onEdit: () => context
                          .read<BookingBloc>()
                          .add(const BookingEvent.stepChanged(BookingStep.address)),
                    ),

                  // Slot row
                  if (draft.slot != null)
                    _SummaryCard(
                      icon: Icons.access_time,
                      title: AppStrings.time,
                      content:
                          '${draft.slot!.start.day}/${draft.slot!.start.month}/${draft.slot!.start.year} • ${draft.slot!.displayRange}',
                      onEdit: () => context
                          .read<BookingBloc>()
                          .add(const BookingEvent.stepChanged(BookingStep.slot)),
                    ),

                  // Payment method row
                  _SummaryCard(
                    icon: Icons.payments,
                    title: AppStrings.payment,
                    content: AppStrings.cashOnDelivery,
                    onEdit: () => context
                        .read<BookingBloc>()
                        .add(const BookingEvent.stepChanged(BookingStep.payment)),
                  ),

                  SizedBox(height: AppSpacing.compact),

                  // Total calculation
                  Container(
                    padding: EdgeInsets.all(AppSpacing.regular),
                    decoration: BoxDecoration(
                      color: AppColors.navySurface,
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.totalPrice,
                          style: AppTextStyles.sectionTitle,
                        ),
                        Text(
                          draft.totalDisplay,
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.aqua,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Confirm button
            Container(
              padding: EdgeInsets.all(AppSpacing.regular),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.scrim,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.aqua,
                    foregroundColor: AppColors.surface,
                  ),
                  onPressed: isSubmitting || !draft.isComplete
                      ? null
                      : () => context
                          .read<BookingBloc>()
                          .add(const BookingEvent.submitted()),
                  child: isSubmitting
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.surface,
                          ),
                        )
                      : Text(AppStrings.confirmBooking, style: AppTextStyles.button),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.onEdit,
  });

  final IconData icon;
  final String title;
  final String content;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.compact),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.regular),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.aqua, size: 22.w),
            SizedBox(width: AppSpacing.compact),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.helper.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    content,
                    style: AppTextStyles.body,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 18.w, color: AppColors.textMuted),
              onPressed: onEdit,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}
