import 'package:bariq/features/addresses/domain/entities/address.dart';

/// Validated input for creating or updating an address.
class AddressInput {
  const AddressInput({
    required this.label,
    required this.zoneId,
    required this.street,
    required this.isDefault,
    this.id,
    this.building,
    this.floor,
    this.apartment,
    this.accessNotes,
    this.readiness = const AddressReadiness(),
  });

  final String? id;
  final String label;
  final String zoneId;
  final String street;
  final bool isDefault;
  final String? building;
  final String? floor;
  final String? apartment;
  final String? accessNotes;
  final AddressReadiness readiness;

  /// Whether this input represents an update (has an id).
  bool get isUpdate => id != null;
}
