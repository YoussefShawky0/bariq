import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppSizes {
  static const Size designSize = Size(390, 844);
  static const int onboardingHeroFlex = 5;
  static const int onboardingCopyFlex = 4;

  static double get brandMarkWidth => 220.w;
  static double get progressIndicator => 28.r;
  static double get onboardingControlsClearance => 82.h;
  static double get onboardingButtonHeight => 48.h;
  static double get onboardingLoadingIndicator => 18.r;
  static double get onboardingLoadingStroke => 2.w;
  static double get onboardingDot => 7.r;
  static double get onboardingActiveDotWidth => 23.w;
  static double get onboardingDotSpacing => 4.w;
  static double get authBrandWidth => 136.w;
  static double get authContentMaxWidth => 440.w;
  static double get authButtonHeight => 52.h;
  static double get authIcon => 24.r;
  static double get authFeedbackIcon => 64.r;
  static double get authLoadingIndicator => 20.r;
  static double get authLoadingStroke => 2.w;
  static double get authDividerThickness => 1.h;
}
