import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/repository/category_repository.dart';

class CategoryUseCase {
  final CategoryRepository _categoryRepository;

  CategoryUseCase(this._categoryRepository);

  Future<ResponseState> get(Map<String, dynamic>? queryParams) async {
    final response = await _categoryRepository.get(queryParams);
    return response;
  }
}
