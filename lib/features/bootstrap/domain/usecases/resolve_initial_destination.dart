import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/bootstrap/domain/entities/app_destination.dart';
import 'package:bariq/features/bootstrap/domain/repositories/bootstrap_repository.dart';

/// Resolves the first application destination during bootstrap.
final class ResolveInitialDestination {
  const ResolveInitialDestination(this._repository);

  final BootstrapRepository _repository;

  /// Returns the destination selected from the persisted application state.
  ResultFuture<AppDestination> call() {
    return _repository.resolveInitialDestination();
  }
}
