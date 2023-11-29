import 'package:front_scaffold_flutter/data/api/response.dart';

abstract class ExampleRepository {
  Future<ResponseState> get();
}
