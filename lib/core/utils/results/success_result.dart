import 'result.dart';

class SuccessResult extends Result<SuccessResult> {
  SuccessResult({String message = ''})
      : super(
          message: message,
          success: true,
        );

  factory SuccessResult.fromJson(Map<String, dynamic> json,
      {String messageKey = ResultKeys.messageKey}) {
    return SuccessResult(message: json[messageKey] ?? '');
  }

  @override
  SuccessResult fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeys.messageKey,
    String statusKey = ResultKeys.statusKey,
  }) =>
      SuccessResult.fromJson(json, messageKey: messageKey);

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
