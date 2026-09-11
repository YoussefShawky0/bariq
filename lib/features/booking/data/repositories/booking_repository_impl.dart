import 'dart:async';
import 'dart:io';

import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:bariq/features/booking/domain/entities/booking.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:bariq/features/booking/domain/entities/time_slot.dart';
import 'package:bariq/features/booking/domain/repositories/booking_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase-backed [BookingRepository] implementation.
final class BookingRepositoryImpl implements BookingRepository {
  const BookingRepositoryImpl(this._remoteDataSource, this._logger);

  final BookingRemoteDataSource _remoteDataSource;
  final AppLogger _logger;

  @override
  ResultFuture<List<TimeSlot>> loadAvailableSlots({
    required String zoneId,
    required DateTime date,
  }) => _guard(
    () async => (await _remoteDataSource.loadAvailableSlots(
      zoneId,
      date,
    )).map((model) => model.toEntity()).toList(growable: false),
  );

  @override
  ResultFuture<Booking> createBooking({
    required BookingDraft draft,
    required String idempotencyKey,
  }) => _guard(
    () async => (await _remoteDataSource.createBooking(
      draft,
      idempotencyKey,
    )).toEntity(),
  );

  ResultFuture<T> _guard<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Booking operation failed.',
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
    // Duplicate idempotency key — booking already created.
    if (error is PostgrestException && error.code == '23505') {
      return const ValidationFailure(
        code: 'DUPLICATE_BOOKING',
        message: 'تم إنشاء هذا الحجز بالفعل.',
      );
    }
    // Slot no longer available.
    if (error is PostgrestException && error.code == 'P0001') {
      return const ValidationFailure(
        code: 'BOOKING_SLOT_UNAVAILABLE',
        message: 'الموعد المختار لم يعد متاحًا. اختر موعدًا آخر.',
      );
    }
    if (error is PostgrestException) {
      return const BackendFailure();
    }
    return const UnexpectedFailure();
  }
}
