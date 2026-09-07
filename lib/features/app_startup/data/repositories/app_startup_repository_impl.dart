import 'dart:async';
import 'dart:io';

import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_local_data_source.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_profile_data_source.dart';
import 'package:bariq/features/app_startup/data/datasources/app_startup_session_data_source.dart';
import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/domain/repositories/app_startup_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AppStartupRepositoryImpl implements AppStartupRepository {
  const AppStartupRepositoryImpl(
    this._localDataSource,
    this._sessionDataSource,
    this._profileDataSource,
    this._logger,
  );

  final AppStartupLocalDataSource _localDataSource;
  final AppStartupSessionDataSource _sessionDataSource;
  final AppStartupProfileDataSource _profileDataSource;
  final AppLogger _logger;

  @override
  ResultFuture<AppDestination> resolveInitialDestination() async {
    try {
      final onboardingCompleted = await _localDataSource
          .isOnboardingCompleted();
      if (!onboardingCompleted) {
        return const Right(AppDestination.onboarding);
      }

      final userId = _sessionDataSource.currentUserId();
      if (userId == null) {
        return const Right(AppDestination.signIn);
      }

      final profileComplete = await _profileDataSource.hasCompletedProfile(
        userId,
      );
      return Right(
        profileComplete
            ? AppDestination.home
            : AppDestination.profileCompletion,
      );
    } on CacheException catch (error, stackTrace) {
      _logger.error(
        'Failed to resolve the local app startup state.',
        error: error,
        stackTrace: stackTrace,
      );
      return const Left(CacheFailure());
    } on SocketException catch (error, stackTrace) {
      _logger.error(
        'Network failure while resolving app startup.',
        error: error.runtimeType,
        stackTrace: stackTrace,
      );
      return const Left(NetworkFailure());
    } on TimeoutException catch (error, stackTrace) {
      _logger.error(
        'Timeout while resolving app startup.',
        error: error.runtimeType,
        stackTrace: stackTrace,
      );
      return const Left(NetworkFailure());
    } on PostgrestException catch (error, stackTrace) {
      _logger.error(
        'Profile gate query failed during app startup.',
        error: error.runtimeType,
        stackTrace: stackTrace,
      );
      return const Left(BackendFailure());
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
