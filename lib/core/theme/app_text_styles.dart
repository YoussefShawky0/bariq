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

  static TextStyle get onboardingHeadline => TextStyle(
    color: AppColors.navy,
    fontSize: 26.sp,
    fontWeight: FontWeight.w800,
    height: 1.35,
  );

  static TextStyle get onboardingBody => TextStyle(
    color: AppColors.textMuted,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    height: 1.75,
  );

  static TextStyle get onboardingEyebrow => TextStyle(
    color: AppColors.aqua,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get onboardingButton => TextStyle(
    color: AppColors.surface,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get onboardingSkip => TextStyle(
    color: AppColors.textMuted,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get errorCaption => TextStyle(
    color: AppColors.error,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get authTitle => TextStyle(
    color: AppColors.navy,
    fontSize: 28.sp,
    fontWeight: FontWeight.w800,
    height: 1.35,
  );

  static TextStyle get authSubtitle => TextStyle(
    color: AppColors.textMuted,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.7,
  );

  static TextStyle get fieldLabel => TextStyle(
    color: AppColors.navy,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get authLink => TextStyle(
    color: AppColors.aqua,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get authCaption => TextStyle(
    color: AppColors.textMuted,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.6,
  );

  static TextStyle get successCaption => TextStyle(
    color: AppColors.success,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.6,
  );

  static TextStyle get profileStep => TextStyle(
    color: AppColors.aqua,
    fontSize: 12.sp,
    fontWeight: FontWeight.w800,
  );

  static TextStyle get sectionTitle => TextStyle(
    color: AppColors.navy,
    fontSize: 16.sp,
    fontWeight: FontWeight.w800,
  );

  static TextStyle get helper => TextStyle(
    color: AppColors.textMuted,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.6,
  );
}
