import 'package:dio/dio.dart';
import 'package:recipe_finder/data/api/api_client.dart';
import 'package:recipe_finder/data/api/api_endpoint.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/repository/example_repository.dart';

class ExampleRepositoryImpl extends ExampleRepository {
  final ApiClient _client;

  ExampleRepositoryImpl(this._client);

  @override
  Future<ResponseState> get() async {
    try {
      final response = await _client.get('${ApiEndpoint.baseUrl}/test');
      return ResponseSuccess(response.data, response.statusCode!);
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
