import '../../enums/custom_duration.dart';
import '../models/api_response.dart';
import '../models/api_response_model.dart';
import '../../utils/mixins/json_entity_converter_mixin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../../services/abstract/remote_data_service.dart';
import '../../services/constants/remote_data_messages.dart';
import '../../utils/results/error_data_result.dart';
import '../../utils/results/error_result.dart';
import '../../utils/results/result.dart';
import '../../utils/results/data_result.dart';
import '../../utils/results/success_data_result.dart';
import '../../utils/results/success_result.dart';

class HttpRemoteDataManager
    with JsonEntityConverterMixin
    implements RemoteDataService {
  static HttpRemoteDataManager? _instance;

  static HttpRemoteDataManager getInstance(
      {String? baseUrl, Map<String, String>? header, CustomDuration? timeout}) {
    _instance ??= HttpRemoteDataManager._init(
      baseUrl: baseUrl,
      header: header,
      timeout: timeout,
    );
    return _instance!;
  }

  HttpRemoteDataManager._init({
    String? baseUrl,
    Map<String, String>? header,
    CustomDuration? timeout,
  })  : _baseUrl = baseUrl ?? 'https://jsonplaceholder.typicode.com/',
        _header = header ?? {'Content-type': 'application/json; charset=UTF-8'},
        _timeout = timeout ?? CustomDuration.normal,
        _client = http.Client();

  final http.Client _client;

  String _baseUrl;
  Map<String, String> _header;
  CustomDuration _timeout;

  @override
  Map<String, String> get baseHeader => _header;

  @override
  String get baseUrl => _baseUrl;

  @override
  Duration get getTimeout => _timeout.rawValue();

  @override
  RemoteDataService setUrl(String url) {
    _baseUrl = url;
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  RemoteDataService setHeader(Map<String, String> header) {
    _header = header;
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  RemoteDataService setTimeout(CustomDuration timeout) {
    _timeout = timeout;
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  RemoteDataService addBearerTokenToHeader(String token) {
    _header['Authorization'] = 'Bearer $token';
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  RemoteDataService addToHeader(String key, String value) {
    _header[key] = value;
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  Future<DataResult<TReturn>> getData<TReturn, TModel>({
    required String endpoint,
    required TModel parseModel,
    String? query,
    Map<String, String>? headers,
    CustomDuration? timeout,
  }) async {
    var result = await _baseGet(
      endpoint: endpoint,
      query: query,
      headers: headers,
      timeout: timeout,
    );

    return result.success
        ? convertEntity<TReturn, TModel>(
            parseModel, jsonDecode(result.data?.body ?? emptyJson))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<ApiResponse<TReturn, TModel>> getDataByApiResponse<TReturn, TModel>({
    required String endpoint,
    TModel? parseModel,
    String? query,
    Map<String, String>? headers,
    ApiResponse<TReturn, TModel>? apiResponse,
    CustomDuration? timeout,
  }) async {
    var result = await _baseGet(
      endpoint: endpoint,
      query: query,
      headers: headers,
      timeout: timeout,
    );

    if (!result.success) {
      apiResponse?.message = result.message;
      apiResponse?.success = false;
      return apiResponse ??
          ApiResponseModel(message: result.message, success: false);
    }

    return convertApiResponse<TReturn, TModel>(
      jsonBody: result.data?.body,
      apiResponse: apiResponse ?? ApiResponseModel<TReturn, TModel>(),
      parseModel: parseModel,
    );
  }

  @override
  Future<DataResult<String>> getByResponseJson({
    required String endpoint,
    String? query,
    Map<String, String>? headers,
    CustomDuration? timeout,
  }) async {
    var result = await _baseGet(
      endpoint: endpoint,
      query: query,
      headers: headers,
      timeout: timeout,
    );

    return result.success
        ? SuccessDataResult(data: jsonDecode(result.data?.body ?? emptyJson))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<Result> post({
    required String endpoint,
    required body,
    Map<String, String>? headers,
    CustomDuration? timeout,
  }) async {
    var result = await _basePost(
      endpoint: endpoint,
      body: body,
      headers: headers,
      timeout: timeout,
    );

    return result.success
        ? SuccessResult()
        : ErrorResult(message: result.message) as Result;
  }

  @override
  Future<DataResult<String>> postByResponseJson({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    Map<String, String>? headers,
    CustomDuration? timeout,
  }) async {
    var result = await _basePost(
      endpoint: endpoint,
      body: isJsonEncode ? jsonEncode(body) : body,
      headers: headers,
      timeout: timeout,
    );

    return result.success
        ? SuccessDataResult(data: jsonDecode(result.data?.body ?? emptyJson))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<DataResult<TReturn>> postByData<TReturn, TParse>({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    required TParse parseModel,
    Map<String, String>? headers,
    ApiResponse<TReturn, TParse>? apiResponse,
    CustomDuration? timeout,
  }) async {
    var result = await _basePost(
      endpoint: endpoint,
      body: isJsonEncode ? jsonEncode(body) : body,
      headers: headers,
      timeout: timeout,
    );

    return result.success
        ? convertEntity<TReturn, TParse>(
            parseModel, jsonDecode(result.data?.body ?? emptyJson))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<ApiResponse<TReturn, TParse>> postByResponseData<TReturn, TParse>({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    required TParse parseModel,
    Map<String, String>? headers,
    ApiResponse<TReturn, TParse>? apiResponse,
    CustomDuration? timeout,
  }) async {
    var result = await _basePost(
      endpoint: endpoint,
      body: isJsonEncode ? jsonEncode(body) : body,
      headers: headers,
      timeout: timeout,
    );

    if (!result.success) {
      apiResponse?.message = result.message;
      apiResponse?.success = false;
      return apiResponse ??
          ApiResponseModel(message: result.message, success: false);
    }

    return convertApiResponse<TReturn, TParse>(
      jsonBody: result.data?.body,
      apiResponse: apiResponse ?? ApiResponseModel<TReturn, TParse>(),
      parseModel: parseModel,
    );
  }

  Future<DataResult<http.Response>> _baseGet({
    required String endpoint,
    String? query,
    Map<String, String>? headers,
    CustomDuration? timeout,
  }) async {
    try {
      var response = await _client
          .get(
            Uri.parse(_getUrl(endpoint, query)),
            headers: headers ?? baseHeader,
          )
          .timeout(timeout?.rawValue() ?? getTimeout);

      return response.statusCode == HttpStatus.ok
          ? SuccessDataResult<http.Response>(data: response)
          : ErrorDataResult(message: RemoteDataMessages.sendDataError);
    } catch (error) {
      return ErrorDataResult(message: error.toString());
    }
  }

  Future<DataResult<http.Response>> _basePost({
    required String endpoint,
    Object? body,
    Map<String, String>? headers,
    CustomDuration? timeout,
  }) async {
    try {
      var response = await _client
          .post(
            Uri.parse(_getUrl(endpoint, null)),
            headers: headers ?? baseHeader,
            body: body,
          )
          .timeout(timeout?.rawValue() ?? getTimeout);

      return response.statusCode == HttpStatus.ok
          ? SuccessDataResult(data: response)
          : ErrorDataResult(
              data: response, message: RemoteDataMessages.fetchDataError);
    } catch (error) {
      return ErrorDataResult(message: error.toString());
    }
  }

  String _getUrl(String endpoint, String? query) {
    return query?.isNotEmpty ?? false
        ? '$baseUrl/$endpoint?$query'
        : '$baseUrl/$endpoint';
  }
}
