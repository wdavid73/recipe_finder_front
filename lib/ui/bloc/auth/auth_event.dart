part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends AuthEvent {
  final Map<String, dynamic> data;
  const RegisterUser(this.data);
}

class LoginUser extends AuthEvent {
  final Map<String, dynamic> data;
  const LoginUser(this.data);
}
