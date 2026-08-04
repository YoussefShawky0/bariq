import 'package:bariq/core/config/app_environment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Initializes the managed backend only when client configuration is present.
abstract final class SupabaseInitializer {
  static Future<SupabaseClient?> initialize(AppEnvironment environment) async {
    final url = environment.supabaseUrl;
    final publishableKey = environment.supabasePublishableKey;

    if (url == null || publishableKey == null) {
      return null;
    }

    final supabase = await Supabase.initialize(
      url: url,
      publishableKey: publishableKey,
      debug: false,
    );
    return supabase.client;
  }
}
