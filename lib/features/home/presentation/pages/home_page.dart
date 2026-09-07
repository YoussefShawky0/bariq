import 'package:bariq/core/config/app_router.dart';
import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/di/injection.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/service_catalog/presentation/cubit/service_catalog_cubit.dart';
import 'package:bariq/features/service_catalog/presentation/widgets/home_service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Home page — post-auth landing screen.
///
/// Matches the Figma design: featured service banner at top,
/// services list below, bottom nav handled by [MainShell].
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCatalogCubit>(
      create: (_) => getIt<ServiceCatalogCubit>()..load(),
      child: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Featured banner.
            SliverToBoxAdapter(child: _FeaturedBanner()),
            // Services section header.
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.pageHorizontal,
                  AppSpacing.section,
                  AppSpacing.pageHorizontal,
                  AppSpacing.regular,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.homeServicesTitle,
                      style: AppTextStyles.sectionTitle,
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.services),
                      child: Text(
                        AppStrings.homeViewAll,
                        style: AppTextStyles.authLink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Services list.
            BlocBuilder<ServiceCatalogCubit, ServiceCatalogState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SliverToBoxAdapter(child: SizedBox()),
                  loading: () => const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  ready: (services) => SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.pageHorizontal,
                    ),
                    sliver: SliverList.separated(
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
                  ),
                  failure: (failure) => SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.section),
                      child: Column(
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
            // Bottom padding.
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.spacious)),
          ],
        ),
      ),
    );
  }
}

/// Featured service banner at the top of home (Figma: dark navy with aqua tag).
class _FeaturedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.pageHorizontal,
        vertical: AppSpacing.regular,
      ),
      padding: EdgeInsets.all(AppSpacing.section),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.aqua,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              AppStrings.homeFeaturedTag,
              style: TextStyle(
                color: AppColors.surface,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.regular),
          Text(
            'غسيل شامل',
            style: TextStyle(
              color: AppColors.surface,
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: AppSpacing.compact),
          Text(
            'تم تعيين محمود — الوصول خلال 30 دقيقة',
            style: TextStyle(
              color: AppColors.surface.withValues(alpha: 0.7),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
