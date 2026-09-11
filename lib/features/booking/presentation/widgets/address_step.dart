import 'package:bariq/core/config/app_router.dart';
import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/presentation/bloc/addresses_bloc.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddressStep extends StatelessWidget {
  const AddressStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressesBloc, AddressesState>(
      builder: (context, addressesState) {
        return addressesState.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator()),
          loadFailure: (failure) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  failure.message,
                  style: AppTextStyles.body.copyWith(color: AppColors.error),
                ),
                SizedBox(height: AppSpacing.regular),
                OutlinedButton(
                  onPressed: () => context
                      .read<AddressesBloc>()
                      .add(const AddressesEvent.started()),
                  child: const Text(AppStrings.retry),
                ),
              ],
            ),
          ),
          ready: (addresses) => _AddressList(addresses: addresses),
          saving: (addresses) => _AddressList(addresses: addresses),
          deleting: (addresses, _) => _AddressList(addresses: addresses),
          success: (addresses, _) => _AddressList(addresses: addresses),
          failure: (addresses, _, _) => _AddressList(addresses: addresses),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class _AddressList extends StatelessWidget {
  const _AddressList({required this.addresses});

  final List<Address> addresses;

  @override
  Widget build(BuildContext context) {
    if (addresses.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.regular),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 64.w,
                color: AppColors.textMuted,
              ),
              SizedBox(height: AppSpacing.regular),
              Text(
                AppStrings.noAddressesForBooking,
                style: AppTextStyles.sectionTitle,
              ),
              SizedBox(height: AppSpacing.section),
              ElevatedButton.icon(
                onPressed: () => context.push(AppRoutes.addressAdd),
                icon: const Icon(Icons.add_location_alt_outlined),
                label: const Text(AppStrings.addNewAddress),
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, bookingState) {
        final selectedAddress = bookingState.maybeWhen(
          drafting: (draft, _) => draft.address,
          loadingSlots: (draft) => draft.address,
          slotsReady: (draft, _) => draft.address,
          submitting: (draft) => draft.address,
          failure: (draft, _) => draft.address,
          orElse: () => null,
        );

        return ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.pageHorizontal,
            vertical: AppSpacing.regular,
          ),
          itemCount: addresses.length,
          separatorBuilder: (_, _) => SizedBox(height: AppSpacing.compact),
          itemBuilder: (context, index) {
            final addr = addresses[index];
            final isSelected = selectedAddress?.id == addr.id;

            return InkWell(
              onTap: () {
                final bookingBloc = context.read<BookingBloc>();
                bookingBloc.add(BookingEvent.addressSelected(addr));
                bookingBloc.add(BookingEvent.slotsRequested(DateTime.now()));
              },
              borderRadius: BorderRadius.circular(AppRadius.medium),
              child: Container(
                padding: EdgeInsets.all(AppSpacing.regular),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.aquaSurface
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  border: Border.all(
                    color: isSelected ? AppColors.aqua : AppColors.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.aqua
                            : AppColors.navySurface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: isSelected
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
                          Row(
                            children: [
                              Text(
                                addr.label,
                                style: AppTextStyles.sectionTitle,
                              ),
                              if (addr.isDefault) ...[
                                SizedBox(width: 6.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.aquaSurface,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    AppStrings.defaultAddress,
                                    style: AppTextStyles.helper.copyWith(
                                      color: AppColors.aqua,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: AppSpacing.tiny),
                          Text(
                            '${addr.zoneName} • ${addr.street}',
                            style: AppTextStyles.body,
                          ),
                          if (addr.building != null || addr.floor != null) ...[
                            SizedBox(height: AppSpacing.tiny),
                            Text(
                              [
                                if (addr.building != null) 'مبنى ${addr.building}',
                                if (addr.floor != null) 'دور ${addr.floor}',
                                if (addr.apartment != null) 'شقة ${addr.apartment}',
                              ].join(' • '),
                              style: AppTextStyles.helper,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Icon(
                      isSelected
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: isSelected
                          ? AppColors.aqua
                          : AppColors.dotInactive,
                      size: 24.w,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
