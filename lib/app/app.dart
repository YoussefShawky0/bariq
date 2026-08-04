import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/di/injection.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:bariq/features/app_startup/presentation/pages/app_startup_page.dart';
import 'package:bariq/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BariqApp extends StatelessWidget {
  const BariqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppSizes.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider<AppStartupCubit>(
          create: (_) => getIt<AppStartupCubit>()..initialize(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            locale: AppStrings.arabicLocale,
            supportedLocales: AppStrings.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: AppTheme.light,
            home: child,
          ),
        );
      },
      child: AppStartupPage(
        onboardingCubitFactory: () => getIt<OnboardingCubit>(),
        authBlocFactory: () => getIt<AuthBloc>(),
      ),
    );
  }
}
