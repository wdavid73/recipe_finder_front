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

  Future<ResponseState> getFullUser() async {
    final response = await _authRepository.getFullUser();
    return response;
  }

  Future<ResponseState> confirmEmail(String email) async {
    final response = await _authRepository.confirmEmail(email);
    return response;
  }

  Future<ResponseState> recoveryPassword(Map<String, dynamic> data) async {
    final response = await _authRepository.recoveryPassword(data);
    return response;
  }

  Future<ResponseState> setGoogleAccount() async {
    final response = await _authRepository.setGoogleAccount();
    return response;
  }

  Future<ResponseState> googleSignIn(String data) async {
    final response = await _authRepository.googleSignIn(data);
    return response;
  }

  Future<ResponseState> logout() async {
    return await _authRepository.logout();
  }
}
