abstract class Result<T> {
  final String message;
  final bool success;

  Result({
    this.message = '',
    required this.success,
  });

  Map<String, dynamic> toJson({
    String messageKey = ResultKeys.messageKey,
    String statusKey = ResultKeys.statusKey,
  });

  T fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeys.messageKey,
  });
}

class ResultKeys {
  static const String messageKey = 'message';
  static const String statusKey = 'status';
  static const String dataKey = 'data';
}
