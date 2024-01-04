import 'package:dio/dio.dart';
import 'package:recipe_finder/data/api/api_client.dart';
import 'package:recipe_finder/data/api/api_endpoint.dart';
import 'package:recipe_finder/data/api/interceptors/api_errors_interceptor.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final ApiClient _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<bool> isTokenExpired(String token) => throw UnimplementedError();

  @override
  Future<ResponseState> login(Map<String, dynamic> data) =>
      throw UnimplementedError();

  @override
  Future<void> logout() => throw UnimplementedError();

  @override
  Future<ResponseState> recoveryPassword() => throw UnimplementedError();

  @override
  Future<ResponseState> register(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        '${ApiEndpoint.auth}/register/',
        data,
      );
      return ResponseSuccess(response, response.statusCode!);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(
        DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(
            path: "${ApiEndpoint.auth}/register",
          ),
        ),
      );
    }
  }
}
