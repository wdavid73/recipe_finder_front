import 'package:dio/dio.dart';

class ApiErrorsInterceptor extends Interceptor {
  final Dio dio;
  ApiErrorsInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      int statusCode = err.response!.statusCode!;
      switch (statusCode) {
        case 400:
          return handler.reject(
            DioException(
              error: err.error,
              message: err.message,
              requestOptions: err.requestOptions,
            ),
          );
        case 401:
          return handler.reject(
            DioException(
              error: err.error,
              message: err.message,
              requestOptions: err.requestOptions,
            ),
          );
        case 404:
          return handler.reject(
            DioException(
              error: err.error,
              message: err.message,
              requestOptions: err.requestOptions,
            ),
          );
        case 422:
          return handler.reject(
            DioException(
              error: err.error,
              message: err.message,
              requestOptions: err.requestOptions,
            ),
          );
        case 500:
          return handler.reject(
            DioException(
              error: err.error,
              message: err.message,
              requestOptions: err.requestOptions,
            ),
          );
        default:
          return handler.resolve(
            Response(
              requestOptions: err.requestOptions,
              data: err.response!.data!,
              statusCode: statusCode,
              statusMessage:
                  'An unknown error occurred processing the request.',
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
          throw DeadlineExceededException(err.requestOptions);
        case DioExceptionType.connectionError:
          throw NoInternetConnectionException(err.requestOptions);
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
  final int statusCode;

  BadRequestException(RequestOptions r, this.statusCode)
      : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request: $statusCode';
  }
}

class UnauthorizedException extends DioException {
  final int statusCode;

  UnauthorizedException(RequestOptions r, this.statusCode)
      : super(requestOptions: r);

  @override
  String toString() {
    return 'Unauthorized: $statusCode';
  }
}

class NotFoundException extends DioException {
  final int statusCode;

  NotFoundException(RequestOptions r, this.statusCode)
      : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found: $statusCode';
  }
}

class ConflictException extends DioException {
  final int statusCode;

  ConflictException(RequestOptions r, this.statusCode)
      : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class InternalServerErrorException extends DioException {
  final int statusCode;

  InternalServerErrorException(RequestOptions r, this.statusCode)
      : super(requestOptions: r);

  @override
  String toString() {
    return 'Internal Server Error: $statusCode';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

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
    return 'Error al procesar la respuesta ';
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
    return 'Shend lead time has been exceeded';
  }
}

class ApiException extends DioException {
  ApiException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'An unknown error occurred processing the request.';
  }
}
