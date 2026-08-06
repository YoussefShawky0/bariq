import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/features/vehicles/data/models/vehicle_model.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class VehicleRemoteDataSource {
  Future<List<VehicleModel>> loadVehicles();

  Future<VehicleModel> saveVehicle(VehicleInput input);

  Future<void> deleteVehicle(String id);
}

final class SupabaseVehicleRemoteDataSource implements VehicleRemoteDataSource {
  const SupabaseVehicleRemoteDataSource(this._supabaseClient);

  static const _table = 'vehicles';
  static const _saveRpc = 'save_my_vehicle';
  static const _deleteRpc = 'delete_my_vehicle';
  static const _columns =
      'id, make, model, year, color, plate_number, vehicle_class, '
      'is_default, created_at';

  final SupabaseClient? _supabaseClient;

  SupabaseClient get _client {
    final client = _supabaseClient;
    if (client == null) {
      throw const BackendConfigurationException();
    }
    return client;
  }

  User get _user {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const UnauthenticatedException();
    }
    return user;
  }

  void _ensureAuthenticated() {
    if (_client.auth.currentUser == null) {
      throw const UnauthenticatedException();
    }
  }

  @override
  Future<List<VehicleModel>> loadVehicles() async {
    final user = _user;
    final rows = await _client
        .from(_table)
        .select(_columns)
        .eq('customer_id', user.id)
        .order('is_default', ascending: false)
        .order('created_at');
    return rows.map(VehicleModel.fromJson).toList(growable: false);
  }

  @override
  Future<VehicleModel> saveVehicle(VehicleInput input) async {
    _ensureAuthenticated();
    final json = await _client
        .rpc<List<Map<String, dynamic>>>(
          _saveRpc,
          params: {
            'p_vehicle_id': input.id,
            'p_make': input.make,
            'p_model': input.model,
            'p_year': input.year,
            'p_color': input.color,
            'p_plate_number': input.plateNumber,
            'p_vehicle_class': input.vehicleClass.apiValue,
            'p_is_default': input.isDefault,
          },
        )
        .single();
    return VehicleModel.fromJson(json);
  }

  @override
  Future<void> deleteVehicle(String id) async {
    _ensureAuthenticated();
    await _client.rpc<void>(_deleteRpc, params: {'p_vehicle_id': id});
  }
}
