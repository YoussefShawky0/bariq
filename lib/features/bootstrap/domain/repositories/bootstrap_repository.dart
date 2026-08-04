import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/bootstrap/domain/entities/app_destination.dart';

/// Provides the persisted state required to choose the initial destination.
abstract interface class BootstrapRepository {
  /// Resolves the first destination without exposing storage details.
  ResultFuture<AppDestination> resolveInitialDestination();
}
