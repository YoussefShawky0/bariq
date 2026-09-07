import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/domain/entities/zone.dart';

/// Maps Supabase JSON to [Zone] entity.
class ZoneModel {
  const ZoneModel._();

  static Zone fromJson(Map<String, dynamic> json) => Zone(
    id: json['id'] as String,
    code: json['code'] as String,
    nameAr: json['name_ar'] as String,
    nameEn: json['name_en'] as String,
  );
}

/// Maps Supabase JSON to [Address] entity and back.
class AddressModel {
  const AddressModel._();

  static Address fromJson(Map<String, dynamic> json) {
    final readinessJson = json['readiness'] as Map<String, dynamic>? ?? {};
    final zone = json['zones'] as Map<String, dynamic>?;

    return Address(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      zoneId: json['zone_id'] as String,
      zoneName: zone?['name_ar'] as String? ?? '',
      label: json['label'] as String,
      street: json['street'] as String,
      isDefault: json['is_default'] as bool? ?? false,
      building: json['building'] as String?,
      floor: json['floor'] as String?,
      apartment: json['apartment'] as String?,
      accessNotes: json['access_notes'] as String?,
      readiness: AddressReadiness.fromJson(readinessJson),
    );
  }

  static Map<String, dynamic> toInsertJson({
    required String customerId,
    required String label,
    required String zoneId,
    required String street,
    required bool isDefault,
    String? building,
    String? floor,
    String? apartment,
    String? accessNotes,
    required AddressReadiness readiness,
  }) => {
    'customer_id': customerId,
    'label': label,
    'zone_id': zoneId,
    'street': street,
    'is_default': isDefault,
    'building': ?building,
    'floor': ?floor,
    'apartment': ?apartment,
    'access_notes': ?accessNotes,
    'readiness': readiness.toJson(),
  };

  static Map<String, dynamic> toUpdateJson({
    required String label,
    required String zoneId,
    required String street,
    required bool isDefault,
    String? building,
    String? floor,
    String? apartment,
    String? accessNotes,
    required AddressReadiness readiness,
  }) => {
    'label': label,
    'zone_id': zoneId,
    'street': street,
    'is_default': isDefault,
    'building': building,
    'floor': floor,
    'apartment': apartment,
    'access_notes': accessNotes,
    'readiness': readiness.toJson(),
  };
}
