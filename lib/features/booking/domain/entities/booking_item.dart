/// Type discriminator for items snapshot inside a booking.
enum BookingItemType {
  service,
  addon;

  /// Stable value persisted by the backend contract.
  String get apiValue => name;

  /// Parses a backend value safely.
  static BookingItemType fromApi(String value) =>
      BookingItemType.values.firstWhere(
        (t) => t.apiValue == value,
        orElse: () => BookingItemType.service,
      );
}

/// A price-frozen snapshot of a service or add-on within a confirmed booking.
///
/// Prices and names are captured at booking time and never change
/// even if the catalog is updated later.
final class BookingItem {
  const BookingItem({
    required this.id,
    required this.type,
    required this.nameSnapshot,
    required this.priceMinor,
    required this.durationMinutes,
  });

  final String id;
  final BookingItemType type;
  final String nameSnapshot;

  /// Price in minor currency units (e.g. piasters).
  final int priceMinor;
  final int durationMinutes;

  /// Display price in EGP.
  String get priceDisplay => '${priceMinor ~/ 100} ج.م';
}
