import 'package:bariq/app/app.dart';
import 'package:bariq/core/config/app_environment.dart';
import 'package:bariq/core/di/injection.dart';
import 'package:bariq/core/network/supabase_initializer.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: AppColors.background,
      systemNavigationBarContrastEnforced: false,
    ),
  );

  final environment = await AppEnvironment.load();
  final supabaseClient = await SupabaseInitializer.initialize(environment);
  await configureDependencies(supabaseClient: supabaseClient);
  runApp(const BariqApp());

  widgetsBinding.addPostFrameCallback((_) => FlutterNativeSplash.remove());
}
