import 'date_formatter.dart';
import 'format_registry.dart';

/// Main entry point for date conversion, formatting, and parsing.
class DateX {
  DateX._();

  /// Converts [dateString] using a two-word format (e.g. `iso→display`).
  static String convert(String dateString, String twoWordFormat) {
    return DateFormatter.convert(dateString, twoWordFormat);
  }

  /// Formats [date] using the format key [outputKey].
  static String format(DateTime date, String outputKey) {
    return DateFormatter.formatDate(date, outputKey);
  }

  /// Parses [dateString] using the format key [inputKey].
  static DateTime parse(String dateString, String inputKey) {
    return DateFormatter.parseToDateTime(dateString, inputKey);
  }

  /// Registers a custom format [name] with the given [pattern].
  static void register(String name, String pattern) {
    FormatRegistry.register(name, pattern);
  }

  /// Returns `true` if [dateString] is valid for [inputKey].
  static bool isValid(String dateString, String inputKey) {
    return DateFormatter.isValid(dateString, inputKey);
  }
}
