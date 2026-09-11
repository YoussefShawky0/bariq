import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/booking/domain/entities/booking.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:bariq/features/booking/domain/entities/payment_method.dart';
import 'package:bariq/features/booking/domain/entities/time_slot.dart';
import 'package:bariq/features/booking/domain/usecases/create_booking.dart';
import 'package:bariq/features/booking/domain/usecases/load_available_slots.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_addon.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_pricing.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_bloc.freezed.dart';

/// Wizard step indices.
abstract final class BookingStep {
  static const int vehicle = 0;
  static const int service = 1;
  static const int address = 2;
  static const int slot = 3;
  static const int payment = 4;
  static const int review = 5;
  static const int totalSteps = 6;
}

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc(this._loadAvailableSlots, this._createBooking)
    : super(const BookingState.initial()) {
    on<BookingStarted>(_onStarted);
    on<BookingVehicleSelected>(_onVehicleSelected);
    on<BookingServiceSelected>(_onServiceSelected);
    on<BookingAddressSelected>(_onAddressSelected);
    on<BookingSlotsRequested>(_onSlotsRequested);
    on<BookingSlotSelected>(_onSlotSelected);
    on<BookingPaymentSelected>(_onPaymentSelected);
    on<BookingStepChanged>(_onStepChanged);
    on<BookingSubmitted>(_onSubmitted);
  }

  final LoadAvailableSlots _loadAvailableSlots;
  final CreateBooking _createBooking;

  void _onStarted(BookingStarted event, Emitter<BookingState> emit) {
    emit(const BookingState.drafting(BookingDraft(), BookingStep.vehicle));
  }

  void _onVehicleSelected(
    BookingVehicleSelected event,
    Emitter<BookingState> emit,
  ) {
    final draft = _currentDraft;
    if (draft == null) return;
    emit(
      BookingState.drafting(
        draft.copyWith(vehicle: event.vehicle),
        BookingStep.service,
      ),
    );
  }

  void _onServiceSelected(
    BookingServiceSelected event,
    Emitter<BookingState> emit,
  ) {
    final draft = _currentDraft;
    if (draft == null) return;
    emit(
      BookingState.drafting(
        draft.copyWith(
          service: event.service,
          addons: event.addons,
          pricing: event.pricing,
        ),
        BookingStep.address,
      ),
    );
  }

  void _onAddressSelected(
    BookingAddressSelected event,
    Emitter<BookingState> emit,
  ) {
    final draft = _currentDraft;
    if (draft == null) return;
    emit(
      BookingState.drafting(
        draft.copyWith(address: event.address),
        BookingStep.slot,
      ),
    );
  }

  Future<void> _onSlotsRequested(
    BookingSlotsRequested event,
    Emitter<BookingState> emit,
  ) async {
    final draft = _currentDraft;
    if (draft == null || draft.address == null) return;

    emit(BookingState.loadingSlots(draft));

    final result = await _loadAvailableSlots(
      zoneId: draft.address!.zoneId,
      date: event.date,
    );

    result.match(
      (failure) => emit(BookingState.failure(draft, failure)),
      (slots) => emit(BookingState.slotsReady(draft, slots)),
    );
  }

  void _onSlotSelected(BookingSlotSelected event, Emitter<BookingState> emit) {
    final draft = _currentDraft;
    if (draft == null) return;
    emit(
      BookingState.drafting(
        draft.copyWith(slot: event.slot),
        BookingStep.payment,
      ),
    );
  }

  void _onPaymentSelected(
    BookingPaymentSelected event,
    Emitter<BookingState> emit,
  ) {
    final draft = _currentDraft;
    if (draft == null) return;
    emit(
      BookingState.drafting(
        draft.copyWith(paymentMethod: event.method),
        BookingStep.review,
      ),
    );
  }

  void _onStepChanged(BookingStepChanged event, Emitter<BookingState> emit) {
    final draft = _currentDraft;
    if (draft == null) return;
    emit(BookingState.drafting(draft, event.step));
  }

  Future<void> _onSubmitted(
    BookingSubmitted event,
    Emitter<BookingState> emit,
  ) async {
    final draft = _currentDraft;
    if (draft == null || state is BookingSubmitting) return;

    emit(BookingState.submitting(draft));

    final result = await _createBooking(draft);
    result.match(
      (failure) => emit(BookingState.failure(draft, failure)),
      (booking) => emit(BookingState.success(booking)),
    );
  }

  BookingDraft? get _currentDraft => state.maybeWhen(
    drafting: (draft, _) => draft,
    loadingSlots: (draft) => draft,
    slotsReady: (draft, _) => draft,
    submitting: (draft) => draft,
    failure: (draft, _) => draft,
    orElse: () => null,
  );
}

@freezed
sealed class BookingEvent with _$BookingEvent {
  const factory BookingEvent.started() = BookingStarted;

  const factory BookingEvent.vehicleSelected(Vehicle vehicle) =
      BookingVehicleSelected;

  const factory BookingEvent.serviceSelected(
    Service service,
    List<ServiceAddon> addons,
    ServicePricing pricing,
  ) = BookingServiceSelected;

  const factory BookingEvent.addressSelected(Address address) =
      BookingAddressSelected;

  const factory BookingEvent.slotsRequested(DateTime date) =
      BookingSlotsRequested;

  const factory BookingEvent.slotSelected(TimeSlot slot) = BookingSlotSelected;

  const factory BookingEvent.paymentSelected(PaymentMethod method) =
      BookingPaymentSelected;

  const factory BookingEvent.stepChanged(int step) = BookingStepChanged;

  const factory BookingEvent.submitted() = BookingSubmitted;
}

@freezed
sealed class BookingState with _$BookingState {
  const factory BookingState.initial() = BookingInitial;

  const factory BookingState.drafting(BookingDraft draft, int step) =
      BookingDrafting;

  const factory BookingState.loadingSlots(BookingDraft draft) =
      BookingLoadingSlots;

  const factory BookingState.slotsReady(
    BookingDraft draft,
    List<TimeSlot> slots,
  ) = BookingSlotsReady;

  const factory BookingState.submitting(BookingDraft draft) = BookingSubmitting;

  const factory BookingState.success(Booking booking) = BookingSuccess;

  const factory BookingState.failure(BookingDraft draft, Failure failure) =
      BookingFailure;
}
