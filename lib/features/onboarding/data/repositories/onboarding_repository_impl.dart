import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:bariq/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:fpdart/fpdart.dart';

final class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._localDataSource, this._logger);

  final OnboardingLocalDataSource _localDataSource;
  final AppLogger _logger;

  @override
  ResultFuture<Unit> completeOnboarding() async {
    try {
      await _localDataSource.completeOnboarding();
      return const Right(unit);
    } on CacheException catch (error, stackTrace) {
      _logger.error(
        'Failed to persist onboarding completion.',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(CacheFailure());
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Unexpected onboarding completion failure.',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(UnexpectedFailure());
    }
  }
}
