import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Client-safe configuration loaded from the untracked `.env` asset.
final class AppEnvironment {
  const AppEnvironment._({
    required this.supabaseUrl,
    required this.supabasePublishableKey,
  });

  /// Creates a validated configuration from environment values.
  factory AppEnvironment.fromMap(Map<String, String> values) {
    final url = _normalize(values[_supabaseUrlKey]);
    final publishableKey = _normalize(values[_supabasePublishableKeyKey]);

    if ((url == null) != (publishableKey == null)) {
      throw const FormatException(
        'SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY must be provided together.',
      );
    }

    if (url != null) {
      _validateSupabaseUrl(url);
    }

    return AppEnvironment._(
      supabaseUrl: url,
      supabasePublishableKey: publishableKey,
    );
  }

  static const String _environmentFile = '.env';
  static const String _supabaseUrlKey = 'SUPABASE_URL';
  static const String _supabasePublishableKeyKey = 'SUPABASE_PUBLISHABLE_KEY';

  final String? supabaseUrl;
  final String? supabasePublishableKey;

  /// Whether the app has a complete Supabase client configuration.
  bool get isSupabaseConfigured =>
      supabaseUrl != null && supabasePublishableKey != null;

  /// Loads and validates the local client configuration.
  static Future<AppEnvironment> load() async {
    await dotenv.load(fileName: _environmentFile, isOptional: true);
    return AppEnvironment.fromMap(dotenv.env);
  }

  static String? _normalize(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  static void _validateSupabaseUrl(String value) {
    final uri = Uri.tryParse(value);
    final isLocal = uri?.host == 'localhost' || uri?.host == '127.0.0.1';
    final hasAllowedScheme =
        uri?.scheme == 'https' || (isLocal && uri?.scheme == 'http');

    if (uri == null || !uri.hasAuthority || !hasAllowedScheme) {
      throw const FormatException(
        'SUPABASE_URL must use HTTPS, except for local development.',
      );
    }
  }
}
