import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/repository/example_repository.dart';

class ExampleUseCase {
  final ExampleRepository _exampleRepository;

  ExampleUseCase(this._exampleRepository);

  Future<ResponseState> get() async {
    final response = await _exampleRepository.get();
    return response;
  }
}
