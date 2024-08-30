import 'dart:async';

import 'package:dio/dio.dart';
import 'package:recipe_finder/data/api/api_client.dart';
import 'package:recipe_finder/data/api/api_endpoint.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/data/models/user.dart';
import 'package:recipe_finder/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final ApiClient _client;
  AuthRepositoryImpl(this._client);

  @override
  Future<bool> isTokenExpired(String token) => throw UnimplementedError();

  @override
  Future<ResponseState> login(Map<String, dynamic> data) async {
    try {
      final response = await _client.post('${ApiEndpoint.auth}/login/', data);
      return ResponseSuccess(response.data, response.statusCode!);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(
        DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(
            path: "${ApiEndpoint.auth}/login",
          ),
        ),
      );
    }
  }

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

  @override
  Future<void> logout() => throw UnimplementedError();

  @override
  Future<ResponseState> recoveryPassword(Map<String, dynamic> data) async {
    try {
      final response =
          await _client.post('${ApiEndpoint.auth}/recovery_password/', data);
      return ResponseSuccess(response, response.statusCode!);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(
        DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(
            path: "${ApiEndpoint.auth}/get_user",
          ),
        ),
      );
    }
  }

  @override
  Future<ResponseState> getUser() async {
    try {
      final response = await _client.get('${ApiEndpoint.auth}/get_user');
      User user = User.fromJson(response.data);
      return ResponseSuccess(user, response.statusCode!);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(
        DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(
            path: "${ApiEndpoint.auth}/get_user",
          ),
        ),
      );
    }
  }

  @override
  Future<ResponseState> getFullUser() async {
    try {
      final response = await _client.get('${ApiEndpoint.auth}/get_full_user');
      FullUser user = FullUser.fromJson(response.data);
      return ResponseSuccess(user, response.statusCode!);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(
        DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(
            path: "${ApiEndpoint.auth}/get_full_user",
          ),
        ),
      );
    }
  }

  @override
  Future<ResponseState> confirmEmail(String email) async {
    try {
      final response = await _client.post(
        '${ApiEndpoint.auth}/confirm_email',
        {"email": email},
      );
      return ResponseSuccess(true, response.statusCode!);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(
        DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(
            path: "${ApiEndpoint.auth}/confirm_email",
          ),
        ),
      );
    }
  }
}
