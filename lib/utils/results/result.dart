import '../../constants/result_key_constants.dart';

abstract class Result<T> {
  final String message;
  final bool status;

  Result({
    this.message = '',
    required this.status,
  });

  Map<String, dynamic> toJson({
    String messageKey = ResultKeyConstants.messageKey,
    String statusKey = ResultKeyConstants.statusKey,
  });

  T fromJson(
    Map<String, dynamic> json, {
    String messageKey = ResultKeyConstants.messageKey,
  });
}
