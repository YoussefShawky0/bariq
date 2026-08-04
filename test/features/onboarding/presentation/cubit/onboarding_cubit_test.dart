import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:bariq/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:bariq/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

void main() {
  late MockOnboardingRepository repository;
  late CompleteOnboarding useCase;

  setUp(() {
    repository = MockOnboardingRepository();
    useCase = CompleteOnboarding(repository);
  });

  blocTest<OnboardingCubit, OnboardingState>(
    'moves to the requested page',
    build: () => OnboardingCubit(useCase),
    act: (cubit) => cubit.showPage(1),
    expect: () => const [OnboardingState.viewing(currentPage: 1)],
  );

  blocTest<OnboardingCubit, OnboardingState>(
    'emits saving then completed when persistence succeeds',
    setUp: () {
      when(
        repository.completeOnboarding,
      ).thenAnswer((_) async => const Right(unit));
    },
    build: () => OnboardingCubit(useCase),
    act: (cubit) => cubit.complete(),
    expect: () => const [
      OnboardingState.saving(currentPage: 0),
      OnboardingState.completed(),
    ],
  );

  blocTest<OnboardingCubit, OnboardingState>(
    'emits saving then failure when persistence fails',
    setUp: () {
      when(
        repository.completeOnboarding,
      ).thenAnswer((_) async => const Left(CacheFailure()));
    },
    build: () => OnboardingCubit(useCase),
    seed: () => const OnboardingState.viewing(currentPage: 1),
    act: (cubit) => cubit.complete(),
    expect: () => const [
      OnboardingState.saving(currentPage: 1),
      OnboardingState.failure(currentPage: 1, failure: CacheFailure()),
    ],
  );
}
