import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:bariq/features/auth/domain/usecases/auth_input_validator.dart';
import 'package:fpdart/fpdart.dart';

/// Replaces the password for the active recovery session.
final class UpdatePassword {
  const UpdatePassword(this._repository);

  final AuthRepository _repository;

  /// Validates and submits the replacement password.
  ResultFuture<AuthOutcome> call({
    required String password,
    required String passwordConfirmation,
  }) async {
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
    return _repository.updatePassword(password);
  }
}
