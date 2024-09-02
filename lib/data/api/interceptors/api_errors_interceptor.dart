import 'package:dio/dio.dart';
import 'package:recipe_finder/data/api/dio_error_handler.dart';
import 'package:recipe_finder/data/api/http_exceptions.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/utils/navigation_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiErrorsInterceptor extends Interceptor {
  final Dio dio;
  ApiErrorsInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      int statusCode = err.response!.statusCode!;
      ErrorHandler errorHandler = handlerErrorResponse(err, handler);

      if (statusCode == 401) {
        await _handleUnauthorizedError(errorHandler);
      }

      return handler.reject(
        _getExceptionForStatusCode(statusCode, errorHandler),
      );
    } else {
      return handler.reject(_getExceptionForDioType(err));
    }
  }

  Future<void> _handleUnauthorizedError(ErrorHandler errorHandler) async {
    await _clearSharedPreferences();
    _navigateToLogin();
  }

  Future<void> _clearSharedPreferences() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void _navigateToLogin() {
    NavigationManager.goAndRemove(navigatorKey.currentContext!, 'login');
  }

  DioException _getExceptionForStatusCode(
      int statusCode, ErrorHandler errorHandler) {
    switch (statusCode) {
      case 400:
        return BadRequestException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );

      case 401:
        return UnauthorizedException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 404:
        return NotFoundException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 422:
        return ConflictException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      case 500:
        return InternalServerErrorException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
      default:
        return UnknownException(
          requestOptions: errorHandler.requestOptions,
          error: errorHandler.error,
          message: errorHandler.message,
        );
    }
  }

  DioException _getExceptionForDioType(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeout(err.requestOptions);
      case DioExceptionType.sendTimeout:
        return SendTimeout(err.requestOptions);
      case DioExceptionType.receiveTimeout:
        return DeadlineExceeded(err.requestOptions);
      case DioExceptionType.connectionError:
        return NoInternetConnection(err.requestOptions);
      case DioExceptionType.badCertificate:
        return BadCertificate(err.requestOptions);
      case DioExceptionType.badResponse:
        return BadResponse(err.requestOptions);
      case DioExceptionType.unknown:
        return Unknown(err.requestOptions);
      case DioExceptionType.cancel:
        return Unknown(err.requestOptions);
    }
  }
}
