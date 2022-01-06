import '../../enums/custom_duration.dart';
import '../models/api_response.dart';

import '../../utils/results/data_result.dart';
import '../../utils/results/result.dart';

///Access to data on API using http package.
abstract class RemoteDataService {
  ///Base url for get and post datas.
  String get baseUrl;

  ///API header
  Map<String, String> get baseHeader;

  ///Gets timeout of http methods.
  Duration get getTimeout;

  ///Set base url of remote service with custom url.
  RemoteDataService setUrl(String url);

  ///Set remote service header with custom header
  RemoteDataService setHeader(Map<String, String> header);

  ///Set timeout of http methods.
  RemoteDataService setTimeout(CustomDuration timeout);

  ///Add custom token to service header
  RemoteDataService addBearerTokenToHeader(String token);

  ///Add key and value to service header
  RemoteDataService addToHeader(String key, String value);

  ///Use for get data on API. If you want to use that function
  ///you must set return type and parse model type.
  ///
  ///`TReturn:` is type of return.
  ///
  ///`TModel:` is model of json data. If sets null which mean
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[parseModel]` : required for parsing to response body.
  ///
  ///And also you can use `query` and `header`
  Future<DataResult<TReturn>> getData<TReturn, TModel>({
    required String endpoint,
    required TModel parseModel,
    String? query,
    Map<String, String>? headers,
    CustomDuration? timeout,
  });

  ///Use for get data on API by `ApiResponse` model. If you want to use that function
  ///you must set return type and parse model type.
  ///
  ///`TReturn:` is type of return.
  ///
  ///`TModel:` is model of json data. If sets null which mean
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[parseModel]` : required for parsing to response body.
  ///
  ///And also you can use `query` and `header`
  Future<ApiResponse<TReturn, TModel>> getDataByApiResponse<TReturn, TModel>({
    required String endpoint,
    TModel? parseModel,
    String? query,
    Map<String, String>? headers,
    ApiResponse<TReturn, TModel>? apiResponse,
    CustomDuration? timeout,
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
    CustomDuration? timeout,
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
    CustomDuration? timeout,
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
    required Object body,
    bool isJsonEncode = true,
    Map<String, String>? headers,
    CustomDuration? timeout,
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
  Future<DataResult<TReturn>> postByData<TReturn, TParse>({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    required TParse parseModel,
    Map<String, String>? headers,
    CustomDuration? timeout,
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
  Future<ApiResponse<TReturn, TParse>> postByResponseData<TReturn, TParse>({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    required TParse parseModel,
    Map<String, String>? headers,
    ApiResponse<TReturn, TParse>? apiResponse,
    CustomDuration? timeout,
  });
}
