import 'package:dio/dio.dart';
import 'package:front_scaffold_flutter/data/api/api_client.dart';
import 'package:front_scaffold_flutter/data/api/api_endpoint.dart';
import 'package:front_scaffold_flutter/data/api/response.dart';
import 'package:front_scaffold_flutter/domain/repository/example_repository.dart';

class ExampleRepositoryImpl extends ExampleRepository {
  final ApiClient _client;

  ExampleRepositoryImpl(this._client);

  @override
  Future<ResponseState> get() async {
    try {
      final response = await _client.get('$ApiEndpoint');
      return ResponseSuccess(null, response.statusCode!);
    } catch (e) {
      return ResponseFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(
            path: '$ApiEndpoint',
          ),
        ),
      );
    }
  }
}
