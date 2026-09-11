import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/booking/domain/entities/booking.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:bariq/features/booking/domain/entities/time_slot.dart';

/// Booking persistence boundary.
abstract interface class BookingRepository {
  /// Returns available time slots for a zone on a specific date.
  ResultFuture<List<TimeSlot>> loadAvailableSlots({
    required String zoneId,
    required DateTime date,
  });

  /// Creates a confirmed booking from a complete draft.
  ///
  /// The [idempotencyKey] prevents duplicate submissions.
  ResultFuture<Booking> createBooking({
    required BookingDraft draft,
    required String idempotencyKey,
  });
}
