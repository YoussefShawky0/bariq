import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_addon.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_pricing.dart';

/// Maps Supabase JSON to [Service] entity.
class ServiceModel {
  const ServiceModel._();

  static Service fromJson(Map<String, dynamic> json) {
    // Starting price comes from a joined aggregate or separate query.
    final configs = json['service_zone_configs'] as List<dynamic>?;
    int? startingPrice;
    if (configs != null && configs.isNotEmpty) {
      startingPrice = configs
          .map((c) => (c as Map<String, dynamic>)['price_minor'] as int)
          .reduce((a, b) => a < b ? a : b);
    }

    return Service(
      id: json['id'] as String,
      code: json['code'] as String,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String,
      descriptionAr: json['description_ar'] as String? ?? '',
      descriptionEn: json['description_en'] as String? ?? '',
      iconName: json['icon_name'] as String? ?? 'local_car_wash',
      baseDurationMinutes: json['base_duration_minutes'] as int,
      startingPriceMinor: startingPrice,
    );
  }
}

/// Maps Supabase JSON to [ServiceAddon] entity.
class ServiceAddonModel {
  const ServiceAddonModel._();

  static ServiceAddon fromJson(Map<String, dynamic> json) => ServiceAddon(
        id: json['id'] as String,
        serviceId: json['service_id'] as String,
        nameAr: json['name_ar'] as String,
        nameEn: json['name_en'] as String,
        descriptionAr: json['description_ar'] as String? ?? '',
        priceMinor: json['price_minor'] as int,
        durationMinutes: json['duration_minutes'] as int? ?? 0,
      );
}

/// Maps Supabase JSON to [ServicePricing] entity.
class ServicePricingModel {
  const ServicePricingModel._();

  static ServicePricing fromJson(Map<String, dynamic> json) => ServicePricing(
        serviceId: json['service_id'] as String,
        zoneId: json['zone_id'] as String,
        vehicleClass: json['vehicle_class'] as String,
        priceMinor: json['price_minor'] as int,
        durationMinutes: json['duration_minutes'] as int,
      );
}
