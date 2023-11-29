import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiTokenInterceptor extends Interceptor {
  final Dio dio;
  ApiTokenInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await getToken();

    if (token != null) {
      try {
        if (isExpired(token)) {
          // LOGIC REFRESH TOKEN
        } else {
          options.headers.addAll({
            'Authorization': 'Token $token',
          });
        }
      } catch (e) {
        return handler.resolve(
          Response(
            data: e,
            requestOptions: RequestOptions(path: 'interceptorToken'),
          ),
        );
      }
    }
    return handler.next(options);
  }

  bool isExpired(String token) {
    // Implementa lógica para verificar si el token ha expirado
    // Retorna true si ha expirado, false si aún es válido
    // Puedes usar paquetes como jwt_decode para decodificar el token y verificar su expiración
    return false;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }
}
