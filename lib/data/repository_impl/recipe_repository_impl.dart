import 'package:dio/dio.dart';
import 'package:recipe_finder/data/api/api_client.dart';
import 'package:recipe_finder/data/api/api_endpoint.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  final ApiClient _client;

  RecipeRepositoryImpl(this._client);

  @override
  Future<ResponseState> get({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _client.get(
        '${ApiEndpoint.recipe}/',
        queryParams: queryParams,
      );
      print(response.data);
      return ResponseSuccess(null, response.statusCode!);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(path: ApiEndpoint.recipe)));
    }
  }

  @override
  Future<ResponseState> create({required dynamic body}) async {
    try {
      final response = await _client.post('${ApiEndpoint.recipe}/', body);
      print("create recipe ${response.data}");
      return ResponseSuccess(null, 201);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(
        DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(
            path: ApiEndpoint.recipe,
          ),
        ),
      );
    }
  }
}