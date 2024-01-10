import 'package:equatable/equatable.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/data/models/user.dart';
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

    on<LoginUser>((event, emit) async {
      emit.call(state.copyWith(
        loading: true,
        loginStatus: LoginStatus.none,
      ));
      emit.call(await _login(event.data));
    });

    on<GetUser>((event, emit) async {
      emit.call(state.copyWith(
        userLoading: true,
        userStatus: UserStatus.none,
      ));
      emit.call(await _getUser(event.token));
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

  Future<AuthState> _login(Map<String, dynamic> data) async {
    ResponseState response = await _authUseCase.login(data);
    if (response is ResponseFailed) {
      return state.copyWith(
        loading: false,
        loginStatus: LoginStatus.hasError,
        errorMessage: response.error!.message,
      );
    }
    return state.copyWith(
      loading: false,
      loginStatus: LoginStatus.isLogged,
      errorMessage: '',
      token: response.data["token"],
      user: User.fromJson(response.data["user"]),
    );
  }

  Future<AuthState> _getUser(String token) async {
    ResponseState response = await _authUseCase.getUser();
    if (response is ResponseFailed) {
      return state.copyWith(
        user: response.data,
        token: token,
        userLoading: false,
        userStatus: UserStatus.hasError,
        errorMessage: response.error!.error.toString(),
      );
    }
    return state.copyWith(
      user: response.data,
      token: token,
      userLoading: false,
      userStatus: UserStatus.none,
    );
  }
}
