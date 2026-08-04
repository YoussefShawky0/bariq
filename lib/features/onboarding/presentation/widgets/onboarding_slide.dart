import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/features/onboarding/presentation/widgets/onboarding_slide_copy.dart';
import 'package:flutter/material.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    required this.assetPath,
    required this.imageSemanticLabel,
    required this.eyebrow,
    required this.title,
    required this.body,
    this.imageAlignment = Alignment.center,
    super.key,
  });

  final String assetPath;
  final String imageSemanticLabel;
  final String eyebrow;
  final String title;
  final String body;
  final Alignment imageAlignment;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Column(
        children: [
          Expanded(
            flex: AppSizes.onboardingHeroFlex,
            child: _OnboardingHeroImage(
              assetPath: assetPath,
              semanticLabel: imageSemanticLabel,
              alignment: imageAlignment,
            ),
          ),
          Expanded(
            flex: AppSizes.onboardingCopyFlex,
            child: OnboardingSlideCopy(
              eyebrow: eyebrow,
              title: title,
              body: body,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingHeroImage extends StatelessWidget {
  const _OnboardingHeroImage({
    required this.assetPath,
    required this.semanticLabel,
    required this.alignment,
  });

  final String assetPath;
  final String semanticLabel;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.onboardingHero),
        ),
        child: Image.asset(
          assetPath,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          alignment: alignment,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
