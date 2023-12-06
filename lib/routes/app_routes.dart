import 'package:flutter/material.dart';
import 'package:recipe_finder/routes/routes.dart';
import 'package:recipe_finder/ui/pages/auth/home_auth.dart';
import 'package:recipe_finder/ui/pages/auth/login.dart';
import 'package:recipe_finder/ui/pages/auth/sign_up.dart';
import 'package:recipe_finder/ui/pages/home/home.dart';
import 'package:recipe_finder/ui/pages/not_found.dart';
import 'package:recipe_finder/ui/pages/profile/profile_page.dart';
import 'package:recipe_finder/ui/pages/settings/settings_page.dart';
import 'package:recipe_finder/ui/pages/splash_screen/splash_screen.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.splash: (_) => const SplashScreen(),
      Routes.homeAuth: (_) => const HomeAuth(),
      Routes.login: (_) => const Login(),
      Routes.signUp: (_) => const SignUp(),
      Routes.home: (_) => const HomePage(),
      Routes.profile: (_) => const ProfilePage(),
      Routes.settings: (_) => const SettingsPage(),
      // ----- NOT FOUND ------ //
      Routes.notFound: (_) => const NotFound(),
    };
