import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:bariq/features/booking/data/models/booking_model.dart';
import 'package:bariq/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:bariq/features/booking/domain/entities/booking_status.dart';
import 'package:bariq/features/booking/domain/entities/payment_method.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/booking_test_data.dart';

class MockBookingRemoteDataSource extends Mock implements BookingRemoteDataSource {}
class MockAppLogger extends Mock implements AppLogger {}

void main() {
  late MockBookingRemoteDataSource remoteDataSource;
  late MockAppLogger logger;
  late BookingRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(testBookingDraft());
  });

  setUp(() {
    remoteDataSource = MockBookingRemoteDataSource();
    logger = MockAppLogger();
    repository = BookingRepositoryImpl(remoteDataSource, logger);
  });

  test('loadAvailableSlots maps models to entities', () async {
    final date = DateTime.utc(2026, 9, 8);
    final model = TimeSlotModel(
      start: DateTime.utc(2026, 9, 8, 10, 0),
      end: DateTime.utc(2026, 9, 8, 12, 0),
      available: true,
    );
    when(() => remoteDataSource.loadAvailableSlots('zone-1', date))
        .thenAnswer((_) async => [model]);

    final result = await repository.loadAvailableSlots(zoneId: 'zone-1', date: date);

    expect(result.isRight(), isTrue);
    final slots = result.getRight().toNullable()!;
    expect(slots.length, 1);
    expect(slots.first.start, model.start);
    expect(slots.first.available, isTrue);
  });

  test('createBooking maps model to entity on success', () async {
    final draft = testBookingDraft();
    final model = BookingModel(
      id: 'bk-123',
      status: BookingStatus.confirmed,
      slotStart: DateTime.utc(2026, 9, 8, 10, 0),
      slotEnd: DateTime.utc(2026, 9, 8, 12, 0),
      totalMinor: 18000,
      currency: 'EGP',
      paymentMethod: PaymentMethod.cash,
      items: const [],
      createdAt: DateTime.utc(2026, 9, 8, 9, 0),
    );
    when(() => remoteDataSource.createBooking(draft, 'key-123'))
        .thenAnswer((_) async => model);

    final result = await repository.createBooking(
      draft: draft,
      idempotencyKey: 'key-123',
    );

    expect(result.isRight(), isTrue);
    final booking = result.getRight().toNullable()!;
    expect(booking.id, 'bk-123');
    expect(booking.status, BookingStatus.confirmed);
  });

  test('maps BackendConfigurationException to BackendConfigurationFailure', () async {
    final draft = testBookingDraft();
    when(() => remoteDataSource.createBooking(draft, any()))
        .thenThrow(const BackendConfigurationException());

    final result = await repository.createBooking(
      draft: draft,
      idempotencyKey: 'key-123',
    );

    expect(result.isLeft(), isTrue);
    result.match(
      (failure) => expect(failure, isA<BackendConfigurationFailure>()),
      (_) => fail('Expected failure'),
    );
  });
}
