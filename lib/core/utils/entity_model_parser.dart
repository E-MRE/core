part of '../services/concrete/http_remote_data_manager.dart';

class _EntityModelParser {
  static const _parseError = 'An error occured when try parse model';

  ///It parses any model from json or map. But model should implemented to the BaseEntityModel.
  static DataResult<TReturn>
      parseModel<TReturn, TModel extends BaseEntityModel>(
          TModel model, dynamic data) {
    try {
      if (data is Map<String, dynamic>) {
        return SuccessDataResult(data: model.fromJson(data) as TReturn);
      } else if (data is List) {
        return SuccessDataResult(
            data: data
                .map((element) => model.fromJson(element))
                .cast<TModel>()
                .toList() as TReturn);
      } else if (TReturn is String) {
        return SuccessDataResult(data: data);
      } else if (data != null) {
        return SuccessDataResult(data: jsonDecode(data));
      } else {
        return ErrorDataResult(message: _parseError);
      }
    } catch (error) {
      return ErrorDataResult(message: error.toString());
    }
  }
}
