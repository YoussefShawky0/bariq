import 'package:bariq/core/config/app_router.dart';
import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VehicleStep extends StatelessWidget {
  const VehicleStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehiclesBloc, VehiclesState>(
      builder: (context, vehiclesState) {
        return vehiclesState.maybeWhen(
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
                  onPressed: () => context.read<VehiclesBloc>().add(
                    const VehiclesEvent.started(),
                  ),
                  child: const Text(AppStrings.retry),
                ),
              ],
            ),
          ),
          ready: (vehicles) => _VehicleList(vehicles: vehicles),
          saving: (vehicles) => _VehicleList(vehicles: vehicles),
          deleting: (vehicles, _) => _VehicleList(vehicles: vehicles),
          success: (vehicles, _) => _VehicleList(vehicles: vehicles),
          failure: (vehicles, _, _) => _VehicleList(vehicles: vehicles),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class _VehicleList extends StatelessWidget {
  const _VehicleList({required this.vehicles});

  final List<Vehicle> vehicles;

  @override
  Widget build(BuildContext context) {
    if (vehicles.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.regular),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.directions_car_outlined,
                size: 64.w,
                color: AppColors.textMuted,
              ),
              SizedBox(height: AppSpacing.regular),
              Text(
                AppStrings.noVehiclesForBooking,
                style: AppTextStyles.sectionTitle,
              ),
              SizedBox(height: AppSpacing.section),
              ElevatedButton.icon(
                onPressed: () => context.push(AppRoutes.vehicleAdd),
                icon: const Icon(Icons.add),
                label: const Text(AppStrings.addNewVehicle),
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, bookingState) {
        final selectedVehicle = bookingState.maybeWhen(
          drafting: (draft, _) => draft.vehicle,
          loadingSlots: (draft) => draft.vehicle,
          slotsReady: (draft, _) => draft.vehicle,
          submitting: (draft) => draft.vehicle,
          failure: (draft, _) => draft.vehicle,
          orElse: () => null,
        );

        return ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.pageHorizontal,
            vertical: AppSpacing.regular,
          ),
          itemCount: vehicles.length,
          separatorBuilder: (_, _) => SizedBox(height: AppSpacing.compact),
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            final isSelected = selectedVehicle?.id == vehicle.id;

            return InkWell(
              onTap: () {
                context.read<BookingBloc>().add(
                  BookingEvent.vehicleSelected(vehicle),
                );
              },
              borderRadius: BorderRadius.circular(AppRadius.medium),
              child: Container(
                padding: EdgeInsets.all(AppSpacing.regular),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.aquaSurface : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  border: Border.all(
                    color: isSelected ? AppColors.aqua : AppColors.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
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
                        Icons.directions_car,
                        color: isSelected ? AppColors.surface : AppColors.navy,
                        size: 24.w,
                      ),
                    ),
                    SizedBox(width: AppSpacing.regular),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${vehicle.make} ${vehicle.model} ${vehicle.year}',
                            style: AppTextStyles.sectionTitle,
                          ),
                          SizedBox(height: AppSpacing.tiny),
                          Text(
                            '${vehicle.plateNumber} • ${vehicle.vehicleClass.arabicLabel}',
                            style: AppTextStyles.helper,
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.aqua,
                        size: 24.w,
                      )
                    else
                      Icon(
                        Icons.circle_outlined,
                        color: AppColors.dotInactive,
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
