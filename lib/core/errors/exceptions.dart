final class CacheException implements Exception {
  const CacheException(this.cause);

  final Object cause;
}

final class BackendConfigurationException implements Exception {
  const BackendConfigurationException();
}

final class ExternalAuthLaunchException implements Exception {
  const ExternalAuthLaunchException();
}

final class UnauthenticatedException implements Exception {
  const UnauthenticatedException();
}
