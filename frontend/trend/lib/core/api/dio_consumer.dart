import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../injection_container.dart' as di;
import '../error/exceptions.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';
import 'status_code.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppIntercepters>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future<CustomResponse> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on TimeoutException {
      throw const NoInternetConnectionException();
    } catch (e) {
      throw const ServerException();
    }
  }

  @override
  Future<CustomResponse> post(String path,
      {Map<String, dynamic>? body,
      bool formDataIsEnabled = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(path,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body);
      return _handleResponseAsJson(response);
    } on TimeoutException {
      throw const NoInternetConnectionException();
    } catch (e) {
      throw const ServerException();
    }
  }

  @override
  Future<CustomResponse> put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await client.put(path, queryParameters: queryParameters, data: body);

      return _handleResponseAsJson(response);
    } on TimeoutException {
      throw const NoInternetConnectionException();
    } catch (e) {
      throw const ServerException();
    }
  }

  Future<CustomResponse> _handleResponseAsJson(
      Response<dynamic> response) async {
    final responseJson = jsonDecode(response.data.toString());
    return CustomResponse(
        data: responseJson, statusCode: response.statusCode ?? 0);
  }
}
