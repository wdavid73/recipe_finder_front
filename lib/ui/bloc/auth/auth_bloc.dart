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

    on<GetFullUser>((event, emit) async {
      emit.call(state.copyWith(
        fullUserLoading: true,
      ));
      emit.call(await _getFullUser());
    });

    on<ConfirmEmailEvent>((event, emit) async {
      emit.call(state.copyWith(
        loading: true,
      ));
      emit.call(await _confirmEmail(event.email));
    });

    on<RecoveryPasswordEvent>((event, emit) async {
      emit.call(state.copyWith(
        loading: true,
      ));
      emit.call(await _recoveryPassword(event.data));
    });

    on<SetGoogleAccountEvent>((event, emit) async {
      emit.call(await _googleSetAccount());
    });

    on<GoogleSignInEvent>((event, emit) async {
      emit.call(state.copyWith(
        googleSignInLoading: true,
        googleStatus: GoogleSignInStatus.none,
        googleUser: '',
        loginStatus: LoginStatus.none,
      ));
      emit.call(await _googleSignIn(event.idToken));
    });

    on<LogoutEvent>((event, emit) async {
      emit.call(await _logout());
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
        errorMessage: response.error!.error.toString(),
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
      userStatus: UserStatus.isSuccess,
    );
  }

  Future<AuthState> _getFullUser() async {
    ResponseState response = await _authUseCase.getFullUser();
    if (response is ResponseFailed) {
      return state.copyWith(
        fullUserLoading: false,
        errorMessage: response.error!.error.toString(),
      );
    }
    return state.copyWith(
      fullUser: response.data,
      fullUserLoading: false,
      errorMessage: '',
    );
  }

  Future<AuthState> _confirmEmail(String email) async {
    ResponseState response = await _authUseCase.confirmEmail(email);
    if (response is ResponseFailed) {
      return state.copyWith(
        fullUserLoading: false,
        isUserExist: false,
        errorMessage: response.error!.message,
      );
    }
    return state.copyWith(
      fullUserLoading: false,
      isUserExist: true,
    );
  }

  Future<AuthState> _recoveryPassword(Map<String, dynamic> data) async {
    ResponseState response = await _authUseCase.recoveryPassword(data);
    if (response is ResponseFailed) {
      return state.copyWith(
        loading: false,
        errorMessage: response.error!.message,
        recoveryStatus: RecoveryStatus.hasError,
      );
    }
    return state.copyWith(
      loading: false,
      recoveryStatus: RecoveryStatus.isSuccess,
    );
  }

  Future<AuthState> _googleSetAccount() async {
    ResponseState response = await _authUseCase.setGoogleAccount();
    if (response is ResponseFailed) {
      return state.copyWith(
        googleStatus: GoogleSignInStatus.hasError,
        errorMessage: response.error!.message,
      );
    }
    return state.copyWith(
      googleStatus: GoogleSignInStatus.isSuccess,
      googleUser: response.data,
    );
  }

  Future<AuthState> _googleSignIn(String idToken) async {
    ResponseState response = await _authUseCase.googleSignIn(idToken);
    if (response is ResponseFailed) {
      return state.copyWith(
        googleSignInLoading: false,
        loginStatus: LoginStatus.hasError,
        errorMessage: response.error!.error.toString(),
      );
    }
    return state.copyWith(
      googleSignInLoading: false,
      loginStatus: LoginStatus.isLogged,
      errorMessage: '',
      token: response.data["token"],
      user: User.fromJson(response.data["user"]),
    );
  }

  Future<AuthState> _logout() async {
    final response = await _authUseCase.logout();
    if (response is ResponseFailed) {
      return state.copyWith(
        loading: false,
        userLoading: false,
        fullUserLoading: false,
        errorMessage: response.error!.error.toString(),
      );
    }
    return state.copyWith(
      loading: false,
      userLoading: false,
      fullUserLoading: false,
      status: AuthStatus.none,
      loginStatus: LoginStatus.none,
      userStatus: UserStatus.none,
      errorMessage: '',
      token: '',
      user: null,
      fullUser: null,
      isUserExist: false,
      recoveryStatus: RecoveryStatus.none,
    );
  }
}
