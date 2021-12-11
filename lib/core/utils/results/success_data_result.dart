import 'result.dart';
import 'data_result.dart';

class SuccessDataResult<TData> extends DataResult<TData> {
  SuccessDataResult({
    required TData data,
    String message = '',
  }) : super(
          data: data,
          success: true,
          message: message,
        );

  factory SuccessDataResult.fromJson(
    Map<String, dynamic> json, {
    String dataKey = ResultKeys.dataKey,
    String messageKey = ResultKeys.messageKey,
  }) {
    return SuccessDataResult(
      data: json[dataKey],
      message: json[messageKey],
    );
  }

  @override
  DataResult<TData> fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeys.messageKey,
    String dataKey = ResultKeys.dataKey,
  }) {
    return SuccessDataResult.fromJson(
      json,
      dataKey: dataKey,
      messageKey: messageKey,
    );
  }

  @override
  Map<String, dynamic> toJson({
    String messageKey = ResultKeys.messageKey,
    String dataKey = ResultKeys.dataKey,
    String statusKey = ResultKeys.statusKey,
  }) {
    return {
      messageKey: message,
      statusKey: true,
      dataKey: data,
    };
  }
}
