import 'dart:async';
import 'dart:io';

import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/addresses/data/datasources/address_remote_data_source.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/domain/entities/address_input.dart';
import 'package:bariq/features/addresses/domain/entities/zone.dart';
import 'package:bariq/features/addresses/domain/repositories/address_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AddressRepositoryImpl implements AddressRepository {
  const AddressRepositoryImpl(
    this._remoteDataSource,
    this._logger,
    this._supabaseClient,
  );

  final AddressRemoteDataSource _remoteDataSource;
  final AppLogger _logger;
  final SupabaseClient? _supabaseClient;

  @override
  ResultFuture<List<Address>> loadAddresses() =>
      _guard(() => _remoteDataSource.fetchAddresses());

  @override
  ResultFuture<Address> saveAddress(AddressInput input) => _guard(() {
        final userId = _supabaseClient?.auth.currentUser?.id;
        if (userId == null) throw const UnauthenticatedException();
        if (input.isUpdate) {
          return _remoteDataSource.updateAddress(input);
        }
        return _remoteDataSource.insertAddress(input, userId);
      });

  @override
  ResultFuture<void> deleteAddress(String addressId) =>
      _guard(() => _remoteDataSource.deleteAddress(addressId));

  @override
  ResultFuture<List<Zone>> loadZones() =>
      _guard(() => _remoteDataSource.fetchZones());

  ResultFuture<T> _guard<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Customer address operation failed.',
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
    if (error is PostgrestException && error.code == 'check_violation') {
      return const ValidationFailure(
        code: 'ADDRESS_LIMIT_REACHED',
        message: 'وصلت للحد الأقصى (10 عناوين). احذف عنوان قبل إضافة جديد.',
      );
    }
    if (error is PostgrestException) {
      return const BackendFailure();
    }
    return const UnexpectedFailure();
  }
}
