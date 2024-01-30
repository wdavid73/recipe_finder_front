import 'package:recipe_finder/data/api/response.dart';

abstract class RecipeRepository {
  Future<ResponseState> get({Map<String, dynamic>? queryParams});
  Future<ResponseState> getLastFive({Map<String, dynamic>? queryParams});
  Future<ResponseState> create({required dynamic body});
}
