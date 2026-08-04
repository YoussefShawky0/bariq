import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:bariq/features/auth/domain/usecases/auth_input_validator.dart';
import 'package:fpdart/fpdart.dart';

/// Creates a customer account after validating all credentials.
final class SignUpWithEmail {
  const SignUpWithEmail(this._repository);

  final AuthRepository _repository;

  /// Executes email/password sign up.
  ResultFuture<AuthOutcome> call({
    required String email,
    required String password,
    required String passwordConfirmation,
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
    final confirmationFailure = AuthInputValidator.validatePasswordConfirmation(
      password,
      passwordConfirmation,
    );
    if (confirmationFailure != null) {
      return Left(confirmationFailure);
    }
    return _repository.signUpWithEmail(
      email: normalizedEmail,
      password: password,
    );
  }
}
