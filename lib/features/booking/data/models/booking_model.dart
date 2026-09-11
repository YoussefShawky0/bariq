import 'package:bariq/features/booking/domain/entities/booking.dart';
import 'package:bariq/features/booking/domain/entities/booking_item.dart';
import 'package:bariq/features/booking/domain/entities/booking_status.dart';
import 'package:bariq/features/booking/domain/entities/payment_method.dart';
import 'package:bariq/features/booking/domain/entities/time_slot.dart';

/// JSON ↔ [Booking] mapping for Supabase responses.
final class BookingModel {
  const BookingModel({
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

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json['id'] as String,
    status: BookingStatus.fromApi(json['status'] as String),
    slotStart: DateTime.parse(json['slot_start'] as String),
    slotEnd: DateTime.parse(json['slot_end'] as String),
    totalMinor: json['total_minor'] as int,
    currency: json['currency'] as String? ?? 'EGP',
    paymentMethod: PaymentMethod.fromApi(
      json['payment_method'] as String? ?? 'cash',
    ),
    items:
        (json['items'] as List<dynamic>?)
            ?.map(
              (item) => BookingItemModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(growable: false) ??
        const [],
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  final String id;
  final BookingStatus status;
  final DateTime slotStart;
  final DateTime slotEnd;
  final int totalMinor;
  final String currency;
  final PaymentMethod paymentMethod;
  final List<BookingItemModel> items;
  final DateTime createdAt;

  Booking toEntity() => Booking(
    id: id,
    status: status,
    slotStart: slotStart,
    slotEnd: slotEnd,
    totalMinor: totalMinor,
    currency: currency,
    paymentMethod: paymentMethod,
    items: items.map((m) => m.toEntity()).toList(growable: false),
    createdAt: createdAt,
  );
}

/// JSON ↔ [BookingItem] mapping.
final class BookingItemModel {
  const BookingItemModel({
    required this.id,
    required this.type,
    required this.nameSnapshot,
    required this.priceMinor,
    required this.durationMinutes,
  });

  factory BookingItemModel.fromJson(Map<String, dynamic> json) =>
      BookingItemModel(
        id: json['id'] as String,
        type: BookingItemType.fromApi(json['item_type'] as String),
        nameSnapshot: json['name_snapshot'] as String,
        priceMinor: json['price_minor'] as int,
        durationMinutes: json['duration_minutes'] as int,
      );

  final String id;
  final BookingItemType type;
  final String nameSnapshot;
  final int priceMinor;
  final int durationMinutes;

  BookingItem toEntity() => BookingItem(
    id: id,
    type: type,
    nameSnapshot: nameSnapshot,
    priceMinor: priceMinor,
    durationMinutes: durationMinutes,
  );
}

/// JSON ↔ [TimeSlot] mapping.
final class TimeSlotModel {
  const TimeSlotModel({
    required this.start,
    required this.end,
    required this.available,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
    start: DateTime.parse(json['slot_start'] as String),
    end: DateTime.parse(json['slot_end'] as String),
    available: json['available'] as bool? ?? true,
  );

  final DateTime start;
  final DateTime end;
  final bool available;

  TimeSlot toEntity() => TimeSlot(start: start, end: end, available: available);
}
