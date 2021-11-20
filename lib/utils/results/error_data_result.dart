import '../../constants/result_key_constants.dart';
import 'data_result.dart';

class ErrorDataResult<TData> extends DataResult<TData> {
  ErrorDataResult({
    required TData data,
    String message = '',
  }) : super(
          data: data,
          status: false,
          message: message,
        );

  factory ErrorDataResult.fromJson(
    Map<String, dynamic> json, {
    String dataKey = ResultKeyConstants.dataKey,
    String messageKey = ResultKeyConstants.messageKey,
  }) {
    return ErrorDataResult(
      data: json[dataKey],
      message: json[messageKey],
    );
  }

  @override
  DataResult<TData> fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeyConstants.messageKey,
    String dataKey = ResultKeyConstants.dataKey,
  }) {
    return ErrorDataResult.fromJson(
      json,
      dataKey: dataKey,
      messageKey: messageKey,
    );
  }

  @override
  Map<String, dynamic> toJson({
    String messageKey = ResultKeyConstants.messageKey,
    String dataKey = ResultKeyConstants.dataKey,
    String statusKey = ResultKeyConstants.statusKey,
  }) {
    return {
      messageKey: message,
      statusKey: false,
      dataKey: data,
    };
  }
}
