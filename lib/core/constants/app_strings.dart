import 'package:flutter/widgets.dart';

abstract final class AppStrings {
  static const String appName = 'BARIQ';
  static const String tagline = 'Car Care, Wherever You Are';
  static const String brandSemanticLabel = 'BARIQ logo';
  static const String foundationReady = 'الأساس جاهز';
  static const String onboardingNext = 'الخطوة التالية: تجربة التعريف بالتطبيق';
  static const String signInNext = 'الخطوة التالية: تسجيل الدخول';
  static const String homeNext = 'تم العثور على جلسة محفوظة';
  static const String initializationFailed = 'تعذر تجهيز التطبيق';
  static const String retry = 'إعادة المحاولة';
  static const String genericError = 'حدث خطأ غير متوقع. حاول مرة أخرى.';

  static const Locale arabicLocale = Locale('ar');
  static const List<Locale> supportedLocales = [arabicLocale];
}
