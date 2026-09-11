import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:bariq/features/booking/presentation/widgets/address_step.dart';
import 'package:bariq/features/booking/presentation/widgets/booking_success_view.dart';
import 'package:bariq/features/booking/presentation/widgets/payment_step.dart';
import 'package:bariq/features/booking/presentation/widgets/review_step.dart';
import 'package:bariq/features/booking/presentation/widgets/service_step.dart';
import 'package:bariq/features/booking/presentation/widgets/slot_step.dart';
import 'package:bariq/features/booking/presentation/widgets/step_indicator.dart';
import 'package:bariq/features/booking/presentation/widgets/vehicle_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Main page hosting the 6-step customer booking wizard.
class BookingWizardPage extends StatelessWidget {
  const BookingWizardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        return state.maybeWhen(
          success: (booking) => Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(child: BookingSuccessView(booking: booking)),
          ),
          orElse: () {
            final currentStep = state.maybeWhen(
              drafting: (_, step) => step,
              orElse: () => BookingStep.vehicle,
            );

            return Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: AppColors.surface,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.navy),
                  onPressed: () {
                    if (currentStep > BookingStep.vehicle) {
                      context.read<BookingBloc>().add(
                        BookingEvent.stepChanged(currentStep - 1),
                      );
                    } else {
                      context.pop();
                    }
                  },
                ),
                title: Text(
                  _stepTitle(currentStep),
                  style: AppTextStyles.title,
                ),
                centerTitle: true,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    StepIndicator(currentStep: currentStep),
                    SizedBox(height: AppSpacing.compact),
                    Expanded(child: _buildCurrentStep(currentStep)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _stepTitle(int step) {
    return switch (step) {
      BookingStep.vehicle => AppStrings.selectVehicleStep,
      BookingStep.service => AppStrings.selectServiceStep,
      BookingStep.address => AppStrings.selectAddressStep,
      BookingStep.slot => AppStrings.selectSlotStep,
      BookingStep.payment => AppStrings.selectPaymentStep,
      BookingStep.review => AppStrings.reviewBookingStep,
      _ => AppStrings.bookingTitle,
    };
  }

  Widget _buildCurrentStep(int step) {
    return switch (step) {
      BookingStep.vehicle => const VehicleStep(),
      BookingStep.service => const ServiceStep(),
      BookingStep.address => const AddressStep(),
      BookingStep.slot => const SlotStep(),
      BookingStep.payment => const PaymentStep(),
      BookingStep.review => const ReviewStep(),
      _ => const VehicleStep(),
    };
  }
}
