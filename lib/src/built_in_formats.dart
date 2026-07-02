/// Built-in date format definitions keyed by short name.
class BuiltInFormats {
  BuiltInFormats._();

  static const Map<String, String> formats = {
    'iso': 'yyyy-MM-dd',
    'iso8601': "yyyy-MM-dd'T'HH:mm:ss",
    'api': 'yyyy-MM-dd',
    'us': 'MM/dd/yyyy',
    'eu': 'dd/MM/yyyy',
    'display': 'd MMM yyyy',
    'long': 'MMMM d, yyyy',
    'short': 'dd MMM yy',
    'time': 'HH:mm',
    'datetime': 'd MMM yyyy, HH:mm',
    'epoch': 'epoch',
    'relative': 'relative',
  };
}
