/// Booking lifecycle status matching the server-authoritative state machine.
///
/// Transitions are enforced by the backend; the client sends intents
/// and reads the resulting status.
enum BookingStatus {
  draft,
  pendingPayment,
  confirmed,
  dispatching,
  assigned,
  enRoute,
  arrived,
  inService,
  qualityReview,
  completed,
  cancelled,
  disputed,
  resolved;

  /// Stable snake_case value used in the backend contract.
  String get apiValue => switch (this) {
    draft => 'draft',
    pendingPayment => 'pending_payment',
    confirmed => 'confirmed',
    dispatching => 'dispatching',
    assigned => 'assigned',
    enRoute => 'en_route',
    arrived => 'arrived',
    inService => 'in_service',
    qualityReview => 'quality_review',
    completed => 'completed',
    cancelled => 'cancelled',
    disputed => 'disputed',
    resolved => 'resolved',
  };

  /// Customer-facing Arabic label.
  String get arabicLabel => switch (this) {
    draft => 'مسودة',
    pendingPayment => 'في انتظار الدفع',
    confirmed => 'مؤكد',
    dispatching => 'جارٍ التعيين',
    assigned => 'تم التعيين',
    enRoute => 'في الطريق',
    arrived => 'وصل',
    inService => 'قيد التنفيذ',
    qualityReview => 'مراجعة الجودة',
    completed => 'مكتمل',
    cancelled => 'ملغي',
    disputed => 'نزاع',
    resolved => 'تم الحل',
  };

  /// Parses a backend value safely, defaulting to [draft].
  static BookingStatus fromApi(String value) => BookingStatus.values.firstWhere(
    (s) => s.apiValue == value,
    orElse: () => BookingStatus.draft,
  );
}
