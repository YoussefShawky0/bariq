import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_addon.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_detail.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_pricing.dart';

Service testService({
  String id = 'service-1',
  String code = 'exterior_wash',
  String nameAr = 'غسيل خارجي',
  String nameEn = 'Exterior Wash',
  String descriptionAr = 'غسيل خارجي شامل',
  String descriptionEn = 'Full exterior wash',
  String iconName = 'local_car_wash',
  int baseDurationMinutes = 45,
  int? startingPriceMinor = 18000,
}) =>
    Service(
      id: id,
      code: code,
      nameAr: nameAr,
      nameEn: nameEn,
      descriptionAr: descriptionAr,
      descriptionEn: descriptionEn,
      iconName: iconName,
      baseDurationMinutes: baseDurationMinutes,
      startingPriceMinor: startingPriceMinor,
    );

ServiceAddon testServiceAddon({
  String id = 'addon-1',
  String serviceId = 'service-1',
  String nameAr = 'تنظيف الجنوط',
  String nameEn = 'Rim Cleaning',
  String descriptionAr = 'تنظيف عميق للجنوط',
  int priceMinor = 5000,
  int durationMinutes = 15,
}) =>
    ServiceAddon(
      id: id,
      serviceId: serviceId,
      nameAr: nameAr,
      nameEn: nameEn,
      descriptionAr: descriptionAr,
      priceMinor: priceMinor,
      durationMinutes: durationMinutes,
    );

ServicePricing testServicePricing({
  String serviceId = 'service-1',
  String zoneId = 'zone-1',
  String vehicleClass = 'sedan',
  int priceMinor = 18000,
  int durationMinutes = 45,
}) =>
    ServicePricing(
      serviceId: serviceId,
      zoneId: zoneId,
      vehicleClass: vehicleClass,
      priceMinor: priceMinor,
      durationMinutes: durationMinutes,
    );

ServiceDetail testServiceDetail({
  Service? service,
  List<ServiceAddon>? addons,
  List<ServicePricing>? pricingConfigs,
}) =>
    ServiceDetail(
      service: service ?? testService(),
      addons: addons ?? [testServiceAddon()],
      pricingConfigs: pricingConfigs ?? [testServicePricing()],
    );
