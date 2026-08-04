import 'dart:math' as math;

import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingSlideCopy extends StatelessWidget {
  const OnboardingSlideCopy({
    required this.eyebrow,
    required this.title,
    required this.body,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _buildScrollableCopy);
  }

  Widget _buildScrollableCopy(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final verticalPadding = AppSpacing.regular;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.pageHorizontal,
        vertical: verticalPadding,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: math.max(
            0.0,
            constraints.maxHeight - (verticalPadding * 2),
          ),
        ),
        child: _OnboardingCopyContent(
          eyebrow: eyebrow,
          title: title,
          body: body,
        ),
      ),
    );
  }
}

class _OnboardingCopyContent extends StatelessWidget {
  const _OnboardingCopyContent({
    required this.eyebrow,
    required this.title,
    required this.body,
  });

  final String eyebrow;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(eyebrow, style: AppTextStyles.onboardingEyebrow),
        SizedBox(height: AppSpacing.compact),
        Text(
          title,
          style: AppTextStyles.onboardingHeadline,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.compact),
        Text(
          body,
          style: AppTextStyles.onboardingBody,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
