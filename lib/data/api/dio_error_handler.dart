import 'package:dio/dio.dart';

ErrorHandler handlerErrorResponse(
    DioException err, ErrorInterceptorHandler handler) {
  final dynamic responseData = err.response!.data;
  final String? errorMessage = buildErrorMessage(responseData);

  return ErrorHandler(
    requestOptions: err.requestOptions,
    message: errorMessage,
    error: err.error,
  );
}

String? buildErrorMessage(dynamic responseData) {
  final List<String> errorMessages = [];
  void processKeyValuePair(dynamic key, dynamic value) {
    if (value is List) {
      errorMessages.add("$key: ${value.join(', ')}");
    } else {
      errorMessages.add("$key: $value");
    }
  }

  responseData.forEach(processKeyValuePair);
  final String? errorMessage =
      errorMessages.isNotEmpty ? errorMessages.join('\n') : null;
  return errorMessage;
}

class ErrorHandler {
  final String? message;
  final Object? error;
  final RequestOptions requestOptions;

  ErrorHandler({
    required this.requestOptions,
    this.message,
    this.error,
  });
}
