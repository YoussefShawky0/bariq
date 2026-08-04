import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:bariq/features/onboarding/domain/usecases/complete_onboarding.dart';
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

  test('returns success from the repository', () async {
    when(
      repository.completeOnboarding,
    ).thenAnswer((_) async => const Right(unit));

    final result = await useCase();

    expect(result, const Right<Failure, Unit>(unit));
    verify(repository.completeOnboarding).called(1);
  });

  test('returns failure from the repository', () async {
    when(
      repository.completeOnboarding,
    ).thenAnswer((_) async => const Left(CacheFailure()));

    final result = await useCase();

    expect(result, const Left<Failure, Unit>(CacheFailure()));
  });
}
