import 'package:bariq/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AppStartupProfileDataSource {
  Future<bool> hasCompletedProfile(String userId);
}

final class SupabaseAppStartupProfileDataSource
    implements AppStartupProfileDataSource {
  const SupabaseAppStartupProfileDataSource(this._supabaseClient);

  final SupabaseClient? _supabaseClient;

  SupabaseClient get _client {
    final client = _supabaseClient;
    if (client == null) {
      throw const BackendConfigurationException();
    }
    return client;
  }

  @override
  Future<bool> hasCompletedProfile(String userId) async {
    final profile = await _client
        .from('profiles')
        .select('completed_at')
        .eq('id', userId)
        .maybeSingle();
    return profile?['completed_at'] != null;
  }
}
