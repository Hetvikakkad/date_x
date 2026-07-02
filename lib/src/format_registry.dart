import 'built_in_formats.dart';

/// Registry of built-in and custom date format patterns.
class FormatRegistry {
  FormatRegistry._();

  static final Map<String, String> _customFormats = {};

  /// All formats merged from built-in and custom registrations.
  static Map<String, String> get all => {
        ...BuiltInFormats.formats,
        ..._customFormats,
      };

  /// Registers a custom format [name] with the given [pattern].
  static void register(String name, String pattern) {
    _customFormats[name] = pattern;
  }

  /// Resolves a format [name] to its pattern, or `null` if not found.
  static String? resolve(String name) {
    return all[name];
  }

  /// Returns all registered format names and patterns.
  static Map<String, String> getAll() => Map.unmodifiable(all);
}
