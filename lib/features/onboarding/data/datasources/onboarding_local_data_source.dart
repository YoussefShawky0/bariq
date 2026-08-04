import 'package:bariq/core/constants/storage_keys.dart';
import 'package:bariq/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class OnboardingLocalDataSource {
  Future<void> completeOnboarding();
}

final class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  const OnboardingLocalDataSourceImpl(this._preferences);

  final SharedPreferencesAsync _preferences;

  @override
  Future<void> completeOnboarding() async {
    try {
      await _preferences.setBool(StorageKeys.onboardingCompleted, true);
    } on Object catch (error) {
      throw CacheException(error);
    }
  }
}
