import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/auth/domain/entities/auth_mode.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/entities/auth_session_status.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:bariq/features/auth/domain/usecases/request_password_reset.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:bariq/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/update_password.dart';
import 'package:bariq/features/auth/domain/usecases/watch_auth_session.dart';
import 'package:bariq/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;

  AuthBloc buildBloc() => AuthBloc(
    SignInWithEmail(repository),
    SignUpWithEmail(repository),
    RequestPasswordReset(repository),
    UpdatePassword(repository),
    SignInWithGoogle(repository),
    WatchAuthSession(repository),
  );

  setUp(() {
    repository = MockAuthRepository();
    when(repository.watchSession).thenAnswer((_) => const Stream.empty());
  });

  blocTest<AuthBloc, AuthState>(
    'switches between sign-in and sign-up modes',
    build: buildBloc,
    act: (bloc) => bloc.add(const AuthEvent.modeChanged(AuthMode.signUp)),
    expect: () => [const AuthState.ready(AuthMode.signUp)],
  );

  blocTest<AuthBloc, AuthState>(
    'emits submitting then authenticated for valid sign in',
    setUp: () {
      when(
        () => repository.signInWithEmail(
          email: 'customer@example.com',
          password: 'password1',
        ),
      ).thenAnswer((_) async => const Right(AuthOutcome.authenticated));
    },
    build: buildBloc,
    act: (bloc) => bloc.add(
      const AuthEvent.credentialsSubmitted(
        email: 'customer@example.com',
        password: 'password1',
        passwordConfirmation: '',
      ),
    ),
    expect: () => const [
      AuthState.submitting(AuthMode.signIn),
      AuthState.authenticated(),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits a single failure phase after invalid credentials',
    setUp: () {
      when(
        () => repository.signInWithEmail(
          email: 'customer@example.com',
          password: 'password1',
        ),
      ).thenAnswer(
        (_) async => const Left(
          AuthenticationFailure(
            code: 'INVALID_CREDENTIALS',
            message: 'بيانات غير صحيحة',
          ),
        ),
      );
    },
    build: buildBloc,
    act: (bloc) => bloc.add(
      const AuthEvent.credentialsSubmitted(
        email: 'customer@example.com',
        password: 'password1',
        passwordConfirmation: '',
      ),
    ),
    expect: () => const [
      AuthState.submitting(AuthMode.signIn),
      AuthState.failure(
        AuthMode.signIn,
        AuthenticationFailure(
          code: 'INVALID_CREDENTIALS',
          message: 'بيانات غير صحيحة',
        ),
      ),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits password-reset confirmation without exposing account existence',
    setUp: () {
      when(
        () => repository.requestPasswordReset('customer@example.com'),
      ).thenAnswer(
        (_) async => const Right(AuthOutcome.passwordResetRequested),
      );
    },
    build: buildBloc,
    act: (bloc) => bloc.add(
      const AuthEvent.passwordResetRequested('customer@example.com'),
    ),
    expect: () => const [
      AuthState.submitting(AuthMode.signIn),
      AuthState.passwordResetSent('customer@example.com'),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits OAuth pending after the system browser opens',
    setUp: () {
      when(repository.signInWithGoogle).thenAnswer(
        (_) async => const Right(AuthOutcome.externalProviderStarted),
      );
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const AuthEvent.googleSubmitted()),
    expect: () => const [
      AuthState.submitting(AuthMode.signIn),
      AuthState.oauthPending(AuthMode.signIn),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'shows recovery then authenticates after updating the password',
    setUp: () {
      when(
        () => repository.updatePassword('newPassword1'),
      ).thenAnswer((_) async => const Right(AuthOutcome.authenticated));
    },
    build: buildBloc,
    act: (bloc) async {
      bloc
        ..add(
          const AuthEvent.sessionChanged(
            Right(AuthSessionStatus.passwordRecovery),
          ),
        )
        ..add(
          const AuthEvent.passwordUpdateSubmitted(
            password: 'newPassword1',
            passwordConfirmation: 'newPassword1',
          ),
        );
    },
    expect: () => const [
      AuthState.passwordRecovery(),
      AuthState.passwordUpdating(),
      AuthState.authenticated(),
    ],
  );
}
