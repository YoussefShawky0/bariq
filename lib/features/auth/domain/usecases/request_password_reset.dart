import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';
import 'package:bariq/features/auth/domain/usecases/auth_input_validator.dart';
import 'package:fpdart/fpdart.dart';

/// Requests a password-reset email for a validated address.
final class RequestPasswordReset {
  const RequestPasswordReset(this._repository);

  final AuthRepository _repository;

  /// Executes the reset request.
  ResultFuture<AuthOutcome> call(String email) async {
    final normalizedEmail = email.trim();
    final failure = AuthInputValidator.validateEmail(normalizedEmail);
    if (failure != null) {
      return Left(failure);
    }
    return _repository.requestPasswordReset(normalizedEmail);
  }
}
