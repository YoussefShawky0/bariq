sealed class Failure {
  const Failure({required this.code, required this.message});

  final String code;
  final String message;
}

final class CacheFailure extends Failure {
  const CacheFailure()
    : super(
        code: 'CACHE_FAILURE',
        message: 'Unable to read the local application state.',
      );
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure()
    : super(
        code: 'UNEXPECTED_FAILURE',
        message: 'An unexpected error occurred.',
      );
}
