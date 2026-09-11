import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:bariq/features/booking/domain/repositories/booking_repository.dart';
import 'package:bariq/features/booking/domain/usecases/create_booking.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/booking_test_data.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  late MockBookingRepository repository;
  late CreateBooking useCase;

  setUpAll(() {
    registerFallbackValue(testBookingDraft());
  });

  setUp(() {
    repository = MockBookingRepository();
    useCase = CreateBooking(repository);
  });

  test('returns ValidationFailure when draft is incomplete', () async {
    const draft = BookingDraft();
    final result = await useCase(draft);

    expect(result.isLeft(), isTrue);
    result.match((failure) {
      expect(failure, isA<ValidationFailure>());
      expect((failure as ValidationFailure).code, 'BOOKING_DRAFT_INCOMPLETE');
    }, (_) => fail('Expected Left'));
    verifyNever(
      () => repository.createBooking(
        draft: any(named: 'draft'),
        idempotencyKey: any(named: 'idempotencyKey'),
      ),
    );
  });

  test(
    'calls repository with draft and generated idempotency key on complete draft',
    () async {
      final draft = testBookingDraft();
      final booking = testBooking();
      when(
        () => repository.createBooking(
          draft: any(named: 'draft'),
          idempotencyKey: any(named: 'idempotencyKey'),
        ),
      ).thenAnswer((_) async => Right(booking));

      final result = await useCase(draft);

      expect(result.isRight(), isTrue);
      expect(result.getRight().toNullable(), equals(booking));
      verify(
        () => repository.createBooking(
          draft: draft,
          idempotencyKey: any(named: 'idempotencyKey', that: isNotEmpty),
        ),
      ).called(1);
    },
  );

  test('propagates repository failure', () async {
    final draft = testBookingDraft();
    const failure = BackendFailure();
    when(
      () => repository.createBooking(
        draft: any(named: 'draft'),
        idempotencyKey: any(named: 'idempotencyKey'),
      ),
    ).thenAnswer((_) async => const Left(failure));

    final result = await useCase(draft);

    expect(result.isLeft(), isTrue);
    result.match(
      (f) => expect(f, equals(failure)),
      (_) => fail('Expected Left'),
    );
  });
}
