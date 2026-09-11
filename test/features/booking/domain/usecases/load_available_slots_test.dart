import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/booking/domain/repositories/booking_repository.dart';
import 'package:bariq/features/booking/domain/usecases/load_available_slots.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/booking_test_data.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  late MockBookingRepository repository;
  late LoadAvailableSlots useCase;

  setUp(() {
    repository = MockBookingRepository();
    useCase = LoadAvailableSlots(repository);
  });

  test('delegates loading slots to repository with zone and date', () async {
    final slots = [testTimeSlot()];
    final date = DateTime.utc(2026, 9, 8);
    when(
      () => repository.loadAvailableSlots(zoneId: 'zone-1', date: date),
    ).thenAnswer((_) async => Right(slots));

    final result = await useCase(zoneId: 'zone-1', date: date);

    expect(result.isRight(), isTrue);
    expect(result.getRight().toNullable(), equals(slots));
    verify(
      () => repository.loadAvailableSlots(zoneId: 'zone-1', date: date),
    ).called(1);
  });

  test('returns failure when repository fails', () async {
    const failure = NetworkFailure();
    final date = DateTime.utc(2026, 9, 8);
    when(
      () => repository.loadAvailableSlots(zoneId: 'zone-1', date: date),
    ).thenAnswer((_) async => const Left(failure));

    final result = await useCase(zoneId: 'zone-1', date: date);

    expect(result.isLeft(), isTrue);
    result.match(
      (f) => expect(f, equals(failure)),
      (_) => fail('Expected Left'),
    );
  });
}
