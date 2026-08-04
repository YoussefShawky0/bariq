import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AppStartupSessionDataSource {
  bool hasAuthenticatedSession();
}

final class SupabaseAppStartupSessionDataSource
    implements AppStartupSessionDataSource {
  const SupabaseAppStartupSessionDataSource(this._supabaseClient);

  final SupabaseClient? _supabaseClient;

  @override
  bool hasAuthenticatedSession() =>
      _supabaseClient?.auth.currentSession != null;
}
