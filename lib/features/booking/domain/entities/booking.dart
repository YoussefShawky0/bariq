import 'package:bariq/features/booking/domain/entities/booking_item.dart';
import 'package:bariq/features/booking/domain/entities/booking_status.dart';
import 'package:bariq/features/booking/domain/entities/payment_method.dart';

/// A server-confirmed booking returned after successful creation.
final class Booking {
  const Booking({
    required this.id,
    required this.status,
    required this.slotStart,
    required this.slotEnd,
    required this.totalMinor,
    required this.currency,
    required this.paymentMethod,
    required this.items,
    required this.createdAt,
  });

  final String id;
  final BookingStatus status;
  final DateTime slotStart;
  final DateTime slotEnd;

  /// Total price in minor currency units (e.g. piasters).
  final int totalMinor;
  final String currency;
  final PaymentMethod paymentMethod;
  final List<BookingItem> items;
  final DateTime createdAt;

  /// Display price in EGP.
  String get totalDisplay => '${totalMinor ~/ 100} ج.م';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Booking && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
