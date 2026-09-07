import 'package:bariq/features/profile/domain/entities/profile_avatar.dart';

/// User-entered values submitted to the profile-completion use case.
final class ProfileInput {
  const ProfileInput({
    required this.fullName,
    required this.phone,
    required this.city,
    required this.area,
    required this.acceptedTerms,
    this.avatar,
  });

  /// Customer display name.
  final String fullName;

  /// Optional Egyptian mobile number entered with or without the local zero.
  final String phone;

  /// Optional Egyptian governorate.
  final String city;

  /// Optional customer area.
  final String area;

  /// Explicit acceptance of the current terms version.
  final bool acceptedTerms;

  /// Optional replacement image.
  final ProfileAvatar? avatar;
}
