import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/bootstrap/data/datasources/bootstrap_local_data_source.dart';
import 'package:bariq/features/bootstrap/domain/entities/app_destination.dart';
import 'package:bariq/features/bootstrap/domain/repositories/bootstrap_repository.dart';
import 'package:fpdart/fpdart.dart';

final class BootstrapRepositoryImpl implements BootstrapRepository {
  const BootstrapRepositoryImpl(this._localDataSource, this._logger);

  final BootstrapLocalDataSource _localDataSource;
  final AppLogger _logger;

  @override
  ResultFuture<AppDestination> resolveInitialDestination() async {
    try {
      final onboardingCompleted = await _localDataSource
          .isOnboardingCompleted();
      if (!onboardingCompleted) {
        return const Right(AppDestination.onboarding);
      }

      final hasSession = await _localDataSource.hasAuthenticatedSession();
      return Right(hasSession ? AppDestination.home : AppDestination.signIn);
    } on CacheException catch (error, stackTrace) {
      _logger.error(
        'Failed to resolve the local bootstrap state.',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(CacheFailure());
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Unexpected bootstrap failure.',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(UnexpectedFailure());
    }
  }
}
