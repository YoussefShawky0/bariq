import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/di/injection.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:bariq/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:bariq/features/booking/presentation/widgets/booking_price_summary.dart';
import 'package:bariq/features/service_catalog/domain/entities/service.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_addon.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_detail.dart';
import 'package:bariq/features/service_catalog/domain/entities/service_pricing.dart';
import 'package:bariq/features/service_catalog/domain/usecases/load_service_detail.dart';
import 'package:bariq/features/service_catalog/presentation/cubit/service_catalog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceStep extends StatefulWidget {
  const ServiceStep({super.key});

  @override
  State<ServiceStep> createState() => _ServiceStepState();
}

class _ServiceStepState extends State<ServiceStep> {
  Service? _selectedService;
  ServiceDetail? _selectedDetail;
  bool _isLoadingDetail = false;
  final List<ServiceAddon> _selectedAddons = [];

  @override
  void initState() {
    super.initState();
    final draft = context.read<BookingBloc>().state.maybeWhen(
      drafting: (draft, _) => draft,
      loadingSlots: (draft) => draft,
      slotsReady: (draft, _) => draft,
      submitting: (draft) => draft,
      failure: (draft, _) => draft,
      orElse: () => null,
    );
    if (draft?.service != null) {
      _selectedService = draft!.service;
      _selectedAddons.addAll(draft.addons);
      _loadDetail(draft.service!.id);
    }
  }

  Future<void> _loadDetail(String serviceId) async {
    setState(() => _isLoadingDetail = true);
    final result = await getIt<LoadServiceDetail>()(serviceId);
    if (!mounted) return;
    result.match(
      (failure) => setState(() => _isLoadingDetail = false),
      (detail) => setState(() {
        _selectedDetail = detail;
        _isLoadingDetail = false;
      }),
    );
  }

  void _onServiceTapped(Service service) {
    if (_selectedService?.id == service.id) return;
    setState(() {
      _selectedService = service;
      _selectedDetail = null;
      _selectedAddons.clear();
    });
    _loadDetail(service.id);
  }

  void _toggleAddon(ServiceAddon addon) {
    setState(() {
      if (_selectedAddons.any((a) => a.id == addon.id)) {
        _selectedAddons.removeWhere((a) => a.id == addon.id);
      } else {
        _selectedAddons.add(addon);
      }
    });
  }

  void _onContinue(ServicePricing pricing) {
    if (_selectedService == null) return;
    context.read<BookingBloc>().add(
      BookingEvent.serviceSelected(
        _selectedService!,
        List.unmodifiable(_selectedAddons),
        pricing,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, bookingState) {
        final draft = bookingState.maybeWhen(
          drafting: (draft, _) => draft,
          loadingSlots: (draft) => draft,
          slotsReady: (draft, _) => draft,
          submitting: (draft) => draft,
          failure: (draft, _) => draft,
          orElse: () => null,
        );
        final vehicleClass = draft?.vehicle?.vehicleClass;

        return BlocBuilder<ServiceCatalogCubit, ServiceCatalogState>(
          builder: (context, catalogState) {
            return catalogState.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (failure) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      failure.message,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    SizedBox(height: AppSpacing.regular),
                    OutlinedButton(
                      onPressed: () =>
                          context.read<ServiceCatalogCubit>().load(),
                      child: const Text(AppStrings.retry),
                    ),
                  ],
                ),
              ),
              ready: (services) =>
                  _buildContent(services, vehicleClass?.name, draft),
            );
          },
        );
      },
    );
  }

  Widget _buildContent(
    List<Service> services,
    String? vehicleClassName,
    BookingDraft? currentDraft,
  ) {
    ServicePricing? matchedPricing;
    if (_selectedDetail != null && _selectedDetail!.pricingConfigs.isNotEmpty) {
      matchedPricing = _selectedDetail!.pricingConfigs.firstWhere(
        (p) => p.vehicleClass == (vehicleClassName ?? ''),
        orElse: () => _selectedDetail!.pricingConfigs.first,
      );
    }

    final previewDraft = (currentDraft ?? const BookingDraft()).copyWith(
      service: _selectedService,
      addons: _selectedAddons,
      pricing: matchedPricing,
    );

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.pageHorizontal,
              vertical: AppSpacing.regular,
            ),
            children: [
              Text(AppStrings.servicesTitle, style: AppTextStyles.sectionTitle),
              SizedBox(height: AppSpacing.compact),
              ...services.map((service) {
                final isSelected = _selectedService?.id == service.id;
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.compact),
                  child: InkWell(
                    onTap: () => _onServiceTapped(service),
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    child: Container(
                      padding: EdgeInsets.all(AppSpacing.regular),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.aquaSurface
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                        border: Border.all(
                          color: isSelected ? AppColors.aqua : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service.nameAr,
                                  style: AppTextStyles.sectionTitle,
                                ),
                                if (service.descriptionAr.isNotEmpty) ...[
                                  SizedBox(height: AppSpacing.tiny),
                                  Text(
                                    service.descriptionAr,
                                    style: AppTextStyles.helper,
                                  ),
                                ],
                                SizedBox(height: AppSpacing.tiny),
                                Text(
                                  '${AppStrings.serviceStartingPrice} ${service.startingPriceDisplay}',
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColors.aqua,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: isSelected
                                ? AppColors.aqua
                                : AppColors.dotInactive,
                            size: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              if (_isLoadingDetail)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (_selectedDetail != null &&
                  _selectedDetail!.addons.isNotEmpty) ...[
                SizedBox(height: AppSpacing.regular),
                Text(
                  AppStrings.serviceAddons,
                  style: AppTextStyles.sectionTitle,
                ),
                SizedBox(height: AppSpacing.compact),
                ..._selectedDetail!.addons.map((addon) {
                  final isAddonSelected = _selectedAddons.any(
                    (a) => a.id == addon.id,
                  );
                  return CheckboxListTile(
                    value: isAddonSelected,
                    activeColor: AppColors.aqua,
                    onChanged: (_) => _toggleAddon(addon),
                    title: Text(addon.nameAr, style: AppTextStyles.body),
                    subtitle: Text(
                      '+${addon.priceDisplay} (${addon.durationMinutes} دقيقة)',
                      style: AppTextStyles.helper.copyWith(
                        color: AppColors.aqua,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }),
              ],
            ],
          ),
        ),
        if (_selectedService != null && matchedPricing != null)
          Container(
            padding: EdgeInsets.all(AppSpacing.regular),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.scrim,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BookingPriceSummary(draft: previewDraft),
                SizedBox(height: AppSpacing.regular),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.aqua,
                      foregroundColor: AppColors.surface,
                    ),
                    onPressed: () => _onContinue(matchedPricing!),
                    child: Text(AppStrings.next, style: AppTextStyles.button),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
