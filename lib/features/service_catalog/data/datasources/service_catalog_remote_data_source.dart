import 'package:bariq/features/service_catalog/data/models/service_model.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_addon.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_pricing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Remote data source for the service catalog backed by Supabase.
abstract interface class ServiceCatalogRemoteDataSource {
  Future<List<Service>> fetchServices();
  Future<List<ServiceAddon>> fetchAddons(String serviceId);
  Future<List<ServicePricing>> fetchPricingConfigs(String serviceId);
}

/// Supabase implementation.
final class SupabaseServiceCatalogRemoteDataSource
    implements ServiceCatalogRemoteDataSource {
  const SupabaseServiceCatalogRemoteDataSource(this._client);
  final SupabaseClient? _client;

  SupabaseClient get _supabase => _client!;

  @override
  Future<List<Service>> fetchServices() async {
    final response = await _supabase
        .from('services')
        .select('*, service_zone_configs(price_minor)')
        .order('sort_order');
    return response.map(ServiceModel.fromJson).toList();
  }

  @override
  Future<List<ServiceAddon>> fetchAddons(String serviceId) async {
    final response = await _supabase
        .from('service_addons')
        .select()
        .eq('service_id', serviceId)
        .order('sort_order');
    return response.map(ServiceAddonModel.fromJson).toList();
  }

  @override
  Future<List<ServicePricing>> fetchPricingConfigs(String serviceId) async {
    final response = await _supabase
        .from('service_zone_configs')
        .select()
        .eq('service_id', serviceId)
        .order('vehicle_class');
    return response.map(ServicePricingModel.fromJson).toList();
  }
}
