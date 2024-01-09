import 'package:dio/dio.dart';
import 'package:recipe_finder/data/api/dio_error_handler.dart';
import 'package:recipe_finder/data/api/http_exceptions.dart';
import 'package:recipe_finder/i10n/app_localizations.dart';
import 'package:recipe_finder/utils/navigation_key.dart';

class ApiErrorsInterceptor extends Interceptor {
  final Dio dio;
  ApiErrorsInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      int statusCode = err.response!.statusCode!;
      ErrorHandler errorHandler = handlerErrorResponse(err, handler);
      switch (statusCode) {
        case 400:
          return handler.reject(
            BadRequestException(
              requestOptions: errorHandler.requestOptions,
              error: errorHandler.error,
              message: errorHandler.message,
            ),
          );
        case 401:
          return handler.reject(
            UnauthorizedException(
              requestOptions: errorHandler.requestOptions,
              error: errorHandler.error,
              message: errorHandler.message,
            ),
          );
        case 404:
          return handler.reject(
            NotFoundException(
              requestOptions: errorHandler.requestOptions,
              error: errorHandler.error,
              message: errorHandler.message,
            ),
          );
        case 422:
          return handler.reject(
            ConflictException(
              requestOptions: errorHandler.requestOptions,
              error: errorHandler.error,
              message: errorHandler.message,
            ),
          );
        case 500:
          return handler.reject(
            InternalServerErrorException(
              requestOptions: errorHandler.requestOptions,
              error: errorHandler.error,
              message: errorHandler.message,
            ),
          );
        default:
          return handler.reject(
            UnknownException(
              requestOptions: errorHandler.requestOptions,
              error: errorHandler.error,
              message: errorHandler.message,
            ),
          );
      }
    } else {
      switch (err.type) {
        case DioExceptionType.connectionTimeout:
          throw ConnectionTimeout(err.requestOptions);
        case DioExceptionType.sendTimeout:
          throw SendTimeout(err.requestOptions);
        case DioExceptionType.receiveTimeout:
          throw DeadlineExceeded(err.requestOptions);
        case DioExceptionType.connectionError:
          throw NoInternetConnection(err.requestOptions);
        case DioExceptionType.badCertificate:
          throw BadCertificate(err.requestOptions);
        case DioExceptionType.badResponse:
          throw BadResponse(err.requestOptions);
        case DioExceptionType.unknown:
          throw Unknown(err.requestOptions);
        case DioExceptionType.cancel:
          break;
      }
    }
  }
}
