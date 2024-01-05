import 'package:recipe_finder/data/api/response.dart';

abstract class AuthRepository {
  Future<ResponseState> login(Map<String, dynamic> data);
  Future<ResponseState> register(Map<String, dynamic> data);
  Future<ResponseState> recoveryPassword();
  Future<ResponseState> getUser();
  Future<void> logout();
  Future<bool> isTokenExpired(String token);
}
