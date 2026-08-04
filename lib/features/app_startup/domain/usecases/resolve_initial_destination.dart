import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/domain/repositories/app_startup_repository.dart';

/// Resolves the first application destination during app startup.
final class ResolveInitialDestination {
  const ResolveInitialDestination(this._repository);

  final AppStartupRepository _repository;

  /// Returns the destination selected from the persisted application state.
  ResultFuture<AppDestination> call() {
    return _repository.resolveInitialDestination();
  }
}
