import 'package:bariq/core/errors/exceptions.dart';
import 'package:bariq/features/profile/data/models/customer_profile_model.dart';
import 'package:bariq/features/profile/data/models/profile_update_model.dart';
import 'package:bariq/features/profile/domain/entities/profile_avatar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<CustomerProfileModel> loadCurrentProfile();

  Future<CustomerProfileModel> saveCurrentProfile({
    required ProfileUpdateModel update,
    required ProfileAvatar? avatar,
  });
}

final class SupabaseProfileRemoteDataSource implements ProfileRemoteDataSource {
  const SupabaseProfileRemoteDataSource(this._supabaseClient);

  static const _table = 'profiles';
  static const _avatarBucket = 'profile-avatars';
  static const _columns =
      'id, full_name, phone, city, area, avatar_path, preferred_language, '
      'terms_version, terms_accepted_at, completed_at';
  static const _signedUrlLifetimeSeconds = 3600;

  final SupabaseClient? _supabaseClient;

  SupabaseClient get _client {
    final client = _supabaseClient;
    if (client == null) {
      throw const BackendConfigurationException();
    }
    return client;
  }

  User get _user {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const UnauthenticatedException();
    }
    return user;
  }

  @override
  Future<CustomerProfileModel> loadCurrentProfile() async {
    final user = _user;
    final json = await _client
        .from(_table)
        .select(_columns)
        .eq('id', user.id)
        .maybeSingle();
    if (json == null) {
      return CustomerProfileModel.empty(id: user.id, email: user.email ?? '');
    }

    final avatarPath = json['avatar_path'] as String?;
    return CustomerProfileModel.fromJson(
      json,
      email: user.email ?? '',
      avatarUrl: await _createAvatarUrl(avatarPath),
    );
  }

  @override
  Future<CustomerProfileModel> saveCurrentProfile({
    required ProfileUpdateModel update,
    required ProfileAvatar? avatar,
  }) async {
    final user = _user;
    if (user.id != update.id) {
      throw const UnauthenticatedException();
    }

    String? uploadedPath;
    try {
      uploadedPath = avatar == null
          ? null
          : await _uploadAvatar(user.id, avatar);
      final avatarPath = uploadedPath ?? update.existingAvatarPath;
      final json = await _client
          .from(_table)
          .upsert(update.toJson(avatarPath: avatarPath), onConflict: 'id')
          .select(_columns)
          .single();

      if (uploadedPath != null &&
          update.existingAvatarPath != null &&
          update.existingAvatarPath != uploadedPath) {
        await _removeAvatarSafely(update.existingAvatarPath!);
      }

      return CustomerProfileModel.fromJson(
        json,
        email: user.email ?? '',
        avatarUrl: await _createAvatarUrl(json['avatar_path'] as String?),
      );
    } on Object {
      if (uploadedPath != null) {
        await _removeAvatarSafely(uploadedPath);
      }
      rethrow;
    }
  }

  Future<String> _uploadAvatar(String userId, ProfileAvatar avatar) async {
    final timestamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    final path = '$userId/avatar-$timestamp.${avatar.extension}';
    await _client.storage
        .from(_avatarBucket)
        .uploadBinary(
          path,
          avatar.bytes,
          fileOptions: FileOptions(
            cacheControl: '3600',
            contentType: avatar.contentType,
          ),
        );
    return path;
  }

  Future<String?> _createAvatarUrl(String? path) async {
    if (path == null || path.isEmpty) {
      return null;
    }
    return _client.storage
        .from(_avatarBucket)
        .createSignedUrl(path, _signedUrlLifetimeSeconds);
  }

  Future<void> _removeAvatarSafely(String path) async {
    try {
      await _client.storage.from(_avatarBucket).remove([path]);
    } on Object {
      // Cleanup must never replace the original profile result or failure.
    }
  }
}
