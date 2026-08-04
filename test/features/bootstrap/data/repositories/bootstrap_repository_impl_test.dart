import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/bootstrap/data/datasources/bootstrap_local_data_source.dart';
import 'package:bariq/features/bootstrap/data/repositories/bootstrap_repository_impl.dart';
import 'package:bariq/features/bootstrap/domain/entities/app_destination.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockBootstrapLocalDataSource extends Mock
    implements BootstrapLocalDataSource {}

void main() {
  late MockBootstrapLocalDataSource localDataSource;
  late BootstrapRepositoryImpl repository;

  setUp(() {
    localDataSource = MockBootstrapLocalDataSource();
    repository = BootstrapRepositoryImpl(
      localDataSource,
      AppLogger(Logger(level: Level.off)),
    );
  });

  test('returns onboarding when onboarding is incomplete', () async {
    when(localDataSource.isOnboardingCompleted).thenAnswer((_) async => false);

    final result = await repository.resolveInitialDestination();

    expect(
      result,
      const Right<Failure, AppDestination>(AppDestination.onboarding),
    );
    verifyNever(localDataSource.hasAuthenticatedSession);
  });

  test(
    'returns sign in when onboarding is complete without a session',
    () async {
      when(localDataSource.isOnboardingCompleted).thenAnswer((_) async => true);
      when(
        localDataSource.hasAuthenticatedSession,
      ).thenAnswer((_) async => false);

      final result = await repository.resolveInitialDestination();

      expect(
        result,
        const Right<Failure, AppDestination>(AppDestination.signIn),
      );
    },
  );

  test('returns home when onboarding and session are available', () async {
    when(localDataSource.isOnboardingCompleted).thenAnswer((_) async => true);
    when(localDataSource.hasAuthenticatedSession).thenAnswer((_) async => true);

    final result = await repository.resolveInitialDestination();

    expect(result, const Right<Failure, AppDestination>(AppDestination.home));
  });

  test('maps cache exceptions to CacheFailure', () async {
    when(
      localDataSource.isOnboardingCompleted,
    ).thenThrow(const CacheException('storage error'));

    final result = await repository.resolveInitialDestination();

    expect(result.isLeft(), isTrue);
    expect(result.getLeft().toNullable(), isA<CacheFailure>());
  });
}
