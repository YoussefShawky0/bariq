import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:bariq/features/booking/domain/repositories/booking_repository.dart';
import 'package:bariq/features/booking/domain/usecases/create_booking.dart';
import 'package:bariq/features/booking/domain/usecases/load_available_slots.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/booking_test_data.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  late MockBookingRepository repository;

  setUpAll(() {
    registerFallbackValue(testBookingDraft());
    registerFallbackValue(DateTime.now());
  });

  setUp(() {
    repository = MockBookingRepository();
  });

  BookingBloc buildBloc() =>
      BookingBloc(LoadAvailableSlots(repository), CreateBooking(repository));

  blocTest<BookingBloc, BookingState>(
    'emits drafting initial step on started',
    build: buildBloc,
    act: (bloc) => bloc.add(const BookingEvent.started()),
    expect: () => [
      const BookingState.drafting(BookingDraft(), BookingStep.vehicle),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'advances to service step when vehicle is selected',
    build: buildBloc,
    seed: () =>
        const BookingState.drafting(BookingDraft(), BookingStep.vehicle),
    act: (bloc) => bloc.add(BookingEvent.vehicleSelected(testVehicle())),
    expect: () => [
      BookingState.drafting(
        const BookingDraft().copyWith(vehicle: testVehicle()),
        BookingStep.service,
      ),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'advances to address step when service is selected',
    build: buildBloc,
    seed: () => BookingState.drafting(
      const BookingDraft().copyWith(vehicle: testVehicle()),
      BookingStep.service,
    ),
    act: (bloc) => bloc.add(
      BookingEvent.serviceSelected(testService(), [testAddon()], testPricing()),
    ),
    expect: () => [
      BookingState.drafting(
        const BookingDraft().copyWith(
          vehicle: testVehicle(),
          service: testService(),
          addons: [testAddon()],
          pricing: testPricing(),
        ),
        BookingStep.address,
      ),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'advances to slot step when address is selected',
    build: buildBloc,
    seed: () => BookingState.drafting(
      const BookingDraft().copyWith(
        vehicle: testVehicle(),
        service: testService(),
        pricing: testPricing(),
      ),
      BookingStep.address,
    ),
    act: (bloc) => bloc.add(BookingEvent.addressSelected(testAddress())),
    expect: () => [
      BookingState.drafting(
        const BookingDraft().copyWith(
          vehicle: testVehicle(),
          service: testService(),
          pricing: testPricing(),
          address: testAddress(),
        ),
        BookingStep.slot,
      ),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'loads slots for zone on slotsRequested',
    build: () {
      when(
        () => repository.loadAvailableSlots(
          zoneId: any(named: 'zoneId'),
          date: any(named: 'date'),
        ),
      ).thenAnswer((_) async => Right([testTimeSlot()]));
      return buildBloc();
    },
    seed: () => BookingState.drafting(
      const BookingDraft().copyWith(address: testAddress()),
      BookingStep.slot,
    ),
    act: (bloc) =>
        bloc.add(BookingEvent.slotsRequested(DateTime.utc(2026, 9, 8))),
    expect: () => [
      BookingState.loadingSlots(
        const BookingDraft().copyWith(address: testAddress()),
      ),
      BookingState.slotsReady(
        const BookingDraft().copyWith(address: testAddress()),
        [testTimeSlot()],
      ),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'submits complete draft and emits success on repository success',
    build: () {
      when(
        () => repository.createBooking(
          draft: any(named: 'draft'),
          idempotencyKey: any(named: 'idempotencyKey'),
        ),
      ).thenAnswer((_) async => Right(testBooking()));
      return buildBloc();
    },
    seed: () => BookingState.drafting(testBookingDraft(), BookingStep.review),
    act: (bloc) => bloc.add(const BookingEvent.submitted()),
    expect: () => [
      BookingState.submitting(testBookingDraft()),
      BookingState.success(testBooking()),
    ],
  );

  blocTest<BookingBloc, BookingState>(
    'emits failure on submission failure',
    build: () {
      when(
        () => repository.createBooking(
          draft: any(named: 'draft'),
          idempotencyKey: any(named: 'idempotencyKey'),
        ),
      ).thenAnswer((_) async => const Left(BackendFailure()));
      return buildBloc();
    },
    seed: () => BookingState.drafting(testBookingDraft(), BookingStep.review),
    act: (bloc) => bloc.add(const BookingEvent.submitted()),
    expect: () => [
      BookingState.submitting(testBookingDraft()),
      BookingState.failure(testBookingDraft(), const BackendFailure()),
    ],
  );
}
