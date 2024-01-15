import 'package:recipe_finder/data/api/response.dart';

abstract class IngredientRepository {
  Future<ResponseState> get(Map<String, dynamic>? queryParams);
}
