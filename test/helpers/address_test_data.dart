import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/domain/entities/address_input.dart';
import 'package:bariq/features/addresses/domain/entities/zone.dart';

Zone testZone({
  String id = 'zone-cairo-id',
  String code = 'cairo',
  String nameAr = 'القاهرة',
  String nameEn = 'Cairo',
}) =>
    Zone(
      id: id,
      code: code,
      nameAr: nameAr,
      nameEn: nameEn,
    );

Address testAddress({
  String id = 'address-id-1',
  String customerId = 'customer-id',
  String zoneId = 'zone-cairo-id',
  String zoneName = 'القاهرة',
  String label = 'البيت',
  String street = 'شارع الطيران',
  bool isDefault = true,
  String? building = '١٢',
  String? floor = '٣',
  String? apartment = '٤',
  String? accessNotes = 'بوابة ٣',
  AddressReadiness readiness = const AddressReadiness(
    hasAccess: true,
    hasVehicleSpace: true,
    noWaterNeeded: true,
    hasPermission: true,
  ),
}) =>
    Address(
      id: id,
      customerId: customerId,
      zoneId: zoneId,
      zoneName: zoneName,
      label: label,
      street: street,
      isDefault: isDefault,
      building: building,
      floor: floor,
      apartment: apartment,
      accessNotes: accessNotes,
      readiness: readiness,
    );

AddressInput testAddressInput({
  String? id,
  String label = 'البيت',
  String zoneId = 'zone-cairo-id',
  String street = 'شارع الطيران',
  bool isDefault = true,
  String? building = '١٢',
  String? floor = '٣',
  String? apartment = '٤',
  String? accessNotes = 'بوابة ٣',
  AddressReadiness readiness = const AddressReadiness(
    hasAccess: true,
    hasVehicleSpace: true,
    noWaterNeeded: true,
    hasPermission: true,
  ),
}) =>
    AddressInput(
      id: id,
      label: label,
      zoneId: zoneId,
      street: street,
      isDefault: isDefault,
      building: building,
      floor: floor,
      apartment: apartment,
      accessNotes: accessNotes,
      readiness: readiness,
    );
