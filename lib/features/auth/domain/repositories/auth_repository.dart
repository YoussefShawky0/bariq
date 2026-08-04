import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/entities/auth_session_status.dart';

/// Contract for customer authentication operations.
abstract interface class AuthRepository {
  /// Emits safe session states without exposing provider tokens to presentation.
  ResultStream<AuthSessionStatus> watchSession();

  /// Authenticates an existing customer with email and password.
  ResultFuture<AuthOutcome> signInWithEmail({
    required String email,
    required String password,
  });

  /// Creates a customer account with email confirmation enabled.
  ResultFuture<AuthOutcome> signUpWithEmail({
    required String email,
    required String password,
  });

  /// Requests a password-reset email without exposing account existence.
  ResultFuture<AuthOutcome> requestPasswordReset(String email);

  /// Replaces the password for an active recovery session.
  ResultFuture<AuthOutcome> updatePassword(String password);

  /// Starts Google OAuth in the system browser.
  ResultFuture<AuthOutcome> signInWithGoogle();
}
