import 'package:dio/dio.dart';
import 'package:front_scaffold_flutter/data/api/api_endpoint.dart';
import 'package:front_scaffold_flutter/data/api/interceptors/api_errors_interceptor.dart';
import 'package:front_scaffold_flutter/data/api/interceptors/api_token_interceptor.dart';

String baseUrl = ApiEndpoint.baseUrl;

class ApiClient {
  final _client = createDio();

  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  static Dio createDio() {
    final dio = Dio(createBaseOptions());
    dio.interceptors.add(ApiTokenInterceptor(dio));
    dio.interceptors.add(ApiErrorsInterceptor(dio));
    return dio;
  }

  static BaseOptions createBaseOptions() => BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
        headers: {'Content-Type': 'application/json'},
      );

  Future<Response> get(String url, {Map<String, dynamic>? queryParams}) =>
      _client.get(url, queryParameters: queryParams);
  Future<Response> post(String url, dynamic body) =>
      _client.post(url, data: body);
  Future<Response> put(String url, dynamic body) =>
      _client.put(url, data: body);
  Future<Response> patch(String url, dynamic body) =>
      _client.patch(url, data: body);
  Future<Response> delete(String url, dynamic body) => _client.delete(url);

  static ApiClient get instance {
    ApiClient defaultAppClientInstance = ApiClient();
    return defaultAppClientInstance;
  }
}
