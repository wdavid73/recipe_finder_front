part of 'auth_bloc.dart';

enum AuthStatus { none, isCreate, hasError }

enum LoginStatus { none, isLogged, hasError }

enum UserStatus { none, hasError, isSuccess }

enum RecoveryStatus { none, isSuccess, hasError }

enum GoogleSignInStatus { none, isSuccess, hasError }

class AuthState extends Equatable {
  final bool loading;
  final bool userLoading;
  final bool fullUserLoading;
  final AuthStatus status;
  final LoginStatus loginStatus;
  final UserStatus userStatus;
  final String errorMessage;
  final String token;
  final User? user;
  final FullUser? fullUser;
  // * Validation to check is email of user exist to flow of recovery password
  final bool isUserExist;
  final RecoveryStatus recoveryStatus;
  // ? Google Sign In
  final bool googleSignInLoading;
  final GoogleSignInStatus googleStatus;
  final String googleUser;

  const AuthState({
    this.loading = false,
    this.userLoading = false,
    this.fullUserLoading = false,
    this.status = AuthStatus.none,
    this.loginStatus = LoginStatus.none,
    this.userStatus = UserStatus.none,
    this.errorMessage = '',
    this.token = '',
    this.user,
    this.fullUser,
    this.isUserExist = false,
    this.recoveryStatus = RecoveryStatus.none,
    this.googleSignInLoading = false,
    this.googleStatus = GoogleSignInStatus.none,
    this.googleUser = '',
  });

  @override
  List<Object> get props => [
        loading,
        userLoading,
        fullUserLoading,
        status,
        loginStatus,
        userStatus,
        recoveryStatus,
        googleSignInLoading,
        googleStatus,
        googleUser,
        if (user != null) user!,
        if (fullUser != null) fullUser!,
      ];

  AuthState copyWith({
    bool? loading,
    bool? userLoading,
    bool? fullUserLoading,
    AuthStatus? status,
    LoginStatus? loginStatus,
    UserStatus? userStatus,
    String? errorMessage,
    String? token,
    User? user,
    FullUser? fullUser,
    bool? isUserExist,
    RecoveryStatus? recoveryStatus,
    bool? googleSignInLoading,
    GoogleSignInStatus? googleStatus,
    String? googleUser,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      token: token ?? this.token,
      user: user ?? this.user,
      userLoading: userLoading ?? this.userLoading,
      fullUserLoading: fullUserLoading ?? this.fullUserLoading,
      userStatus: userStatus ?? this.userStatus,
      fullUser: fullUser ?? this.fullUser,
      isUserExist: isUserExist ?? this.isUserExist,
      recoveryStatus: recoveryStatus ?? this.recoveryStatus,
      googleSignInLoading: googleSignInLoading ?? this.googleSignInLoading,
      googleStatus: googleStatus ?? this.googleStatus,
      googleUser: googleUser ?? this.googleUser,
    );
  }

  @override
  String toString() {
    return "AuthState: $loading, $status, $loginStatus";
  }
}
