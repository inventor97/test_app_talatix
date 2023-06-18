class LanguageModel {
  final String langValue;
  final String label;
  final String shortLabel;

  LanguageModel({
    required this.langValue,
    required this.label,
    required this.shortLabel,
  });
}

class EnumValues<T> {
  Map<dynamic, T> map;
  Map<T, dynamic>? reverseMap;

  EnumValues(this.map);

  Map<T, dynamic>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}