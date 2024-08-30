import 'package:recipe_finder/data/api/response.dart';

abstract class AuthRepository {
  Future<ResponseState> login(Map<String, dynamic> data);
  Future<ResponseState> register(Map<String, dynamic> data);
  Future<ResponseState> recoveryPassword(Map<String, dynamic> data);
  Future<ResponseState> getUser();
  Future<ResponseState> getFullUser();
  Future<void> logout();
  Future<bool> isTokenExpired(String token);
  Future<ResponseState> confirmEmail(String email);
}
