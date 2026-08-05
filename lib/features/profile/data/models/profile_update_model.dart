import 'package:bariq/features/profile/domain/entities/egyptian_mobile_number.dart';
import 'package:bariq/features/profile/domain/entities/profile_input.dart';
import 'package:bariq/features/profile/domain/entities/profile_terms.dart';

final class ProfileUpdateModel {
  const ProfileUpdateModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.city,
    required this.area,
    required this.existingAvatarPath,
  });

  factory ProfileUpdateModel.fromInput({
    required String id,
    required ProfileInput input,
    required String? existingAvatarPath,
  }) => ProfileUpdateModel(
    id: id,
    fullName: input.fullName.trim(),
    phone: EgyptianMobileNumber.normalizeForStorage(input.phone),
    city: _nullIfEmpty(input.city),
    area: _nullIfEmpty(input.area),
    existingAvatarPath: existingAvatarPath,
  );

  final String id;
  final String fullName;
  final String? phone;
  final String? city;
  final String? area;
  final String? existingAvatarPath;

  Map<String, dynamic> toJson({required String? avatarPath}) => {
    'id': id,
    'full_name': fullName,
    'phone': phone,
    'city': city,
    'area': area,
    'preferred_language': 'ar',
    'terms_version': ProfileTerms.currentVersion,
    'avatar_path': ?avatarPath,
  };
}

String? _nullIfEmpty(String value) {
  final trimmed = value.trim();
  return trimmed.isEmpty ? null : trimmed;
}
