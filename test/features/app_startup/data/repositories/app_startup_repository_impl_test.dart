import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_local_data_source.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_profile_data_source.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_session_data_source.dart';
import 'package:bariq/features/app_startup/data/repositories/app_startup_repository_impl.dart';
import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

class MockAppStartupLocalDataSource extends Mock
    implements AppStartupLocalDataSource {}

class MockAppStartupSessionDataSource extends Mock
    implements AppStartupSessionDataSource {}

class MockAppStartupProfileDataSource extends Mock
    implements AppStartupProfileDataSource {}

void main() {
  late MockAppStartupLocalDataSource localDataSource;
  late MockAppStartupSessionDataSource sessionDataSource;
  late MockAppStartupProfileDataSource profileDataSource;
  late AppStartupRepositoryImpl repository;

  setUp(() {
    localDataSource = MockAppStartupLocalDataSource();
    sessionDataSource = MockAppStartupSessionDataSource();
    profileDataSource = MockAppStartupProfileDataSource();
    repository = AppStartupRepositoryImpl(
      localDataSource,
      sessionDataSource,
      profileDataSource,
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
    verifyNever(sessionDataSource.currentUserId);
    verifyNever(() => profileDataSource.hasCompletedProfile(any()));
  });

  test(
    'returns sign in when onboarding is complete without a session',
    () async {
      when(localDataSource.isOnboardingCompleted).thenAnswer((_) async => true);
      when(sessionDataSource.currentUserId).thenReturn(null);

      final result = await repository.resolveInitialDestination();

      expect(
        result,
        const Right<Failure, AppDestination>(AppDestination.signIn),
      );
    },
  );

  test('returns profile completion for an incomplete customer', () async {
    when(localDataSource.isOnboardingCompleted).thenAnswer((_) async => true);
    when(sessionDataSource.currentUserId).thenReturn('customer-id');
    when(
      () => profileDataSource.hasCompletedProfile('customer-id'),
    ).thenAnswer((_) async => false);

    final result = await repository.resolveInitialDestination();

    expect(
      result,
      const Right<Failure, AppDestination>(AppDestination.profileCompletion),
    );
  });

  test(
    'returns home when session and completed profile are available',
    () async {
      when(localDataSource.isOnboardingCompleted).thenAnswer((_) async => true);
      when(sessionDataSource.currentUserId).thenReturn('customer-id');
      when(
        () => profileDataSource.hasCompletedProfile('customer-id'),
      ).thenAnswer((_) async => true);

      final result = await repository.resolveInitialDestination();

      expect(result, const Right<Failure, AppDestination>(AppDestination.home));
    },
  );

  test('maps cache exceptions to CacheFailure', () async {
    when(
      localDataSource.isOnboardingCompleted,
    ).thenThrow(const CacheException('storage error'));

    final result = await repository.resolveInitialDestination();

    expect(result.isLeft(), isTrue);
    expect(result.getLeft().toNullable(), isA<CacheFailure>());
  });
}
