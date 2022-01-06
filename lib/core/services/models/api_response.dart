///Response model of API. If you have spesific api response model,
///just implement that abstract class and override methods.
///Example:
///
///```
///class ApiResponseModel implements ApiResponse
///```
abstract class ApiResponse<TData, TParse> {
  TParse? parseModel;
  TData? data;
  int? statusCode;
  String? message;
  bool? success;

  ApiResponse fromJson(Map<String, dynamic> json, {TParse? parseModel});

  Map<String, dynamic> toJson();
}
