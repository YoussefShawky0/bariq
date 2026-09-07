/// Shared validation limits for vehicle input and UI choices.
abstract final class VehicleRules {
  static const int minMakeLength = 2;
  static const int maxMakeLength = 50;
  static const int minModelLength = 1;
  static const int maxModelLength = 50;
  static const int minColorLength = 2;
  static const int maxColorLength = 30;
  static const int minPlateLength = 2;
  static const int maxPlateLength = 20;
  static const int earliestYear = 1950;

  /// Latest acceptable model year, including announced next-year vehicles.
  static int latestYear(DateTime now) => now.year + 1;
}
