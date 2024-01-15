import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/repository/ingredient_repository.dart';

class IngredientUseCase {
  final IngredientRepository _ingredientRepository;

  IngredientUseCase(this._ingredientRepository);

  Future<ResponseState> get({Map<String, dynamic>? queryParams}) async {
    final response = await _ingredientRepository.get(queryParams);
    return response;
  }
}
