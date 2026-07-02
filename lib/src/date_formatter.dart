import 'package:intl/intl.dart';

import 'format_parser.dart';
import 'format_registry.dart';

/// Formats and parses dates using registered format keys.
class DateFormatter {
  DateFormatter._();

  /// Converts [dateString] from the input format to the output format
  /// specified by [twoWordFormat] (e.g. `iso→display`).
  static String convert(String dateString, String twoWordFormat) {
    final parsed = FormatParser.parse(twoWordFormat);
    final date = parseToDateTime(dateString, parsed.inputKey);
    return formatDate(date, parsed.outputKey);
  }

  /// Formats [date] using the format key [outputKey].
  static String formatDate(DateTime date, String outputKey) {
    final pattern = FormatRegistry.resolve(outputKey);
    if (pattern == null) {
      throw ArgumentError('Unknown format key: $outputKey');
    }

    if (pattern == 'epoch') {
      return date.millisecondsSinceEpoch.toString();
    }

    if (pattern == 'relative') {
      return _formatRelative(date);
    }

    return DateFormat(pattern).format(date);
  }

  /// Parses [dateString] using the format key [inputKey].
  static DateTime parseToDateTime(String dateString, String inputKey) {
    final pattern = FormatRegistry.resolve(inputKey);
    if (pattern == null) {
      throw ArgumentError('Unknown format key: $inputKey');
    }

    if (pattern == 'epoch') {
      final ms = int.tryParse(dateString.trim());
      if (ms == null) {
        throw FormatException('Invalid epoch value: $dateString');
      }
      return DateTime.fromMillisecondsSinceEpoch(ms);
    }

    if (pattern == 'relative') {
      return _parseRelative(dateString);
    }

    try {
      return DateFormat(pattern).parse(dateString.trim());
    } on FormatException {
      rethrow;
    }
  }

  /// Returns `true` if [dateString] can be parsed with [inputKey].
  static bool isValid(String dateString, String inputKey) {
    try {
      parseToDateTime(dateString, inputKey);
      return true;
    } catch (_) {
      return false;
    }
  }

  static String _formatRelative(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.isNegative) {
      final future = date.difference(now);
      if (future.inDays > 0) {
        return '${future.inDays} day${future.inDays == 1 ? '' : 's'} from now';
      }
      if (future.inHours > 0) {
        return '${future.inHours} hour${future.inHours == 1 ? '' : 's'} from now';
      }
      return '${future.inMinutes} minute${future.inMinutes == 1 ? '' : 's'} from now';
    }

    if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    }
    if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    }
    if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    }
    return 'just now';
  }

  static DateTime _parseRelative(String dateString) {
    final trimmed = dateString.trim().toLowerCase();

    if (trimmed == 'just now') {
      return DateTime.now();
    }

    final agoMatch = RegExp(r'^(\d+)\s+(day|days|hour|hours|minute|minutes)\s+ago$')
        .firstMatch(trimmed);
    if (agoMatch != null) {
      final amount = int.parse(agoMatch.group(1)!);
      final unit = agoMatch.group(2)!;
      final now = DateTime.now();
      if (unit.startsWith('day')) {
        return now.subtract(Duration(days: amount));
      }
      if (unit.startsWith('hour')) {
        return now.subtract(Duration(hours: amount));
      }
      return now.subtract(Duration(minutes: amount));
    }

    final fromNowMatch =
        RegExp(r'^(\d+)\s+(day|days|hour|hours|minute|minutes)\s+from\s+now$')
            .firstMatch(trimmed);
    if (fromNowMatch != null) {
      final amount = int.parse(fromNowMatch.group(1)!);
      final unit = fromNowMatch.group(2)!;
      final now = DateTime.now();
      if (unit.startsWith('day')) {
        return now.add(Duration(days: amount));
      }
      if (unit.startsWith('hour')) {
        return now.add(Duration(hours: amount));
      }
      return now.add(Duration(minutes: amount));
    }

    throw FormatException('Invalid relative date: $dateString');
  }
}
