part of 'auth_bloc.dart';

enum AuthStatus { none, isCreate, hasError }

enum LoginStatus { none, isLogged, hasError }

enum UserStatus { none, hasError }

class AuthState extends Equatable {
  final bool loading;
  final bool userLoading;
  final AuthStatus status;
  final LoginStatus loginStatus;
  final UserStatus userStatus;
  final String errorMessage;
  final String token;
  final User? user;

  const AuthState({
    this.loading = false,
    this.userLoading = false,
    this.status = AuthStatus.none,
    this.loginStatus = LoginStatus.none,
    this.userStatus = UserStatus.none,
    this.errorMessage = '',
    this.token = '',
    this.user,
  });

  @override
  List<Object> get props => [
        loading,
        userLoading,
        status,
        loginStatus,
        userStatus,
        if (user != null) user!
      ];

  AuthState copyWith({
    bool? loading,
    bool? userLoading,
    AuthStatus? status,
    LoginStatus? loginStatus,
    UserStatus? userStatus,
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
      userLoading: userLoading ?? this.userLoading,
      userStatus: userStatus ?? this.userStatus,
    );
  }

  @override
  String toString() {
    return "AuthState: $loading, $status, $loginStatus";
  }
}
