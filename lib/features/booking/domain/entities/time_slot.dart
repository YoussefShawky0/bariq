/// A bookable time window returned by the availability query.
final class TimeSlot {
  const TimeSlot({
    required this.start,
    required this.end,
    required this.available,
  });

  /// Slot start time in UTC.
  final DateTime start;

  /// Slot end time in UTC.
  final DateTime end;

  /// Whether the slot still has capacity.
  final bool available;

  /// Display-friendly time range, e.g. "09:00 – 11:00".
  String get displayRange {
    String pad(int n) => n.toString().padLeft(2, '0');
    final s = '${pad(start.hour)}:${pad(start.minute)}';
    final e = '${pad(end.hour)}:${pad(end.minute)}';
    return '$s – $e';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlot &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end &&
          available == other.available;

  @override
  int get hashCode => Object.hash(start, end, available);
}
