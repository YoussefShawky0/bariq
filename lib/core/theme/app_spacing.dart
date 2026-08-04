import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppSpacing {
  static double get tiny => 4.h;
  static double get pageHorizontal => 24.w;
  static double get pageVertical => 24.h;
  static double get compact => 8.h;
  static double get regular => 16.h;
  static double get section => 24.h;
  static double get spacious => 32.h;
  static double get onboardingControlsHorizontal => 18.w;
  static double get onboardingControlsVertical => 14.h;
  static double get authCardHorizontal => 20.w;
  static double get authCardVertical => 24.h;
  static double get fieldGap => 12.h;
}
