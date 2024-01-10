import 'package:dio/dio.dart';
import 'package:recipe_finder/data/api/api_client.dart';
import 'package:recipe_finder/data/api/api_endpoint.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/domain/repository/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final ApiClient _client;

  CategoryRepositoryImpl(this._client);

  @override
  Future<ResponseState> get(Map<String, dynamic>? queryParams) async {
    try {
      final response = await _client.get(
        "${ApiEndpoint.category}/",
        queryParams: queryParams,
      );
      List<Category> categories = parseCategories(response.data);
      return ResponseSuccess(categories, response.statusCode!);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(
        DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(
            path: ApiEndpoint.category,
          ),
        ),
      );
    }
  }
}
