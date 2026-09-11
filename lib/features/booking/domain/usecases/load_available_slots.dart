import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/booking/domain/entities/time_slot.dart';
import 'package:bariq/features/booking/domain/repositories/booking_repository.dart';

/// Loads available time slots for a zone and date.
final class LoadAvailableSlots {
  LoadAvailableSlots(this._repository);

  final BookingRepository _repository;

  /// Returns slots with availability flags.
  ResultFuture<List<TimeSlot>> call({
    required String zoneId,
    required DateTime date,
  }) => _repository.loadAvailableSlots(zoneId: zoneId, date: date);
}
