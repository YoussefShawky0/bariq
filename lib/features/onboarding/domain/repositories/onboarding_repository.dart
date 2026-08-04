import 'package:bariq/core/errors/result.dart';
import 'package:fpdart/fpdart.dart';

/// Persists the customer's onboarding decision.
abstract interface class OnboardingRepository {
  /// Marks onboarding as completed for future application launches.
  ResultFuture<Unit> completeOnboarding();
}
