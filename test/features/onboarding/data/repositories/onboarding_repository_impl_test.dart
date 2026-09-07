import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:bariq/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDataSource extends Mock
    implements OnboardingLocalDataSource {}

class MockAppLogger extends Mock implements AppLogger {}

void main() {
  late MockOnboardingLocalDataSource localDataSource;
  late OnboardingRepositoryImpl repository;

  setUp(() {
    localDataSource = MockOnboardingLocalDataSource();
    repository = OnboardingRepositoryImpl(localDataSource, MockAppLogger());
  });

  test('returns unit when local persistence succeeds', () async {
    when(localDataSource.completeOnboarding).thenAnswer((_) async {});

    final result = await repository.completeOnboarding();

    expect(result, const Right<Failure, Unit>(unit));
  });

  test('maps CacheException to CacheFailure', () async {
    when(
      localDataSource.completeOnboarding,
    ).thenThrow(const CacheException('write failed'));

    final result = await repository.completeOnboarding();

    expect(result, const Left<Failure, Unit>(CacheFailure()));
  });

  test('maps unexpected exceptions to UnexpectedFailure', () async {
    when(
      localDataSource.completeOnboarding,
    ).thenThrow(StateError('unexpected'));

    final result = await repository.completeOnboarding();

    expect(result, const Left<Failure, Unit>(UnexpectedFailure()));
  });
}
