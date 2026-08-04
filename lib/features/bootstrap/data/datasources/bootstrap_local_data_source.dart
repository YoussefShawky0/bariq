import 'package:bariq/core/constants/storage_keys.dart';
import 'package:bariq/core/errors/exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class BootstrapLocalDataSource {
  Future<bool> isOnboardingCompleted();

  Future<bool> hasAuthenticatedSession();
}

final class BootstrapLocalDataSourceImpl implements BootstrapLocalDataSource {
  const BootstrapLocalDataSourceImpl(this._preferences, this._secureStorage);

  final SharedPreferencesAsync _preferences;
  final FlutterSecureStorage _secureStorage;

  @override
  Future<bool> isOnboardingCompleted() async {
    try {
      return await _preferences.getBool(StorageKeys.onboardingCompleted) ??
          false;
    } on Object catch (error) {
      throw CacheException(error);
    }
  }

  @override
  Future<bool> hasAuthenticatedSession() async {
    try {
      final accessToken = await _secureStorage.read(
        key: StorageKeys.accessToken,
      );
      return accessToken?.isNotEmpty ?? false;
    } on Object catch (error) {
      throw CacheException(error);
    }
  }
}
