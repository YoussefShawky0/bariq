import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AppStartupSessionDataSource {
  String? currentUserId();
}

final class SupabaseAppStartupSessionDataSource
    implements AppStartupSessionDataSource {
  const SupabaseAppStartupSessionDataSource(this._supabaseClient);

  final SupabaseClient? _supabaseClient;

  @override
  String? currentUserId() => _supabaseClient?.auth.currentSession?.user.id;
}
