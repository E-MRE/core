import '../../constants/result_key_constants.dart';
import 'result.dart';

class SuccessResult extends Result<SuccessResult> {
  SuccessResult({String message = ''})
      : super(
          message: message,
          status: true,
        );

  factory SuccessResult.fromJson(Map<String, dynamic> json,
      {String messageKey = ResultKeyConstants.messageKey}) {
    return SuccessResult(message: json[messageKey] ?? '');
  }

  @override
  SuccessResult fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeyConstants.messageKey,
    String statusKey = ResultKeyConstants.statusKey,
  }) =>
      SuccessResult.fromJson(json, messageKey: messageKey);

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
