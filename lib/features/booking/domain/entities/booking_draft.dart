import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/booking/domain/entities/payment_method.dart';
import 'package:bariq/features/booking/domain/entities/time_slot.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_addon.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_pricing.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';

/// Client-side draft that accumulates wizard selections step by step.
///
/// Immutable — each step produces a new [BookingDraft] via `copyWith`.
/// The draft is never sent to the server until [isComplete] is true.
final class BookingDraft {
  const BookingDraft({
    this.vehicle,
    this.service,
    this.addons = const [],
    this.pricing,
    this.address,
    this.slot,
    this.paymentMethod = PaymentMethod.cash,
  });

  final Vehicle? vehicle;
  final Service? service;
  final List<ServiceAddon> addons;

  /// Resolved pricing for the selected service + zone + vehicle class.
  final ServicePricing? pricing;
  final Address? address;
  final TimeSlot? slot;
  final PaymentMethod paymentMethod;

  /// Total price in minor units (service base + selected add-ons).
  int get totalMinor {
    final base = pricing?.priceMinor ?? 0;
    final addonsTotal = addons.fold<int>(0, (sum, a) => sum + a.priceMinor);
    return base + addonsTotal;
  }

  /// Total estimated duration in minutes.
  int get totalDurationMinutes {
    final base = pricing?.durationMinutes ?? 0;
    final addonsDuration =
        addons.fold<int>(0, (sum, a) => sum + a.durationMinutes);
    return base + addonsDuration;
  }

  /// Display price in EGP.
  String get totalDisplay => '${totalMinor ~/ 100} ج.م';

  /// All required fields are filled and the draft is ready for submission.
  bool get isComplete =>
      vehicle != null &&
      service != null &&
      pricing != null &&
      address != null &&
      slot != null;

  /// Creates a copy with the given fields replaced.
  BookingDraft copyWith({
    Vehicle? vehicle,
    Service? service,
    List<ServiceAddon>? addons,
    ServicePricing? pricing,
    Address? address,
    TimeSlot? slot,
    PaymentMethod? paymentMethod,
  }) => BookingDraft(
    vehicle: vehicle ?? this.vehicle,
    service: service ?? this.service,
    addons: addons ?? this.addons,
    pricing: pricing ?? this.pricing,
    address: address ?? this.address,
    slot: slot ?? this.slot,
    paymentMethod: paymentMethod ?? this.paymentMethod,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingDraft &&
          runtimeType == other.runtimeType &&
          vehicle?.id == other.vehicle?.id &&
          service?.id == other.service?.id &&
          pricing?.serviceId == other.pricing?.serviceId &&
          pricing?.priceMinor == other.pricing?.priceMinor &&
          address?.id == other.address?.id &&
          slot == other.slot &&
          paymentMethod == other.paymentMethod &&
          _addonsEquals(addons, other.addons);

  @override
  int get hashCode => Object.hash(
        vehicle?.id,
        service?.id,
        pricing?.serviceId,
        address?.id,
        slot,
        paymentMethod,
        Object.hashAll(addons.map((a) => a.id)),
      );

  static bool _addonsEquals(List<ServiceAddon> a, List<ServiceAddon> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }
    return true;
  }
}
