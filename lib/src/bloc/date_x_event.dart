/// Base class for all [DateXBloc] events.
abstract class DateXEvent {
  const DateXEvent();
}

/// Converts a date string using a two-word format.
class ConvertDateEvent extends DateXEvent {
  const ConvertDateEvent({
    required this.dateString,
    required this.format,
  });

  final String dateString;
  final String format;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConvertDateEvent &&
          dateString == other.dateString &&
          format == other.format;

  @override
  int get hashCode => Object.hash(dateString, format);
}

/// Formats a [DateTime] using an output format key.
class FormatDateTimeEvent extends DateXEvent {
  const FormatDateTimeEvent({
    required this.date,
    required this.outputKey,
  });

  final DateTime date;
  final String outputKey;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormatDateTimeEvent &&
          date == other.date &&
          outputKey == other.outputKey;

  @override
  int get hashCode => Object.hash(date, outputKey);
}

/// Resets the bloc to its initial state.
class ResetDateXEvent extends DateXEvent {
  const ResetDateXEvent();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ResetDateXEvent;

  @override
  int get hashCode => runtimeType.hashCode;
}
