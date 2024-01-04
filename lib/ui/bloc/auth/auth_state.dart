part of 'auth_bloc.dart';

enum AuthStatus { none, isCreate, hasError }

class AuthState extends Equatable {
  final bool loading;
  final AuthStatus status;
  final String errorMessage;

  const AuthState({
    this.loading = false,
    this.status = AuthStatus.none,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [loading];

  AuthState copyWith({
    bool? loading,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return "AuthState: $loading, $status";
  }
}