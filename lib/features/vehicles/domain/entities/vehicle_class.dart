/// Pricing and service-size category assigned to a customer vehicle.
enum VehicleClass {
  sedan,
  suv,
  hatchback,
  pickup,
  van;

  /// Stable value persisted by the backend contract.
  String get apiValue => name;

  /// Customer-facing Arabic label.
  String get arabicLabel => switch (this) {
    sedan => 'سيدان',
    suv => 'SUV / دفع رباعي',
    hatchback => 'هاتشباك',
    pickup => 'بيك أب',
    van => 'فان',
  };

  /// Parses a backend value and fails safely for unsupported categories.
  static VehicleClass fromApi(String value) => VehicleClass.values.firstWhere(
    (item) => item.apiValue == value,
    orElse: () => VehicleClass.sedan,
  );
}
