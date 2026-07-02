/// Result of parsing a two-word format string.
class FormatParseResult {
  const FormatParseResult({
    required this.inputKey,
    required this.outputKey,
  });

  final String inputKey;
  final String outputKey;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormatParseResult &&
          inputKey == other.inputKey &&
          outputKey == other.outputKey;

  @override
  int get hashCode => Object.hash(inputKey, outputKey);
}

/// Parses two-word format strings like `iso→display` or `us->eu`.
class FormatParser {
  FormatParser._();

  /// Parses [twoWordFormat] into input and output format keys.
  ///
  /// Supports both `→` and `->` as separators.
  /// Throws [ArgumentError] if the format is invalid.
  static FormatParseResult parse(String twoWordFormat) {
    final trimmed = twoWordFormat.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Format string cannot be empty');
    }

    String? inputKey;
    String? outputKey;

    if (trimmed.contains('→')) {
      final parts = trimmed.split('→');
      if (parts.length != 2) {
        throw ArgumentError('Invalid format: $twoWordFormat');
      }
      inputKey = parts[0].trim();
      outputKey = parts[1].trim();
    } else if (trimmed.contains('->')) {
      final parts = trimmed.split('->');
      if (parts.length != 2) {
        throw ArgumentError('Invalid format: $twoWordFormat');
      }
      inputKey = parts[0].trim();
      outputKey = parts[1].trim();
    } else {
      throw ArgumentError('Invalid format: $twoWordFormat');
    }

    if (inputKey.isEmpty || outputKey.isEmpty) {
      throw ArgumentError('Invalid format: $twoWordFormat');
    }

    return FormatParseResult(inputKey: inputKey, outputKey: outputKey);
  }
}
