/// Payment method selected by the customer at booking time.
///
/// Phase 3 supports cash only. Paymob is added in Phase 4.
enum PaymentMethod {
  cash;

  /// Stable value persisted by the backend contract.
  String get apiValue => name;

  /// Customer-facing Arabic label.
  String get arabicLabel => switch (this) {
    cash => 'كاش عند الخدمة',
  };

  /// Parses a backend value safely, defaulting to [cash].
  static PaymentMethod fromApi(String value) =>
      PaymentMethod.values.firstWhere(
        (m) => m.apiValue == value,
        orElse: () => PaymentMethod.cash,
      );
}
