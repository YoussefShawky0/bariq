import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_local_data_source.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_session_data_source.dart';
import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/domain/repositories/app_startup_repository.dart';
import 'package:fpdart/fpdart.dart';

final class AppStartupRepositoryImpl implements AppStartupRepository {
  const AppStartupRepositoryImpl(
    this._localDataSource,
    this._sessionDataSource,
    this._logger,
  );

  final AppStartupLocalDataSource _localDataSource;
  final AppStartupSessionDataSource _sessionDataSource;
  final AppLogger _logger;

  @override
  ResultFuture<AppDestination> resolveInitialDestination() async {
    try {
      final onboardingCompleted = await _localDataSource
          .isOnboardingCompleted();
      if (!onboardingCompleted) {
        return const Right(AppDestination.onboarding);
      }

      final hasSession = _sessionDataSource.hasAuthenticatedSession();
      return Right(hasSession ? AppDestination.home : AppDestination.signIn);
    } on CacheException catch (error, stackTrace) {
      _logger.error(
        'Failed to resolve the local app startup state.',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(CacheFailure());
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Unexpected app startup failure.',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(UnexpectedFailure());
    }
  }
}
