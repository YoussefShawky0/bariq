import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bariq/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/entities/auth_session_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAppLogger extends Mock implements AppLogger {}

void main() {
  late MockAuthRemoteDataSource remoteDataSource;
  late MockAppLogger logger;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    logger = MockAppLogger();
    repository = AuthRepositoryImpl(remoteDataSource, logger);
  });

  test('maps signup without a session to email verification', () async {
    when(
      () => remoteDataSource.signUpWithEmail(
        email: 'customer@example.com',
        password: 'password1',
      ),
    ).thenAnswer((_) async => AuthResponse());

    final result = await repository.signUpWithEmail(
      email: 'customer@example.com',
      password: 'password1',
    );

    expect(
      result.getRight().toNullable(),
      AuthOutcome.emailVerificationRequired,
    );
  });

  test('maps provider invalid credentials to a safe failure', () async {
    when(
      () => remoteDataSource.signInWithEmail(
        email: 'customer@example.com',
        password: 'password1',
      ),
    ).thenThrow(
      const AuthException('Provider detail', code: 'invalid_credentials'),
    );
    when(
      () => logger.error(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    final result = await repository.signInWithEmail(
      email: 'customer@example.com',
      password: 'password1',
    );
    final failure = result.getLeft().toNullable();

    expect(failure, isA<AuthenticationFailure>());
    expect(failure?.code, 'INVALID_CREDENTIALS');
    expect(failure?.message, isNot(contains('Provider detail')));
  });

  test('maps a failed OAuth launch to a safe failure', () async {
    when(remoteDataSource.signInWithGoogle).thenAnswer((_) async => false);
    when(
      () => logger.error(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    final result = await repository.signInWithGoogle();

    expect(result.getLeft().toNullable()?.code, 'OAUTH_LAUNCH_FAILED');
  });

  test('maps provider auth state to the domain session state', () async {
    when(remoteDataSource.watchSession).thenAnswer(
      (_) =>
          Stream.value(const AuthState(AuthChangeEvent.initialSession, null)),
    );

    final result = await repository.watchSession().first;

    expect(result.getRight().toNullable(), AuthSessionStatus.unauthenticated);
  });

  test('preserves the password-recovery auth event', () async {
    when(remoteDataSource.watchSession).thenAnswer(
      (_) =>
          Stream.value(const AuthState(AuthChangeEvent.passwordRecovery, null)),
    );

    final result = await repository.watchSession().first;

    expect(result.getRight().toNullable(), AuthSessionStatus.passwordRecovery);
  });
}
