import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/booking/domain/entities/booking.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:bariq/features/booking/domain/repositories/booking_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

/// Validates a complete booking draft and submits it to the backend.
final class CreateBooking {
  CreateBooking(this._repository, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final BookingRepository _repository;
  final Uuid _uuid;

  /// Validates draft completeness, generates an idempotency key,
  /// and delegates to the repository.
  ResultFuture<Booking> call(BookingDraft draft) {
    if (!draft.isComplete) {
      return Future.value(
        const Left(
          ValidationFailure(
            code: 'BOOKING_DRAFT_INCOMPLETE',
            message: 'أكمل كل خطوات الحجز قبل الإرسال.',
          ),
        ),
      );
    }

    final idempotencyKey = _uuid.v4();
    return _repository.createBooking(
      draft: draft,
      idempotencyKey: idempotencyKey,
    );
  }
}
