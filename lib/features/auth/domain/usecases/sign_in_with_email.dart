import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:bariq/features/auth/domain/usecases/auth_input_validator.dart';
import 'package:fpdart/fpdart.dart';

/// Authenticates an existing customer after validating credentials.
final class SignInWithEmail {
  const SignInWithEmail(this._repository);

  final AuthRepository _repository;

  /// Executes email/password sign in.
  ResultFuture<AuthOutcome> call({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim();
    final emailFailure = AuthInputValidator.validateEmail(normalizedEmail);
    if (emailFailure != null) {
      return Left(emailFailure);
    }
    final passwordFailure = AuthInputValidator.validatePassword(password);
    if (passwordFailure != null) {
      return Left(passwordFailure);
    }
    return _repository.signInWithEmail(
      email: normalizedEmail,
      password: password,
    );
  }
}
