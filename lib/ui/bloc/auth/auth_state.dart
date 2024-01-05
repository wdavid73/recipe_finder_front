part of 'auth_bloc.dart';

enum AuthStatus { none, isCreate, hasError }

enum LoginStatus { none, isLogged, hasError }

class AuthState extends Equatable {
  final bool loading;
  final AuthStatus status;
  final LoginStatus loginStatus;
  final String errorMessage;
  final String token;
  final User? user;

  const AuthState({
    this.loading = false,
    this.status = AuthStatus.none,
    this.loginStatus = LoginStatus.none,
    this.errorMessage = '',
    this.token = '',
    this.user,
  });

  @override
  List<Object> get props => [loading];

  AuthState copyWith({
    bool? loading,
    AuthStatus? status,
    LoginStatus? loginStatus,
    String? errorMessage,
    String? token,
    User? user,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return "AuthState: $loading, $status, $loginStatus";
  }
}
