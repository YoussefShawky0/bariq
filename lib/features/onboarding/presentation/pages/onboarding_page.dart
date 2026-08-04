import 'dart:async';

import 'package:bariq/core/constants/app_assets.dart';
import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_motion.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bariq/features/onboarding/presentation/widgets/onboarding_control_button.dart';
import 'package:bariq/features/onboarding/presentation/widgets/onboarding_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({required this.onCompleted, super.key});

  final Future<void> Function() onCompleted;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: _onStateChanged,
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        final isSaving = state is OnboardingSaving;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: IntroductionScreen(
            rawPages: _slides,
            initialPage: state.currentPage,
            onChange: cubit.showPage,
            onDone: () => unawaited(cubit.complete()),
            onSkip: () => unawaited(cubit.complete()),
            showSkipButton: true,
            rtl: true,
            freeze: isSaving,
            isProgressTap: false,
            animationDuration: AppMotion.pageTransition.inMilliseconds,
            curve: AppMotion.standardCurve,
            globalBackgroundColor: AppColors.background,
            bodyPadding: EdgeInsets.only(
              bottom: AppSizes.onboardingControlsClearance,
            ),
            controlsPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.onboardingControlsHorizontal,
              vertical: AppSpacing.onboardingControlsVertical,
            ),
            safeAreaList: const [false, false, false, true],
            scrollPhysics: const ClampingScrollPhysics(),
            dotsDecorator: _dotsDecorator,
            progressSemantic: AppStrings.onboardingProgressLabel,
            overrideSkip: (_, onPressed) => OnboardingSkipButton(
              label: AppStrings.skip,
              onPressed: isSaving ? null : onPressed,
            ),
            overrideNext: (_, onPressed) => OnboardingControlButton(
              label: AppStrings.next,
              onPressed: isSaving ? null : onPressed,
            ),
            overrideDone: (_, onPressed) => OnboardingControlButton(
              label: AppStrings.startNow,
              isLoading: isSaving,
              onPressed: isSaving ? null : onPressed,
            ),
          ),
        );
      },
    );
  }

  List<Widget> get _slides => const [
    OnboardingSlide(
      assetPath: AppAssets.onboardingConvenience,
      imageSemanticLabel: AppStrings.onboardingConvenienceSemanticLabel,
      eyebrow: AppStrings.onboardingConvenienceEyebrow,
      title: AppStrings.onboardingConvenienceTitle,
      body: AppStrings.onboardingConvenienceBody,
      imageAlignment: Alignment.bottomCenter,
    ),
    OnboardingSlide(
      assetPath: AppAssets.onboardingExpertise,
      imageSemanticLabel: AppStrings.onboardingExpertiseSemanticLabel,
      eyebrow: AppStrings.onboardingExpertiseEyebrow,
      title: AppStrings.onboardingExpertiseTitle,
      body: AppStrings.onboardingExpertiseBody,
      imageAlignment: Alignment.bottomCenter,
    ),
    OnboardingSlide(
      assetPath: AppAssets.onboardingTracking,
      imageSemanticLabel: AppStrings.onboardingTrackingSemanticLabel,
      eyebrow: AppStrings.onboardingTrackingEyebrow,
      title: AppStrings.onboardingTrackingTitle,
      body: AppStrings.onboardingTrackingBody,
      imageAlignment: Alignment.bottomCenter,
    ),
  ];

  DotsDecorator get _dotsDecorator => DotsDecorator(
    color: AppColors.dotInactive,
    activeColor: AppColors.aqua,
    size: Size.square(AppSizes.onboardingDot),
    activeSize: Size(AppSizes.onboardingActiveDotWidth, AppSizes.onboardingDot),
    spacing: EdgeInsets.symmetric(horizontal: AppSizes.onboardingDotSpacing),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.onboardingButton),
    ),
  );

  void _onStateChanged(BuildContext context, OnboardingState state) {
    final messenger = ScaffoldMessenger.of(context);

    if (state is OnboardingCompleted) {
      messenger.clearMaterialBanners();
      unawaited(onCompleted());
      return;
    }

    if (state is OnboardingFailure) {
      messenger
        ..clearMaterialBanners()
        ..showMaterialBanner(
          MaterialBanner(
            content: const Text(AppStrings.onboardingSaveFailed),
            actions: [
              TextButton(
                onPressed: () =>
                    unawaited(context.read<OnboardingCubit>().complete()),
                child: const Text(AppStrings.retry),
              ),
            ],
          ),
        );
      return;
    }

    messenger.clearMaterialBanners();
  }
}
