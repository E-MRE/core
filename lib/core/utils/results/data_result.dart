import 'result.dart';

abstract class DataResult<TData> extends Result<DataResult<TData>> {
  final TData? data;

  DataResult({
    this.data,
    required bool success,
    String message = '',
  }) : super(
          success: success,
          message: message,
        );

  @override
  Map<String, dynamic> toJson({
    String messageKey = ResultKeys.messageKey,
    String dataKey = ResultKeys.dataKey,
    String statusKey = ResultKeys.statusKey,
  });

  @override
  DataResult<TData> fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeys.messageKey,
    String dataKey = ResultKeys.dataKey,
  });
}
