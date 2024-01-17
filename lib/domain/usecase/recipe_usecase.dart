import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/repository/recipe_repository.dart';

class RecipeUseCase {
  final RecipeRepository _recipeRepository;

  RecipeUseCase(this._recipeRepository);

  Future<ResponseState> get({Map<String, dynamic>? queryParams}) async {
    final response = await _recipeRepository.get(queryParams: queryParams);
    return response;
  }

  Future<ResponseState> create({required dynamic body}) async {
    final response = await _recipeRepository.create(body: body);
    return response;
  }
}
