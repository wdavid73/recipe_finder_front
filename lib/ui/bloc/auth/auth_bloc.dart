import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/usecase/auth_usecase.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(const AuthState()) {
    on<RegisterUser>((event, emit) async {
      emit.call(state.copyWith(
        loading: true,
        status: AuthStatus.none,
      ));
      emit.call(await _register(event.data));
    });
  }

  Future<AuthState> _register(Map<String, dynamic> data) async {
    ResponseState response = await _authUseCase.register(data);
    if (response is ResponseFailed) {
      return state.copyWith(
        loading: false,
        status: AuthStatus.hasError,
        errorMessage: response.error!.message,
      );
    }
    return state.copyWith(
      loading: false,
      status: AuthStatus.isCreate,
      errorMessage: '',
    );
  }
}