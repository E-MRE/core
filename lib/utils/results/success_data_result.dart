import '../../constants/result_key_constants.dart';
import 'data_result.dart';

class SuccessDataResult<TData> extends DataResult<TData> {
  SuccessDataResult({
    required TData data,
    String message = '',
  }) : super(
          data: data,
          status: true,
          message: message,
        );

  factory SuccessDataResult.fromJson(
    Map<String, dynamic> json, {
    String dataKey = ResultKeyConstants.dataKey,
    String messageKey = ResultKeyConstants.messageKey,
  }) {
    return SuccessDataResult(
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
    return SuccessDataResult.fromJson(
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
      statusKey: true,
      dataKey: data,
    };
  }
}
