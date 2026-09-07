import 'package:bariq/features/addresses/data/models/address_model.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/domain/entities/address_input.dart';
import 'package:bariq/features/addresses/domain/entities/zone.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Remote data source for addresses backed by Supabase.
abstract interface class AddressRemoteDataSource {
  Future<List<Address>> fetchAddresses();
  Future<Address> insertAddress(AddressInput input, String customerId);
  Future<Address> updateAddress(AddressInput input);
  Future<void> deleteAddress(String addressId);
  Future<List<Zone>> fetchZones();
}

/// Supabase implementation of [AddressRemoteDataSource].
final class SupabaseAddressRemoteDataSource implements AddressRemoteDataSource {
  const SupabaseAddressRemoteDataSource(this._client);
  final SupabaseClient? _client;

  SupabaseClient get _supabase => _client!;

  @override
  Future<List<Address>> fetchAddresses() async {
    final response = await _supabase
        .from('addresses')
        .select('*, zones(name_ar)')
        .order('is_default', ascending: false)
        .order('created_at', ascending: true);
    return response.map(AddressModel.fromJson).toList();
  }

  @override
  Future<Address> insertAddress(AddressInput input, String customerId) async {
    final json = AddressModel.toInsertJson(
      customerId: customerId,
      label: input.label,
      zoneId: input.zoneId,
      street: input.street,
      isDefault: input.isDefault,
      building: input.building,
      floor: input.floor,
      apartment: input.apartment,
      accessNotes: input.accessNotes,
      readiness: input.readiness,
    );
    final response = await _supabase
        .from('addresses')
        .insert(json)
        .select('*, zones(name_ar)')
        .single();
    return AddressModel.fromJson(response);
  }

  @override
  Future<Address> updateAddress(AddressInput input) async {
    final json = AddressModel.toUpdateJson(
      label: input.label,
      zoneId: input.zoneId,
      street: input.street,
      isDefault: input.isDefault,
      building: input.building,
      floor: input.floor,
      apartment: input.apartment,
      accessNotes: input.accessNotes,
      readiness: input.readiness,
    );
    final response = await _supabase
        .from('addresses')
        .update(json)
        .eq('id', input.id!)
        .select('*, zones(name_ar)')
        .single();
    return AddressModel.fromJson(response);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await _supabase.from('addresses').delete().eq('id', addressId);
  }

  @override
  Future<List<Zone>> fetchZones() async {
    final response = await _supabase
        .from('zones')
        .select('id, code, name_ar, name_en')
        .order('name_ar');
    return response.map(ZoneModel.fromJson).toList();
  }
}
