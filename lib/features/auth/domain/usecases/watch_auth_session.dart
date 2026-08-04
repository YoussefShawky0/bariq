import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/auth/domain/entities/auth_session_status.dart';
import 'package:bariq/features/auth/domain/repositories/auth_repository.dart';

/// Observes provider session transitions for OAuth callbacks and sign-out.
final class WatchAuthSession {
  const WatchAuthSession(this._repository);

  final AuthRepository _repository;

  /// Returns the safe customer session stream.
  ResultStream<AuthSessionStatus> call() => _repository.watchSession();
}
