/// Customer-owned data required by profile and booking-readiness flows.
final class CustomerProfile {
  const CustomerProfile({
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

  /// Auth user identifier that also owns the profile row.
  final String id;

  /// Read-only email supplied by Supabase Auth.
  final String email;

  /// Display name used throughout the customer experience.
  final String? fullName;

  /// Optional unverified E.164 phone number for this MVP stage.
  final String? phone;

  /// Optional Egyptian governorate collected before booking readiness.
  final String? city;

  /// Optional area collected before booking readiness is enforced.
  final String? area;

  /// Private Storage object path, never a public URL.
  final String? avatarPath;

  /// Short-lived signed URL used only for display.
  final String? avatarUrl;

  /// Customer UI language preference.
  final String preferredLanguage;

  /// Most recent accepted terms version.
  final String? termsVersion;

  /// Server timestamp for the most recent terms acceptance.
  final DateTime? termsAcceptedAt;

  /// Server-derived marker used by startup routing.
  final DateTime? completedAt;

  /// Whether the server has marked the profile-completion gate complete.
  bool get isComplete => completedAt != null;
}
