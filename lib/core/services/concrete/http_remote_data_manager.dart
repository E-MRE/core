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
import '../models/base_entitiy_model.dart';

part '../../utils/entity_model_parser.dart';

class HttpRemoteDataManager implements RemoteDataService {
  HttpRemoteDataManager() : _client = http.Client();

  final http.Client _client;

  @override
  Map<String, String> get baseHeader => {
        'Content-type': 'application/json; charset=UTF-8',
      };

  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com/';

  @override
  Future<DataResult<T>> get<T extends BaseEntityModel>({
    required String endpoint,
    required T parseModel,
    String? query,
    Map<String, String>? headers,
  }) async {
    var result =
        await _baseGet(endpoint: endpoint, query: query, headers: headers);

    return result.success
        ? _EntityModelParser.parseModel<T, T>(
            parseModel, jsonDecode(result.data?.body ?? '{}'))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<DataResult<String>> getByResponseJson({
    required String endpoint,
    String? query,
    Map<String, String>? headers,
  }) async {
    var result =
        await _baseGet(endpoint: endpoint, query: query, headers: headers);

    return result.success
        ? SuccessDataResult(data: jsonDecode(result.data?.body ?? '{}'))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<Result> post({
    required String endpoint,
    required body,
    Map<String, String>? headers,
  }) async {
    var result =
        await _basePost(endpoint: endpoint, body: body, headers: headers);

    return result.success
        ? SuccessResult()
        : ErrorResult(message: result.message) as Result;
  }

  @override
  Future<DataResult<String>> postByResponseJson({
    required String endpoint,
    required dynamic body,
    Map<String, String>? headers,
  }) async {
    var result = await _basePost(
      endpoint: endpoint,
      body: jsonDecode(body),
      headers: headers,
    );

    return result.success
        ? SuccessDataResult(data: jsonDecode(result.data?.body ?? '{}'))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<DataResult<TReturn>> postByResponseData<TReturn,
      TData extends BaseEntityModel, TParse extends BaseEntityModel>({
    required String endpoint,
    required TData body,
    required TParse parseModel,
    Map<String, String>? headers,
  }) async {
    var result = await _basePost(
        endpoint: endpoint, body: body.toJson(), headers: headers);

    return result.success
        ? _EntityModelParser.parseModel<TReturn, TParse>(
            parseModel, body.toJson())
        : ErrorDataResult(message: result.message);
  }

  Future<DataResult<http.Response>> _baseGet({
    required String endpoint,
    String? query,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await _client.get(
        Uri.parse(_getUrl(endpoint, query)),
        headers: headers ?? baseHeader,
      );

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
  }) async {
    try {
      var response = await _client.post(
        Uri.parse(_getUrl(endpoint, null)),
        headers: headers ?? baseHeader,
        body: body,
      );

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
