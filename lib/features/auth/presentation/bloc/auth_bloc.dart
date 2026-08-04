import 'dart:async';

import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/auth/domain/entities/auth_mode.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/entities/auth_session_status.dart';
import 'package:bariq/features/auth/domain/usecases/request_password_reset.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:bariq/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:bariq/features/auth/domain/usecases/update_password.dart';
import 'package:bariq/features/auth/domain/usecases/watch_auth_session.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._signInWithEmail,
    this._signUpWithEmail,
    this._requestPasswordReset,
    this._updatePassword,
    this._signInWithGoogle,
    this._watchAuthSession,
  ) : super(const AuthState.ready(AuthMode.signIn)) {
    on<AuthModeChanged>(_onModeChanged);
    on<AuthCredentialsSubmitted>(_onCredentialsSubmitted);
    on<AuthPasswordResetRequested>(_onPasswordResetRequested);
    on<AuthPasswordUpdateSubmitted>(_onPasswordUpdateSubmitted);
    on<AuthGoogleSubmitted>(_onGoogleSubmitted);
    on<AuthSessionChanged>(_onSessionChanged);
    _sessionSubscription = _watchAuthSession().listen(
      (result) => add(AuthEvent.sessionChanged(result)),
    );
  }

  final SignInWithEmail _signInWithEmail;
  final SignUpWithEmail _signUpWithEmail;
  final RequestPasswordReset _requestPasswordReset;
  final UpdatePassword _updatePassword;
  final SignInWithGoogle _signInWithGoogle;
  final WatchAuthSession _watchAuthSession;
  late final StreamSubscription<Either<Failure, AuthSessionStatus>>
  _sessionSubscription;

  AuthMode get _mode => state.maybeWhen(
    ready: (mode) => mode,
    submitting: (mode) => mode,
    oauthPending: (mode) => mode,
    failure: (mode, _) => mode,
    orElse: () => AuthMode.signIn,
  );

  void _onModeChanged(AuthModeChanged event, Emitter<AuthState> emit) {
    emit(AuthState.ready(event.mode));
  }

  Future<void> _onCredentialsSubmitted(
    AuthCredentialsSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final mode = _mode;
    emit(AuthState.submitting(mode));
    final result = mode == AuthMode.signIn
        ? await _signInWithEmail(email: event.email, password: event.password)
        : await _signUpWithEmail(
            email: event.email,
            password: event.password,
            passwordConfirmation: event.passwordConfirmation,
          );
    result.match(
      (failure) => emit(AuthState.failure(mode, failure)),
      (outcome) => _emitOutcome(outcome, mode, event.email.trim(), emit),
    );
  }

  Future<void> _onPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.submitting(AuthMode.signIn));
    final result = await _requestPasswordReset(event.email);
    result.match(
      (failure) => emit(AuthState.failure(AuthMode.signIn, failure)),
      (_) => emit(AuthState.passwordResetSent(event.email.trim())),
    );
  }

  Future<void> _onGoogleSubmitted(
    AuthGoogleSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final mode = _mode;
    emit(AuthState.submitting(mode));
    final result = await _signInWithGoogle();
    result.match(
      (failure) => emit(AuthState.failure(mode, failure)),
      (_) => emit(AuthState.oauthPending(mode)),
    );
  }

  Future<void> _onPasswordUpdateSubmitted(
    AuthPasswordUpdateSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.passwordUpdating());
    final result = await _updatePassword(
      password: event.password,
      passwordConfirmation: event.passwordConfirmation,
    );
    result.match(
      (failure) => emit(AuthState.passwordUpdateFailure(failure)),
      (_) => emit(const AuthState.authenticated()),
    );
  }

  void _onSessionChanged(AuthSessionChanged event, Emitter<AuthState> emit) {
    event.result.match((failure) => emit(AuthState.failure(_mode, failure)), (
      status,
    ) {
      if (status == AuthSessionStatus.authenticated) {
        emit(const AuthState.authenticated());
      } else if (status == AuthSessionStatus.passwordRecovery) {
        emit(const AuthState.passwordRecovery());
      }
    });
  }

  void _emitOutcome(
    AuthOutcome outcome,
    AuthMode mode,
    String email,
    Emitter<AuthState> emit,
  ) {
    switch (outcome) {
      case AuthOutcome.authenticated:
        emit(const AuthState.authenticated());
      case AuthOutcome.emailVerificationRequired:
        emit(AuthState.emailVerificationRequired(email));
      case AuthOutcome.passwordResetRequested:
        emit(AuthState.passwordResetSent(email));
      case AuthOutcome.externalProviderStarted:
        emit(AuthState.oauthPending(mode));
    }
  }

  @override
  Future<void> close() async {
    await _sessionSubscription.cancel();
    return super.close();
  }
}

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.modeChanged(AuthMode mode) = AuthModeChanged;
  const factory AuthEvent.credentialsSubmitted({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) = AuthCredentialsSubmitted;
  const factory AuthEvent.passwordResetRequested(String email) =
      AuthPasswordResetRequested;
  const factory AuthEvent.passwordUpdateSubmitted({
    required String password,
    required String passwordConfirmation,
  }) = AuthPasswordUpdateSubmitted;
  const factory AuthEvent.googleSubmitted() = AuthGoogleSubmitted;
  const factory AuthEvent.sessionChanged(
    Either<Failure, AuthSessionStatus> result,
  ) = AuthSessionChanged;
}

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.ready(AuthMode mode) = AuthReady;
  const factory AuthState.submitting(AuthMode mode) = AuthSubmitting;
  const factory AuthState.emailVerificationRequired(String email) =
      AuthEmailVerificationRequired;
  const factory AuthState.passwordResetSent(String email) =
      AuthPasswordResetSent;
  const factory AuthState.passwordRecovery() = AuthPasswordRecovery;
  const factory AuthState.passwordUpdating() = AuthPasswordUpdating;
  const factory AuthState.passwordUpdateFailure(Failure failure) =
      AuthPasswordUpdateFailure;
  const factory AuthState.oauthPending(AuthMode mode) = AuthOauthPending;
  const factory AuthState.authenticated() = AuthAuthenticated;
  const factory AuthState.failure(AuthMode mode, Failure failure) = AuthFailure;
}
