import 'dart:async';
import 'dart:io';

import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/entities/auth_session_status.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource, this._logger);

  final AuthRemoteDataSource _remoteDataSource;
  final AppLogger _logger;

  @override
  ResultStream<AuthSessionStatus> watchSession() async* {
    try {
      await for (final authState in _remoteDataSource.watchSession()) {
        final status = switch (authState.event) {
          AuthChangeEvent.passwordRecovery =>
            AuthSessionStatus.passwordRecovery,
          _ when authState.session == null => AuthSessionStatus.unauthenticated,
          _ => AuthSessionStatus.authenticated,
        };
        yield Right(status);
      }
    } on Object catch (error, stackTrace) {
      _logSafeError('Auth session observation failed.', error, stackTrace);
      yield Left(_mapFailure(error));
    }
  }

  @override
  ResultFuture<AuthOutcome> signInWithEmail({
    required String email,
    required String password,
  }) => _guard(() async {
    final response = await _remoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
    if (response.session == null) {
      throw const AuthException('Authentication did not create a session.');
    }
    return AuthOutcome.authenticated;
  });

  @override
  ResultFuture<AuthOutcome> signUpWithEmail({
    required String email,
    required String password,
  }) => _guard(() async {
    final response = await _remoteDataSource.signUpWithEmail(
      email: email,
      password: password,
    );
    return response.session == null
        ? AuthOutcome.emailVerificationRequired
        : AuthOutcome.authenticated;
  });

  @override
  ResultFuture<AuthOutcome> requestPasswordReset(String email) =>
      _guard(() async {
        await _remoteDataSource.requestPasswordReset(email);
        return AuthOutcome.passwordResetRequested;
      });

  @override
  ResultFuture<AuthOutcome> updatePassword(String password) => _guard(() async {
    await _remoteDataSource.updatePassword(password);
    return AuthOutcome.authenticated;
  });

  @override
  ResultFuture<AuthOutcome> signInWithGoogle() => _guard(() async {
    final launched = await _remoteDataSource.signInWithGoogle();
    if (!launched) {
      throw const ExternalAuthLaunchException();
    }
    return AuthOutcome.externalProviderStarted;
  });

  ResultFuture<AuthOutcome> _guard(
    Future<AuthOutcome> Function() action,
  ) async {
    try {
      return Right(await action());
    } on Object catch (error, stackTrace) {
      _logSafeError(
        'Customer authentication action failed.',
        error,
        stackTrace,
      );
      return Left(_mapFailure(error));
    }
  }

  Failure _mapFailure(Object error) {
    if (error is BackendConfigurationException) {
      return const BackendConfigurationFailure();
    }
    if (error is SocketException || error is TimeoutException) {
      return const NetworkFailure();
    }
    if (error is ExternalAuthLaunchException) {
      return const AuthenticationFailure(
        code: 'OAUTH_LAUNCH_FAILED',
        message: 'تعذر فتح تسجيل الدخول بواسطة Google. حاول مرة أخرى.',
      );
    }
    if (error is AuthException) {
      return _mapAuthException(error);
    }
    return const UnexpectedFailure();
  }

  AuthenticationFailure _mapAuthException(AuthException error) {
    return switch (error.code) {
      'invalid_credentials' => const AuthenticationFailure(
        code: 'INVALID_CREDENTIALS',
        message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
      ),
      'email_not_confirmed' => const AuthenticationFailure(
        code: 'EMAIL_NOT_CONFIRMED',
        message: 'فعّل بريدك الإلكتروني أولًا ثم حاول مرة أخرى.',
      ),
      'weak_password' => const AuthenticationFailure(
        code: 'WEAK_PASSWORD',
        message: 'اختر كلمة مرور أقوى ثم حاول مرة أخرى.',
      ),
      'over_request_rate_limit' ||
      'over_email_send_rate_limit' => const AuthenticationFailure(
        code: 'RATE_LIMITED',
        message: 'محاولات كثيرة. انتظر قليلًا ثم حاول مرة أخرى.',
      ),
      _ => const AuthenticationFailure(
        code: 'AUTHENTICATION_FAILED',
        message: 'تعذر إكمال تسجيل الدخول. راجع البيانات وحاول مرة أخرى.',
      ),
    };
  }

  void _logSafeError(String message, Object error, StackTrace stackTrace) {
    _logger.error(message, error: error.runtimeType, stackTrace: stackTrace);
  }
}
