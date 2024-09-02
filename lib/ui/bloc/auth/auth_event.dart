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

class GetUser extends AuthEvent {
  final String token;
  const GetUser(this.token);
}

class GetFullUser extends AuthEvent {}

class ConfirmEmailEvent extends AuthEvent {
  final String email;
  const ConfirmEmailEvent(this.email);
}

class RecoveryPasswordEvent extends AuthEvent {
  final Map<String, dynamic> data;
  const RecoveryPasswordEvent(this.data);
}

class SetGoogleAccountEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {
  final String idToken;
  const GoogleSignInEvent(this.idToken);
}

class LogoutEvent extends AuthEvent {}
