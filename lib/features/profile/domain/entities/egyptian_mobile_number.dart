/// Egyptian mobile-number parsing and canonical E.164 storage rules.
abstract final class EgyptianMobileNumber {
  /// Fixed country calling code displayed by the profile form.
  static const String countryCode = '+20';

  /// Longest accepted local input includes the trunk prefix zero.
  static const int maxLocalDigits = 11;

  static final RegExp _nationalPattern = RegExp(r'^1[0125][0-9]{8}$');

  /// Returns canonical `+201xxxxxxxxx` or `null` when [input] is invalid.
  static String? tryNormalize(String input) {
    final compact = input.trim().replaceAll(RegExp(r'[\s-]'), '');
    if (!RegExp(r'^\+?[0-9]+$').hasMatch(compact)) {
      return null;
    }
    var digits = compact.startsWith('+') ? compact.substring(1) : compact;
    if (digits.isEmpty) {
      return null;
    }
    if (digits.startsWith('20') && digits.length == 12) {
      digits = digits.substring(2);
    }
    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    return _nationalPattern.hasMatch(digits) ? '$countryCode$digits' : null;
  }

  /// Normalizes optional input for persistence and rejects invalid values.
  static String? normalizeForStorage(String input) {
    if (input.trim().isEmpty) {
      return null;
    }
    final normalized = tryNormalize(input);
    if (normalized == null) {
      throw const FormatException('Invalid Egyptian mobile number.');
    }
    return normalized;
  }

  /// Converts a stored E.164 number back to familiar `01xxxxxxxxx` input.
  static String toLocalInput(String? phone) {
    if (phone == null || phone.isEmpty) {
      return '';
    }
    final normalized = tryNormalize(phone);
    return normalized == null ? phone : '0${normalized.substring(3)}';
  }
}
