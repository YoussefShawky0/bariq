import 'dart:async';
import 'dart:io';

import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:bariq/features/profile/data/models/profile_update_model.dart';
import 'package:bariq/features/profile/domain/entities/customer_profile.dart';
import 'package:bariq/features/profile/domain/entities/profile_input.dart';
import 'package:bariq/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remoteDataSource, this._logger);

  final ProfileRemoteDataSource _remoteDataSource;
  final AppLogger _logger;

  @override
  ResultFuture<CustomerProfile> loadCurrentProfile() => _guard(
    () async => (await _remoteDataSource.loadCurrentProfile()).toEntity(),
  );

  @override
  ResultFuture<CustomerProfile> saveCurrentProfile(ProfileInput input) =>
      _guard(() async {
        final current = await _remoteDataSource.loadCurrentProfile();
        final update = ProfileUpdateModel.fromInput(
          id: current.id,
          input: input,
          existingAvatarPath: current.avatarPath,
        );
        final saved = await _remoteDataSource.saveCurrentProfile(
          update: update,
          avatar: input.avatar,
        );
        return saved.toEntity();
      });

  ResultFuture<CustomerProfile> _guard(
    Future<CustomerProfile> Function() action,
  ) async {
    try {
      return Right(await action());
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Customer profile operation failed.',
        error: error.runtimeType,
        stackTrace: stackTrace,
      );
      return Left(_mapFailure(error));
    }
  }

  Failure _mapFailure(Object error) {
    if (error is BackendConfigurationException) {
      return const BackendConfigurationFailure();
    }
    if (error is UnauthenticatedException || error is AuthException) {
      return const AuthenticationFailure(
        code: 'SESSION_REQUIRED',
        message: 'انتهت جلسة الدخول. سجّل دخولك مرة أخرى.',
      );
    }
    if (error is SocketException || error is TimeoutException) {
      return const NetworkFailure();
    }
    if (error is PostgrestException || error is StorageException) {
      return const BackendFailure();
    }
    return const UnexpectedFailure();
  }
}
