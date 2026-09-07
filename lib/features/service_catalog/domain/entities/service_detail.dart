import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_addon.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_pricing.dart';

/// Full detail view of a service with addons and pricing configs.
class ServiceDetail {
  const ServiceDetail({
    required this.service,
    required this.addons,
    required this.pricingConfigs,
  });

  final Service service;
  final List<ServiceAddon> addons;
  final List<ServicePricing> pricingConfigs;
}
