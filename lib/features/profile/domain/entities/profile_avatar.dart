import 'dart:typed_data';

/// Validated image payload selected for a private profile avatar upload.
final class ProfileAvatar {
  const ProfileAvatar({
    required this.bytes,
    required this.extension,
    required this.contentType,
  });

  /// Raw bytes kept in memory only until the upload completes.
  final Uint8List bytes;

  /// Safe lower-case file extension without a leading dot.
  final String extension;

  /// MIME type accepted by the private Storage bucket.
  final String contentType;
}

/// Upload limits shared by presentation validation and the domain use case.
abstract final class ProfileAvatarRules {
  /// Private bucket size limit.
  static const int maxBytes = 2 * 1024 * 1024;

  /// Picker-side resize bound that avoids oversized in-memory images.
  static const double maxDimension = 1024;

  /// Compression quality used by supported native pickers.
  static const int imageQuality = 85;

  /// Supported file extension to MIME-type mapping.
  static const Map<String, String> supportedTypes = {
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'webp': 'image/webp',
  };
}
