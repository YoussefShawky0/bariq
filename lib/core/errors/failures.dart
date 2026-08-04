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

final class ValidationFailure extends Failure {
  const ValidationFailure({required super.code, required super.message});
}

final class AuthenticationFailure extends Failure {
  const AuthenticationFailure({required super.code, required super.message});
}

final class NetworkFailure extends Failure {
  const NetworkFailure()
    : super(
        code: 'NETWORK_FAILURE',
        message: 'تعذر الاتصال بالخدمة. تحقق من الإنترنت وحاول مرة أخرى.',
      );
}

final class BackendConfigurationFailure extends Failure {
  const BackendConfigurationFailure()
    : super(
        code: 'BACKEND_NOT_CONFIGURED',
        message: 'خدمة تسجيل الدخول غير مهيأة على هذا الإصدار.',
      );
}
