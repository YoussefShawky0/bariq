import 'package:bariq/core/config/app_router.dart';
import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/di/injection.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/service_catalog/presentation/cubit/service_catalog_cubit.dart';
import 'package:bariq/features/service_catalog/presentation/widgets/home_service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Services page displaying full catalog of services.
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCatalogCubit>(
      create: (_) => getIt<ServiceCatalogCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.servicesTitle),
        ),
        body: SafeArea(
          child: BlocBuilder<ServiceCatalogCubit, ServiceCatalogState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator()),
                ready: (services) => ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.pageHorizontal,
                    vertical: AppSpacing.pageVertical,
                  ),
                  itemCount: services.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(height: AppSpacing.fieldGap),
                  itemBuilder: (context, index) => HomeServiceCard(
                    service: services[index],
                    onTap: () => context.go(
                      AppRoutes.serviceDetail(services[index].id),
                    ),
                  ),
                ),
                failure: (failure) => Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.section),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(failure.message, style: AppTextStyles.body),
                        SizedBox(height: AppSpacing.regular),
                        FilledButton(
                          onPressed: () =>
                              context.read<ServiceCatalogCubit>().load(),
                          child: const Text(AppStrings.retry),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
