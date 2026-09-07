import 'package:bariq/features/profile/domain/entities/customer_profile.dart';

final class CustomerProfileModel {
  const CustomerProfileModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.city,
    required this.area,
    required this.avatarPath,
    required this.avatarUrl,
    required this.preferredLanguage,
    required this.termsVersion,
    required this.termsAcceptedAt,
    required this.completedAt,
  });

  factory CustomerProfileModel.empty({
    required String id,
    required String email,
  }) => CustomerProfileModel(
    id: id,
    email: email,
    fullName: null,
    phone: null,
    city: null,
    area: null,
    avatarPath: null,
    avatarUrl: null,
    preferredLanguage: 'ar',
    termsVersion: null,
    termsAcceptedAt: null,
    completedAt: null,
  );

  factory CustomerProfileModel.fromJson(
    Map<String, dynamic> json, {
    required String email,
    required String? avatarUrl,
  }) => CustomerProfileModel(
    id: json['id'] as String,
    email: email,
    fullName: json['full_name'] as String?,
    phone: json['phone'] as String?,
    city: json['city'] as String?,
    area: json['area'] as String?,
    avatarPath: json['avatar_path'] as String?,
    avatarUrl: avatarUrl,
    preferredLanguage: json['preferred_language'] as String? ?? 'ar',
    termsVersion: json['terms_version'] as String?,
    termsAcceptedAt: _parseDate(json['terms_accepted_at']),
    completedAt: _parseDate(json['completed_at']),
  );

  final String id;
  final String email;
  final String? fullName;
  final String? phone;
  final String? city;
  final String? area;
  final String? avatarPath;
  final String? avatarUrl;
  final String preferredLanguage;
  final String? termsVersion;
  final DateTime? termsAcceptedAt;
  final DateTime? completedAt;

  CustomerProfile toEntity() => CustomerProfile(
    id: id,
    email: email,
    fullName: fullName,
    phone: phone,
    city: city,
    area: area,
    avatarPath: avatarPath,
    avatarUrl: avatarUrl,
    preferredLanguage: preferredLanguage,
    termsVersion: termsVersion,
    termsAcceptedAt: termsAcceptedAt,
    completedAt: completedAt,
  );
}

DateTime? _parseDate(Object? value) => value is String
    ? DateTime.tryParse(value)?.toUtc()
    : value is DateTime
    ? value.toUtc()
    : null;
