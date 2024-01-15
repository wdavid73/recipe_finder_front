import 'package:dio/dio.dart';
import 'package:recipe_finder/data/api/api_client.dart';
import 'package:recipe_finder/data/api/api_endpoint.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/domain/repository/ingredient_repository.dart';

class IngredientRepositoryImpl extends IngredientRepository {
  final ApiClient _client;

  IngredientRepositoryImpl(this._client);

  @override
  Future<ResponseState> get(Map<String, dynamic>? queryParams) async {
    try {
      final response = await _client.get(
        "${ApiEndpoint.ingredient}/",
        queryParams: queryParams,
      );
      List<Ingredient> ingredients = parseIngredients(response.data);
      return ResponseSuccess(ingredients, response.statusCode!);
    } catch (e) {
      DioException error = e as DioException;
      return ResponseFailed(
        DioException(
          error: e,
          type: error.type,
          message: error.message,
          requestOptions: RequestOptions(
            path: ApiEndpoint.ingredient,
          ),
        ),
      );
    }
  }
}
