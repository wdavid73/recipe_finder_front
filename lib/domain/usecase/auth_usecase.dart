import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<ResponseState> register(Map<String, dynamic> data) async {
    final response = await _authRepository.register(data);
    return response;
  }

  Future<ResponseState> login(Map<String, dynamic> data) async {
    final response = await _authRepository.login(data);
    return response;
  }

  Future<ResponseState> getUser() async {
    final response = await _authRepository.getUser();
    return response;
  }
}