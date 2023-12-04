import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashScreenState { unAuthenticated, authenticated }

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState.unAuthenticated);

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
