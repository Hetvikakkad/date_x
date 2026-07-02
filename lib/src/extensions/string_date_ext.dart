import '../date_formatter.dart';

/// Extension methods for date conversion on [String].
extension StringDateX on String {
  /// Converts this date string using [format] (e.g. `iso→display`).
  String dateX(String format) => DateFormatter.convert(this, format);

  /// Parses this date string using [inputKey].
  DateTime toDateX(String inputKey) =>
      DateFormatter.parseToDateTime(this, inputKey);

  /// Returns `true` if this string is a valid date for [inputKey].
  bool isValidDateX(String inputKey) =>
      DateFormatter.isValid(this, inputKey);
}
