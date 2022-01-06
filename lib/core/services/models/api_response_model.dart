import 'api_response.dart';
import 'entitiy_model.dart';

class ApiResponseModel<TData, TParse> implements ApiResponse<TData, TParse> {
  @override
  TParse? parseModel;

  @override
  TData? data;

  @override
  String? message;

  @override
  int? statusCode;

  @override
  bool? success;

  ApiResponseModel({
    this.data,
    this.message,
    this.statusCode,
    this.success,
    this.parseModel,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json,
      {TParse? parseModel}) {
    var model = ApiResponseModel<TData, TParse>(
      message: json['Message'],
      success: json['Success'],
      statusCode: json['StatusCode'],
    );

    if (parseModel == null) return model;

    var jsonData = json['Result'];
    if (jsonData == null) return model;

    try {
      if (parseModel is EntityModel) {
        if (jsonData is Map<String, dynamic>) {
          model.data = parseModel.fromJson(jsonData);
        } else if (jsonData is List) {
          model.data = jsonData
              .map((element) => parseModel.fromJson(element))
              .cast<TParse>()
              .toList() as TData;
        } else if (jsonData is TData) {
          model.data = jsonData;
        }

        return model;
      } else {
        if (jsonData is TData) {
          model.data = jsonData;
        } else if (jsonData is String && TData is num) {
          model.data = (num.tryParse(jsonData) ?? -1) as TData;
        } else if (jsonData is List) {
          model.data = jsonData
              .map((element) => element as TParse)
              .cast<TParse>()
              .toList() as TData;
        }

        return model;
      }
    } catch (error) {
      model.success = false;
      model.message = 'Error: $error'
          ' | Data type: ${jsonData.runtimeType}'
          ' | Parse Type: ${TParse.runtimeType}'
          ' | Return Type: ${TData.runtimeType}';
      return model;
    }
  }

  @override
  ApiResponseModel fromJson(Map<String, dynamic> json, {TParse? parseModel}) {
    return ApiResponseModel.fromJson(json, parseModel: parseModel);
  }

  @override
  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (data != null) {
      json['Result'] = data;
    }

    if (message != null) {
      json['Message'] = message;
    }

    if (success != null) {
      json['Success'] = success;
    }

    if (statusCode != null) {
      json['StatusCode'] = statusCode;
    }

    return json;
  }
}
