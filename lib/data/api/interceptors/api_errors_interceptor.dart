import 'package:dio/dio.dart';
import 'package:recipe_finder/data/api/dio_error_handler.dart';

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
          return handler.reject(
            DioException(
              error: err.error,
              message: err.message,
              type: DioExceptionType.connectionTimeout,
              requestOptions: err.requestOptions,
            ),
          );
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

class BadRequestException extends DioException {
  BadRequestException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [BadRequest]: $message';
  }
}

class UnauthorizedException extends DioException {

  UnauthorizedException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [Unauthorized]: $message';
  }
}

class NotFoundException extends DioException {

  NotFoundException({
    required super.requestOptions,
    super.error,
    super.message,
  });

 @override
  String toString() {
    return 'DioException [NotFound]: $message';
  }
}

class ConflictException extends DioException {
  ConflictException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [Conflict]: $message';
  }
}

class InternalServerErrorException extends DioException {

  InternalServerErrorException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [InternalServerError]: $message';
  }
}

class UnknownException extends DioException {

  UnknownException({
    required super.requestOptions,
    super.error,
    super.message,
  });

  @override
  String toString() {
    return 'DioException [UnknownException]: $message';
  }
}

class NoInternetConnection extends DioException {
  NoInternetConnection(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceeded extends DioException {
  DeadlineExceeded(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class BadCertificate extends DioException {
  BadCertificate(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The certificate is not reliable.';
  }
}

class BadResponse extends DioException {
  BadResponse(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Error processing the response';
  }
}

class Unknown extends DioException {
  Unknown(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'unknown server error';
  }
}

class ConnectionTimeout extends DioException {
  ConnectionTimeout(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection timeout has been exceeded';
  }
}

class SendTimeout extends DioException {
  SendTimeout(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Send lead time has been exceeded';
  }
}

class ApiException extends DioException {
  ApiException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'An unknown error occurred processing the request.';
  }
}