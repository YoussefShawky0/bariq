import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/features/booking/data/models/booking_model.dart';
import 'package:bariq/features/booking/domain/entities/booking_draft.dart';
import 'package:bariq/features/booking/domain/entities/booking_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Remote data source contract for booking operations.
abstract interface class BookingRemoteDataSource {
  /// Fetches available slots for a zone on a given date.
  Future<List<TimeSlotModel>> loadAvailableSlots(
    String zoneId,
    DateTime date,
  );

  /// Creates a booking from a validated draft.
  Future<BookingModel> createBooking(
    BookingDraft draft,
    String idempotencyKey,
  );
}

/// Supabase implementation of [BookingRemoteDataSource].
final class SupabaseBookingRemoteDataSource implements BookingRemoteDataSource {
  const SupabaseBookingRemoteDataSource(this._supabaseClient);

  static const _createRpc = 'create_booking';
  static const _slotsRpc = 'get_available_slots';

  final SupabaseClient? _supabaseClient;

  SupabaseClient get _client {
    final client = _supabaseClient;
    if (client == null) {
      throw const BackendConfigurationException();
    }
    return client;
  }

  void _ensureAuthenticated() {
    if (_client.auth.currentUser == null) {
      throw const UnauthenticatedException();
    }
  }

  @override
  Future<List<TimeSlotModel>> loadAvailableSlots(
    String zoneId,
    DateTime date,
  ) async {
    _ensureAuthenticated();
    final dynamic response = await _client.rpc<dynamic>(
      _slotsRpc,
      params: {
        'p_zone_id': zoneId,
        'p_date': date.toIso8601String().split('T').first,
      },
    );
    if (response is List) {
      return response
          .map((row) => TimeSlotModel.fromJson(row as Map<String, dynamic>))
          .toList(growable: false);
    }
    return const [];
  }

  @override
  Future<BookingModel> createBooking(
    BookingDraft draft,
    String idempotencyKey,
  ) async {
    _ensureAuthenticated();

    // Build items array for the RPC.
    final items = <Map<String, dynamic>>[
      {
        'item_type': BookingItemType.service.apiValue,
        'name_snapshot': draft.service!.nameAr,
        'price_minor': draft.pricing!.priceMinor,
        'duration_minutes': draft.pricing!.durationMinutes,
      },
      ...draft.addons.map((addon) => {
        'item_type': BookingItemType.addon.apiValue,
        'name_snapshot': addon.nameAr,
        'price_minor': addon.priceMinor,
        'duration_minutes': addon.durationMinutes,
      }),
    ];

    final dynamic response = await _client.rpc<dynamic>(
      _createRpc,
      params: {
        'p_vehicle_id': draft.vehicle!.id,
        'p_address_id': draft.address!.id,
        'p_zone_id': draft.address!.zoneId,
        'p_slot_start': draft.slot!.start.toIso8601String(),
        'p_slot_end': draft.slot!.end.toIso8601String(),
        'p_total_minor': draft.totalMinor,
        'p_payment_method': draft.paymentMethod.apiValue,
        'p_idempotency_key': idempotencyKey,
        'p_items': items,
      },
    );

    final Map<String, dynamic> json;
    if (response is List && response.isNotEmpty) {
      json = response.first as Map<String, dynamic>;
    } else if (response is Map<String, dynamic>) {
      json = response;
    } else {
      throw const BackendConfigurationException();
    }
    return BookingModel.fromJson(json);
  }
}
