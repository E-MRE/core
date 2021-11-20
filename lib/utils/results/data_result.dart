import '../../constants/result_key_constants.dart';
import 'result.dart';

abstract class DataResult<TData> extends Result<DataResult<TData>> {
  final TData data;

  DataResult({
    required this.data,
    required bool status,
    String message = '',
  }) : super(
          status: status,
          message: message,
        );

  @override
  Map<String, dynamic> toJson({
    String messageKey = ResultKeyConstants.messageKey,
    String dataKey = ResultKeyConstants.dataKey,
    String statusKey = ResultKeyConstants.statusKey,
  });

  @override
  DataResult<TData> fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeyConstants.messageKey,
    String dataKey = ResultKeyConstants.dataKey,
  });
}
