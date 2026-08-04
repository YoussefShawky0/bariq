import 'package:bariq/core/constants/storage_keys.dart';
import 'package:bariq/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppStartupLocalDataSource {
  Future<bool> isOnboardingCompleted();
}

final class AppStartupLocalDataSourceImpl implements AppStartupLocalDataSource {
  const AppStartupLocalDataSourceImpl(this._preferences);

  final SharedPreferencesAsync _preferences;

  @override
  Future<bool> isOnboardingCompleted() async {
    try {
      return await _preferences.getBool(StorageKeys.onboardingCompleted) ??
          false;
    } on Object catch (error) {
      throw CacheException(error);
    }
  }
}
