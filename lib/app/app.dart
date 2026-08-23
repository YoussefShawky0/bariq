import 'package:bariq/core/config/app_router.dart';
import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/di/injection.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_theme.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BariqApp extends StatefulWidget {
  const BariqApp({super.key});

  @override
  State<BariqApp> createState() => _BariqAppState();
}

class _BariqAppState extends State<BariqApp> {
  late final AppStartupCubit _startupCubit;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _startupCubit = getIt<AppStartupCubit>()..initialize();
    _router = createAppRouter(_startupCubit);
  }

  @override
  void dispose() {
    _router.dispose();
    _startupCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppSizes.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return BlocProvider<AppStartupCubit>.value(
          value: _startupCubit,
          child: MaterialApp.router(
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
            routerConfig: _router,
          ),
        );
      },
    );
  }
}

