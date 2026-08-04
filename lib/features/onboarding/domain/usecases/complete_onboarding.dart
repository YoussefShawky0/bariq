import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Completes onboarding without exposing persistence details to presentation.
final class CompleteOnboarding {
  const CompleteOnboarding(this._repository);

  final OnboardingRepository _repository;

  /// Persists completion so bootstrap can resolve the sign-in destination.
  ResultFuture<Unit> call() {
    return _repository.completeOnboarding();
  }
}
