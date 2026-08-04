import 'package:bariq/core/constants/app_links.dart';
import 'package:bariq/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Stream<AuthState> watchSession();

  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  });

  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<void> requestPasswordReset(String email);

  Future<UserResponse> updatePassword(String password);

  Future<bool> signInWithGoogle();
}

final class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  const SupabaseAuthRemoteDataSource(this._supabaseClient);

  final SupabaseClient? _supabaseClient;

  SupabaseClient get _client {
    final client = _supabaseClient;
    if (client == null) {
      throw const BackendConfigurationException();
    }
    return client;
  }

  @override
  Stream<AuthState> watchSession() => _client.auth.onAuthStateChange;

  @override
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) => _client.auth.signInWithPassword(email: email, password: password);

  @override
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) => _client.auth.signUp(
    email: email,
    password: password,
    emailRedirectTo: AppLinks.authCallback,
  );

  @override
  Future<void> requestPasswordReset(String email) => _client.auth
      .resetPasswordForEmail(email, redirectTo: AppLinks.authCallback);

  @override
  Future<UserResponse> updatePassword(String password) =>
      _client.auth.updateUser(UserAttributes(password: password));

  @override
  Future<bool> signInWithGoogle() => _client.auth.signInWithOAuth(
    OAuthProvider.google,
    redirectTo: AppLinks.authCallback,
  );
}
