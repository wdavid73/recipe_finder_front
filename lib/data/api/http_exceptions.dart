import 'package:dio/dio.dart';
import 'package:recipe_finder/i10n/app_localizations.dart';
import 'package:recipe_finder/utils/navigation_key.dart';

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
    if (navigatorKey.currentState != null) {
      AppLocalizations appLocalizations =
          AppLocalizations.of(navigatorKey.currentState!.context);
      return appLocalizations.translate('not_internet');
    }
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceeded extends DioException {
  DeadlineExceeded(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    if (navigatorKey.currentState != null) {
      AppLocalizations appLocalizations =
          AppLocalizations.of(navigatorKey.currentState!.context);
      return appLocalizations.translate('receive_time_out');
    }
    return 'The connection has timed out, please try again.';
  }
}

class BadCertificate extends DioException {
  BadCertificate(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    if (navigatorKey.currentState != null) {
      AppLocalizations appLocalizations =
          AppLocalizations.of(navigatorKey.currentState!.context);
      return appLocalizations.translate('bad_certificate');
    }
    return 'The certificate is not reliable.';
  }
}

class BadResponse extends DioException {
  BadResponse(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    if (navigatorKey.currentState != null) {
      AppLocalizations appLocalizations =
          AppLocalizations.of(navigatorKey.currentState!.context);
      return appLocalizations.translate('bad_response');
    }
    return 'Error processing the response';
  }
}

class Unknown extends DioException {
  Unknown(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    if (navigatorKey.currentState != null) {
      AppLocalizations appLocalizations =
          AppLocalizations.of(navigatorKey.currentState!.context);
      return appLocalizations.translate('unknown');
    }
    return 'unknown server error';
  }
}

class ConnectionTimeout extends DioException {
  ConnectionTimeout(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    if (navigatorKey.currentState != null) {
      AppLocalizations appLocalizations =
          AppLocalizations.of(navigatorKey.currentState!.context);
      return appLocalizations.translate('connection_time_out');
    }
    return 'Connection timeout has been exceeded';
  }
}

class SendTimeout extends DioException {
  SendTimeout(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    if (navigatorKey.currentState != null) {
      AppLocalizations appLocalizations =
          AppLocalizations.of(navigatorKey.currentState!.context);
      return appLocalizations.translate('send_time_out');
    }
    return 'Send lead time has been exceeded';
  }
}

class ApiException extends DioException {
  ApiException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    if (navigatorKey.currentState != null) {
      AppLocalizations appLocalizations =
          AppLocalizations.of(navigatorKey.currentState!.context);
      return appLocalizations.translate('unknown');
    }
    return 'An unknown error occurred processing the request.';
  }
}

class GoogleSignInError {
  final String message;

  GoogleSignInError(this.message);

  @override
  String toString() => "GoogleSignInError: $message";
}
