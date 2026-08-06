import 'dart:async';
import 'dart:io';

import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/vehicles/data/datasources/vehicle_remote_data_source.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle_input.dart';
import 'package:bariq/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class VehicleRepositoryImpl implements VehicleRepository {
  const VehicleRepositoryImpl(this._remoteDataSource, this._logger);

  final VehicleRemoteDataSource _remoteDataSource;
  final AppLogger _logger;

  @override
  ResultFuture<List<Vehicle>> loadVehicles() => _guard(
    () async => (await _remoteDataSource.loadVehicles())
        .map((model) => model.toEntity())
        .toList(growable: false),
  );

  @override
  ResultFuture<Vehicle> saveVehicle(VehicleInput input) => _guard(
    () async => (await _remoteDataSource.saveVehicle(input)).toEntity(),
  );

  @override
  ResultFuture<Unit> deleteVehicle(String id) => _guard(() async {
    await _remoteDataSource.deleteVehicle(id);
    return unit;
  });

  ResultFuture<T> _guard<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Customer vehicle operation failed.',
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
    if (error is PostgrestException && error.code == '23505') {
      return const ValidationFailure(
        code: 'DUPLICATE_VEHICLE_PLATE',
        message: 'العربية دي مضافة عندك بالفعل بنفس رقم اللوحة.',
      );
    }
    if (error is PostgrestException && error.code == 'P0002') {
      return const ValidationFailure(
        code: 'VEHICLE_NOT_FOUND',
        message: 'العربية لم تعد موجودة. حدّث القائمة وحاول مرة أخرى.',
      );
    }
    if (error is PostgrestException) {
      return const BackendFailure();
    }
    return const UnexpectedFailure();
  }
}
