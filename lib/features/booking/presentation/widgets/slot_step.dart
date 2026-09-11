import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/booking/domain/entities/time_slot.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlotStep extends StatefulWidget {
  const SlotStep({super.key});

  @override
  State<SlotStep> createState() => _SlotStepState();
}

class _SlotStepState extends State<SlotStep> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingBloc>().add(
        BookingEvent.slotsRequested(_selectedDate),
      );
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() => _selectedDate = date);
    context.read<BookingBloc>().add(BookingEvent.slotsRequested(date));
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dates = List.generate(7, (i) {
      final d = now.add(Duration(days: i));
      return DateTime(d.year, d.month, d.day);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
          child: Text(AppStrings.selectDate, style: AppTextStyles.sectionTitle),
        ),
        SizedBox(height: AppSpacing.compact),
        SizedBox(
          height: 72.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.pageHorizontal,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            separatorBuilder: (_, _) => SizedBox(width: AppSpacing.compact),
            itemBuilder: (context, index) {
              final date = dates[index];
              final isSelected =
                  date.year == _selectedDate.year &&
                  date.month == _selectedDate.month &&
                  date.day == _selectedDate.day;

              String dayLabel;
              if (index == 0) {
                dayLabel = AppStrings.today;
              } else if (index == 1) {
                dayLabel = AppStrings.tomorrow;
              } else {
                const dayNames = [
                  'الإثنين',
                  'الثلاثاء',
                  'الأربعاء',
                  'الخميس',
                  'الجمعة',
                  'السبت',
                  'الأحد',
                ];
                dayLabel = dayNames[date.weekday - 1];
              }

              return InkWell(
                onTap: () => _onDateSelected(date),
                borderRadius: BorderRadius.circular(AppRadius.medium),
                child: Container(
                  width: 68.w,
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.aqua : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    border: Border.all(
                      color: isSelected ? AppColors.aqua : AppColors.border,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayLabel,
                        style: AppTextStyles.helper.copyWith(
                          color: isSelected
                              ? AppColors.surface
                              : AppColors.textMuted,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${date.day}/${date.month}',
                        style: AppTextStyles.sectionTitle.copyWith(
                          color: isSelected
                              ? AppColors.surface
                              : AppColors.navy,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: AppSpacing.section),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
          child: Text(
            AppStrings.selectSlotStep,
            style: AppTextStyles.sectionTitle,
          ),
        ),
        SizedBox(height: AppSpacing.compact),
        Expanded(
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              return state.maybeWhen(
                loadingSlots: (_) =>
                    const Center(child: CircularProgressIndicator()),
                slotsReady: (draft, slots) =>
                    _SlotsGrid(slots: slots, selectedSlot: draft.slot),
                drafting: (draft, _) =>
                    _SlotsGrid(slots: const [], selectedSlot: draft.slot),
                failure: (_, failure) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        failure.message,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                      SizedBox(height: AppSpacing.regular),
                      OutlinedButton(
                        onPressed: () => _onDateSelected(_selectedDate),
                        child: const Text(AppStrings.retry),
                      ),
                    ],
                  ),
                ),
                orElse: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SlotsGrid extends StatelessWidget {
  const _SlotsGrid({required this.slots, this.selectedSlot});

  final List<TimeSlot> slots;
  final TimeSlot? selectedSlot;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.regular),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.access_time_outlined,
                size: 48.w,
                color: AppColors.textMuted,
              ),
              SizedBox(height: AppSpacing.regular),
              Text(
                AppStrings.noSlotsAvailable,
                style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.pageHorizontal,
        vertical: AppSpacing.regular,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 2.4,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final isSelected =
            selectedSlot?.start == slot.start && selectedSlot?.end == slot.end;
        final isAvailable = slot.available;

        return InkWell(
          onTap: isAvailable
              ? () => context.read<BookingBloc>().add(
                  BookingEvent.slotSelected(slot),
                )
              : null,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.aqua
                  : (isAvailable ? AppColors.surface : AppColors.navySurface),
              borderRadius: BorderRadius.circular(AppRadius.medium),
              border: Border.all(
                color: isSelected
                    ? AppColors.aqua
                    : (isAvailable ? AppColors.border : AppColors.border),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  size: 18.w,
                  color: isSelected
                      ? AppColors.surface
                      : (isAvailable ? AppColors.aqua : AppColors.textMuted),
                ),
                SizedBox(width: 6.w),
                Text(
                  slot.displayRange,
                  style: AppTextStyles.body.copyWith(
                    color: isSelected
                        ? AppColors.surface
                        : (isAvailable ? AppColors.navy : AppColors.textMuted),
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
