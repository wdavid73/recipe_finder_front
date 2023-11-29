import 'package:recipe_finder/data/api/response.dart';

abstract class ExampleRepository {
  Future<ResponseState> get();
}
