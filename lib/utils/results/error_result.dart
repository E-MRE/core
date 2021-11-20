import '../../constants/result_key_constants.dart';
import 'result.dart';

class ErrorResult extends Result<ErrorResult> {
  ErrorResult({String message = ''})
      : super(
          message: message,
          status: false,
        );

  factory ErrorResult.fromJson(Map<String, dynamic> json,
      {String messageKey = ResultKeyConstants.messageKey}) {
    return ErrorResult(message: json[messageKey] ?? '');
  }

  @override
  ErrorResult fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeyConstants.messageKey,
    String statusKey = ResultKeyConstants.statusKey,
  }) =>
      ErrorResult.fromJson(json, messageKey: messageKey);

  @override
  Map<String, dynamic> toJson({
    String messageKey = ResultKeyConstants.messageKey,
    String statusKey = ResultKeyConstants.statusKey,
  }) {
    return {
      messageKey: message,
      statusKey: true,
    };
  }
}
