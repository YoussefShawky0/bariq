import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppSpacing {
  static double get pageHorizontal => 24.w;
  static double get pageVertical => 24.h;
  static double get compact => 8.h;
  static double get regular => 16.h;
  static double get section => 24.h;
  static double get spacious => 32.h;
}
