import 'package:bariq/core/config/app_environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppEnvironment', () {
    test('allows the app to run without backend configuration', () {
      final environment = AppEnvironment.fromMap(const {});

      expect(environment.isSupabaseConfigured, isFalse);
    });

    test('accepts a complete hosted Supabase configuration', () {
      final environment = AppEnvironment.fromMap(const {
        'SUPABASE_URL': 'https://example.supabase.co',
        'SUPABASE_PUBLISHABLE_KEY': 'sb_publishable_example',
      });

      expect(environment.isSupabaseConfigured, isTrue);
    });

    test('rejects a partial Supabase configuration', () {
      expect(
        () => AppEnvironment.fromMap(const {
          'SUPABASE_URL': 'https://example.supabase.co',
        }),
        throwsFormatException,
      );
    });

    test('allows HTTP only for local Supabase development', () {
      final environment = AppEnvironment.fromMap(const {
        'SUPABASE_URL': 'http://127.0.0.1:54321',
        'SUPABASE_PUBLISHABLE_KEY': 'local_publishable_key',
      });

      expect(environment.isSupabaseConfigured, isTrue);
      expect(
        () => AppEnvironment.fromMap(const {
          'SUPABASE_URL': 'http://example.supabase.co',
          'SUPABASE_PUBLISHABLE_KEY': 'sb_publishable_example',
        }),
        throwsFormatException,
      );
    });
  });
}
