import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_cubit.freezed.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._completeOnboarding)
    : super(const OnboardingState.viewing(currentPage: 0));

  final CompleteOnboarding _completeOnboarding;

  void showPage(int page) {
    emit(OnboardingState.viewing(currentPage: page));
  }

  Future<void> complete() async {
    final currentPage = state.currentPage;
    emit(OnboardingState.saving(currentPage: currentPage));
    final result = await _completeOnboarding();
    result.match(
      (failure) => emit(
        OnboardingState.failure(currentPage: currentPage, failure: failure),
      ),
      (_) => emit(const OnboardingState.completed()),
    );
  }
}

@freezed
sealed class OnboardingState with _$OnboardingState {
  const OnboardingState._();

  const factory OnboardingState.viewing({required int currentPage}) =
      OnboardingViewing;
  const factory OnboardingState.saving({required int currentPage}) =
      OnboardingSaving;
  const factory OnboardingState.completed() = OnboardingCompleted;
  const factory OnboardingState.failure({
    required int currentPage,
    required Failure failure,
  }) = OnboardingFailure;

  int get currentPage => maybeWhen(
    viewing: (currentPage) => currentPage,
    saving: (currentPage) => currentPage,
    failure: (currentPage, _) => currentPage,
    orElse: () => 0,
  );
}
