import 'result.dart';

class ErrorResult extends Result<ErrorResult> {
  ErrorResult({String message = ''})
      : super(
          message: message,
          status: false,
        );

  factory ErrorResult.fromJson(Map<String, dynamic> json,
      {String messageKey = ResultKeys.messageKey}) {
    return ErrorResult(message: json[messageKey] ?? '');
  }

  @override
  ErrorResult fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeys.messageKey,
    String statusKey = ResultKeys.statusKey,
  }) =>
      ErrorResult.fromJson(json, messageKey: messageKey);

  @override
  Map<String, dynamic> toJson({
    String messageKey = ResultKeys.messageKey,
    String statusKey = ResultKeys.statusKey,
  }) {
    return {
      messageKey: message,
      statusKey: true,
    };
  }
}
