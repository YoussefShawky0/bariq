import 'package:bariq/core/errors/failures.dart';

/// Validates customer authentication input before any remote call.
abstract final class AuthInputValidator {
  static final RegExp _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  /// Returns a safe validation failure when [email] is invalid.
  static ValidationFailure? validateEmail(String email) {
    if (!_emailPattern.hasMatch(email.trim())) {
      return const ValidationFailure(
        code: 'INVALID_EMAIL',
        message: 'اكتب بريدًا إلكترونيًا صحيحًا.',
      );
    }
    return null;
  }

  /// Returns a safe validation failure when [password] is too short.
  static ValidationFailure? validatePassword(String password) {
    if (password.length < 8) {
      return const ValidationFailure(
        code: 'WEAK_PASSWORD',
        message: 'كلمة المرور يجب أن تكون 8 أحرف على الأقل.',
      );
    }
    return null;
  }

  /// Returns a safe validation failure when passwords do not match.
  static ValidationFailure? validatePasswordConfirmation(
    String password,
    String confirmation,
  ) {
    if (password != confirmation) {
      return const ValidationFailure(
        code: 'PASSWORD_MISMATCH',
        message: 'كلمتا المرور غير متطابقتين.',
      );
    }
    return null;
  }
}
