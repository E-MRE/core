import 'data_result.dart';
import 'result.dart';

class ErrorDataResult<TData> extends DataResult<TData> {
  ErrorDataResult({
    TData? data,
    required String message,
  }) : super(
          data: data,
          success: false,
          message: message,
        );

  factory ErrorDataResult.fromJson(
    Map<String, dynamic> json, {
    String dataKey = ResultKeys.dataKey,
    String messageKey = ResultKeys.messageKey,
  }) {
    return ErrorDataResult(
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
    return ErrorDataResult.fromJson(
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
      statusKey: false,
      dataKey: data,
    };
  }
}
