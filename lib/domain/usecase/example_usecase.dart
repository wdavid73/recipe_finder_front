import 'package:front_scaffold_flutter/data/api/response.dart';
import 'package:front_scaffold_flutter/domain/repository/example_repository.dart';

class ExampleUseCase {
  final ExampleRepository _exampleRepository;

  ExampleUseCase(this._exampleRepository);

  Future<ResponseState> get() async {
    final response = await _exampleRepository.get();
    return response;
  }
}
