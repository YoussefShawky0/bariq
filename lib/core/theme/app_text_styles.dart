import 'package:bariq/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppTextStyles {
  static TextStyle get brand => TextStyle(
    color: AppColors.navy,
    fontSize: 36.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: 3.sp,
  );

  static TextStyle get title => TextStyle(
    color: AppColors.navy,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get body => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get button => TextStyle(
    color: AppColors.surface,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
}
