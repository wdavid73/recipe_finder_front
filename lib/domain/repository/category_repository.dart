import 'package:recipe_finder/data/api/response.dart';

abstract class CategoryRepository {
  Future<ResponseState> get(Map<String, dynamic>? queryParams);
}
