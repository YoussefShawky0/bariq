final class CacheException implements Exception {
  const CacheException(this.cause);

  final Object cause;
}
