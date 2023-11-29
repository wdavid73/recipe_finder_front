enum ResponseErrors {
  netWorkRequestFailed,
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  invalidCredential,
  weakPassword,
  operationNotAllowed,
  requiresRecentLogin,
  unknownError,
  invalidActionCode
}

ResponseErrors stringToResponseErrors(String code) {
  switch (code) {
    case 'network-request-failed':
      return ResponseErrors.netWorkRequestFailed;
    case 'invalid-email':
      return ResponseErrors.invalidEmail;
    case 'user-disabled':
      return ResponseErrors.userDisabled;
    case 'user-not-found':
      return ResponseErrors.userNotFound;
    case 'wrong-password':
      return ResponseErrors.wrongPassword;
    case 'email-already-in-use':
      return ResponseErrors.emailAlreadyInUse;
    case 'invalid-credential':
      return ResponseErrors.invalidCredential;
    case 'weak-password':
      return ResponseErrors.weakPassword;
    case 'operation-not-allowed':
      return ResponseErrors.operationNotAllowed;
    case 'requires-recent-login':
      return ResponseErrors.requiresRecentLogin;
    case 'invalid-action-code':
      return ResponseErrors.invalidActionCode;
    default:
      return ResponseErrors.unknownError;
  }
}

class ResponseErrorMessages {
  static const Map<ResponseErrors, String> messages = {
    ResponseErrors.netWorkRequestFailed: 'Error de red',
    ResponseErrors.invalidEmail: 'Correo inválido',
    ResponseErrors.userDisabled: 'Usuario deshabilitado',
    ResponseErrors.userNotFound: 'Usuario no encontrado',
    ResponseErrors.wrongPassword: 'Contraseña incorrecta',
    ResponseErrors.emailAlreadyInUse: 'El correo ya esta registrado',
    ResponseErrors.invalidCredential: 'Credenciales inválidas',
    ResponseErrors.weakPassword: 'Contraseña, débil mínimo 6 caracteres',
    ResponseErrors.operationNotAllowed: 'Operación no permitida',
    ResponseErrors.requiresRecentLogin: 'Inicia sesión nuevamente',
    ResponseErrors.invalidActionCode:
        'Código de restablecimiento de contraseña no válido',
    ResponseErrors.unknownError: 'Error desconocido',
  };

  static String? message(ResponseErrors? error) {
    if (error == null) return null;
    return messages[error];
  }
}
