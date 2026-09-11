import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/booking/domain/entities/booking.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:bariq/features/booking/domain/entities/booking_item.dart';
import 'package:bariq/features/booking/domain/entities/booking_status.dart';
import 'package:bariq/features/booking/domain/entities/payment_method.dart';
import 'package:bariq/features/booking/domain/entities/time_slot.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_addon.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_pricing.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_class.dart';

Vehicle testVehicle({String id = 'veh-1'}) => Vehicle(
      id: id,
      make: 'Toyota',
      model: 'Corolla',
      year: 2022,
      color: 'أبيض',
      plateNumber: 'أ ب ج ١٢٣',
      vehicleClass: VehicleClass.sedan,
      isDefault: true,
      createdAt: DateTime.utc(2026, 8, 5),
    );

Address testAddress({String id = 'addr-1', String zoneId = 'zone-1'}) =>
    Address(
      id: id,
      customerId: 'cust-1',
      zoneId: zoneId,
      zoneName: 'مدينة نصر',
      label: 'البيت',
      street: 'شارع عباس العقاد',
      isDefault: true,
    );

Service testService({String id = 'srv-1'}) => Service(
      id: id,
      code: 'basic_wash',
      nameAr: 'غسيل أساسي',
      nameEn: 'Basic Wash',
      descriptionAr: 'غسيل خارجي سريع',
      descriptionEn: 'Quick exterior wash',
      iconName: 'local_car_wash',
      baseDurationMinutes: 30,
      startingPriceMinor: 15000,
    );

ServicePricing testPricing({String serviceId = 'srv-1', String zoneId = 'zone-1'}) =>
    ServicePricing(
      serviceId: serviceId,
      zoneId: zoneId,
      vehicleClass: 'sedan',
      priceMinor: 15000,
      durationMinutes: 30,
    );

ServiceAddon testAddon({String id = 'addon-1', String serviceId = 'srv-1'}) =>
    ServiceAddon(
      id: id,
      serviceId: serviceId,
      nameAr: 'تعطير داخلي',
      nameEn: 'Interior Scent',
      descriptionAr: 'تعطير مميز',
      priceMinor: 3000,
      durationMinutes: 5,
    );

TimeSlot testTimeSlot({
  DateTime? start,
  DateTime? end,
  bool available = true,
}) =>
    TimeSlot(
      start: start ?? DateTime.utc(2026, 9, 8, 10, 0),
      end: end ?? DateTime.utc(2026, 9, 8, 12, 0),
      available: available,
    );

BookingDraft testBookingDraft({
  Vehicle? vehicle,
  Service? service,
  List<ServiceAddon>? addons,
  ServicePricing? pricing,
  Address? address,
  TimeSlot? slot,
  PaymentMethod paymentMethod = PaymentMethod.cash,
}) =>
    BookingDraft(
      vehicle: vehicle ?? testVehicle(),
      service: service ?? testService(),
      addons: addons ?? [testAddon()],
      pricing: pricing ?? testPricing(),
      address: address ?? testAddress(),
      slot: slot ?? testTimeSlot(),
      paymentMethod: paymentMethod,
    );

Booking testBooking({
  String id = 'booking-123',
  BookingStatus status = BookingStatus.confirmed,
}) =>
    Booking(
      id: id,
      status: status,
      slotStart: DateTime.utc(2026, 9, 8, 10, 0),
      slotEnd: DateTime.utc(2026, 9, 8, 12, 0),
      totalMinor: 18000,
      currency: 'EGP',
      paymentMethod: PaymentMethod.cash,
      items: [
        const BookingItem(
          id: 'item-1',
          type: BookingItemType.service,
          nameSnapshot: 'غسيل أساسي',
          priceMinor: 15000,
          durationMinutes: 30,
        ),
        const BookingItem(
          id: 'item-2',
          type: BookingItemType.addon,
          nameSnapshot: 'تعطير داخلي',
          priceMinor: 3000,
          durationMinutes: 5,
        ),
      ],
      createdAt: DateTime.utc(2026, 9, 8, 9, 0),
    );
