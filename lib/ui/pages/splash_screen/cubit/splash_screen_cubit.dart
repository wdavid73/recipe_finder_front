import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SplashScreenState { unAuthenticated, authenticated }

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState.unAuthenticated);

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    if (token == null || token == '') {
      emit(SplashScreenState.unAuthenticated);
    } else {
      emit(SplashScreenState.authenticated);
    }
  }
}
