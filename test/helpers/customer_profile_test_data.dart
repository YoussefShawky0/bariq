import 'package:bariq/features/profile/domain/entities/customer_profile.dart';

CustomerProfile customerProfile({
  String? fullName,
  String? phone,
  String? city,
  String? area,
  String? termsVersion,
  bool completed = false,
}) => CustomerProfile(
  id: 'customer-id',
  email: 'customer@example.com',
  fullName: fullName,
  phone: phone,
  city: city,
  area: area,
  avatarPath: null,
  avatarUrl: null,
  preferredLanguage: 'ar',
  termsVersion: termsVersion,
  termsAcceptedAt: termsVersion == null ? null : DateTime.utc(2026, 8, 4),
  completedAt: completed ? DateTime.utc(2026, 8, 4) : null,
);
