import '../../services/models/base_entitiy_model.dart';
import '../../utils/results/data_result.dart';
import '../../utils/results/result.dart';

///Access to data on API using http package.
abstract class RemoteDataService {
  ///Base url for get and post datas.
  String get baseUrl;

  ///API header
  Map<String, String> get baseHeader;

  ///Use for get data on API. It needs generic type of `[BaseEntityModel]`.
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[parseModel]` : required for parsing to response body.
  ///
  ///And also you can use `query` and `header`
  Future<DataResult<T>> get<T extends BaseEntityModel>({
    required String endpoint,
    required T parseModel,
    String? query,
    Map<String, String>? headers,
  });

  ///Use for get data on API. It returns json String.
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///And also you can use `header`
  Future<DataResult<String>> getByResponseJson({
    required String endpoint,
    String? query,
    Map<String, String>? headers,
  });

  ///Use for send data to API. It returns `SuccessResult` or `ErrorResult`.
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[body]` : required for send data to API.
  ///
  ///And also you can use `header`
  Future<Result> post({
    required String endpoint,
    required dynamic body,
    Map<String, String>? headers,
  });

  ///Use for send data to API. It returns `SuccessDataResult` or `ErrorDataResult`.
  ///
  ///The model includes response body.
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[body]` : required for send data to API.
  ///
  ///And also you can use `header`
  Future<DataResult<String>> postByResponseJson({
    required String endpoint,
    required dynamic body,
    Map<String, String>? headers,
  });

  ///Use for send data to API. It returns `SuccessResult` or `ErrorResult`.
  ///
  ///The model includes `Return` model of generic `[TReturn]`
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[body]` : required for send data to API. It could be wrapped to the `[BaseEntityModel]`
  ///
  ///`[parseModel]` : required for the parse to the response body. It could be wrapped to the `[BaseEntityModel]`
  ///
  ///And also you can use `header`
  Future<DataResult<TReturn>> postByResponseData<TReturn,
      TData extends BaseEntityModel, TParse extends BaseEntityModel>({
    required String endpoint,
    required TData body,
    required TParse parseModel,
    Map<String, String>? headers,
  });
}
