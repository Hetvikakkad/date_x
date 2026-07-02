/// Base class for all [DateXBloc] states.
abstract class DateXState {
  const DateXState();
}

/// Initial state before any operation.
class DateXInitial extends DateXState {
  const DateXInitial();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DateXInitial;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// State emitted while a date operation is in progress.
class DateXLoading extends DateXState {
  const DateXLoading();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DateXLoading;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// State emitted when a date operation succeeds.
class DateXSuccess extends DateXState {
  const DateXSuccess({
    required this.result,
    required this.inputValue,
    required this.formatUsed,
  });

  final String result;
  final String inputValue;
  final String formatUsed;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateXSuccess &&
          result == other.result &&
          inputValue == other.inputValue &&
          formatUsed == other.formatUsed;

  @override
  int get hashCode => Object.hash(result, inputValue, formatUsed);
}

/// State emitted when a date operation fails.
class DateXError extends DateXState {
  const DateXError({required this.message});

  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateXError && message == other.message;

  @override
  int get hashCode => message.hashCode;
}
