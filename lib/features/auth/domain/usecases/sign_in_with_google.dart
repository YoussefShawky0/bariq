import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/auth/domain/entities/auth_outcome.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';

/// Starts the configured Google OAuth flow.
final class SignInWithGoogle {
  const SignInWithGoogle(this._repository);

  final AuthRepository _repository;

  /// Opens the provider authentication page.
  ResultFuture<AuthOutcome> call() => _repository.signInWithGoogle();
}
