import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/entities/auth_session_status.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:bariq/features/auth/domain/usecases/request_password_reset.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:bariq/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/update_password.dart';
import 'package:bariq/features/auth/domain/usecases/watch_auth_session.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;

  setUp(() => repository = MockAuthRepository());

  group('SignInWithEmail', () {
    test('rejects invalid input before reaching the repository', () async {
      final useCase = SignInWithEmail(repository);

      final result = await useCase(email: 'invalid', password: '123');

      expect(result.getLeft().toNullable(), isA<ValidationFailure>());
      verifyNever(
        () => repository.signInWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
    });

    test('normalizes email and delegates valid credentials', () async {
      when(
        () => repository.signInWithEmail(
          email: 'customer@example.com',
          password: 'password1',
        ),
      ).thenAnswer((_) async => const Right(AuthOutcome.authenticated));
      final useCase = SignInWithEmail(repository);

      final result = await useCase(
        email: ' customer@example.com ',
        password: 'password1',
      );

      expect(result.getRight().toNullable(), AuthOutcome.authenticated);
    });
  });

  group('SignUpWithEmail', () {
    test('rejects a mismatched password confirmation', () async {
      final useCase = SignUpWithEmail(repository);

      final result = await useCase(
        email: 'customer@example.com',
        password: 'password1',
        passwordConfirmation: 'password2',
      );

      expect(result.getLeft().toNullable(), isA<ValidationFailure>());
      verifyNever(
        () => repository.signUpWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
    });

    test('delegates valid signup credentials', () async {
      when(
        () => repository.signUpWithEmail(
          email: 'customer@example.com',
          password: 'password1',
        ),
      ).thenAnswer(
        (_) async => const Right(AuthOutcome.emailVerificationRequired),
      );
      final useCase = SignUpWithEmail(repository);

      final result = await useCase(
        email: 'customer@example.com',
        password: 'password1',
        passwordConfirmation: 'password1',
      );

      expect(
        result.getRight().toNullable(),
        AuthOutcome.emailVerificationRequired,
      );
    });
  });

  test('RequestPasswordReset validates and delegates the email', () async {
    when(
      () => repository.requestPasswordReset('customer@example.com'),
    ).thenAnswer((_) async => const Right(AuthOutcome.passwordResetRequested));
    final useCase = RequestPasswordReset(repository);

    final result = await useCase(' customer@example.com ');

    expect(result.getRight().toNullable(), AuthOutcome.passwordResetRequested);
  });

  test('SignInWithGoogle delegates to the repository', () async {
    when(
      repository.signInWithGoogle,
    ).thenAnswer((_) async => const Right(AuthOutcome.externalProviderStarted));

    final result = await SignInWithGoogle(repository)();

    expect(result.getRight().toNullable(), AuthOutcome.externalProviderStarted);
  });

  test('UpdatePassword validates confirmation and delegates', () async {
    when(
      () => repository.updatePassword('newPassword1'),
    ).thenAnswer((_) async => const Right(AuthOutcome.authenticated));

    final result = await UpdatePassword(repository)(
      password: 'newPassword1',
      passwordConfirmation: 'newPassword1',
    );

    expect(result.getRight().toNullable(), AuthOutcome.authenticated);
  });

  test('WatchAuthSession exposes the repository stream', () async {
    when(repository.watchSession).thenAnswer(
      (_) => Stream.value(const Right(AuthSessionStatus.authenticated)),
    );

    final result = await WatchAuthSession(repository)().first;

    expect(result.getRight().toNullable(), AuthSessionStatus.authenticated);
  });
}
