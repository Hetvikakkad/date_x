import '../date_formatter.dart';

/// Extension methods for date formatting on [DateTime].
extension DateTimeX on DateTime {
  /// Formats this date using [outputKey] (e.g. `display`, `long`).
  String formatX(String outputKey) => DateFormatter.formatDate(this, outputKey);
}
