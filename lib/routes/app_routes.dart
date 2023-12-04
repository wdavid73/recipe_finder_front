import 'package:flutter/material.dart';
import 'package:recipe_finder/routes/routes.dart';
import 'package:recipe_finder/ui/pages/auth/home_auth.dart';
import 'package:recipe_finder/ui/pages/home.dart';
import 'package:recipe_finder/ui/pages/not_found.dart';
import 'package:recipe_finder/ui/pages/splash_screen/splash_screen.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.splash: (_) => const SplashScreen(),
      Routes.home: (_) => const HomePage(),
      Routes.homeAuth: (_) => const HomeAuth(),
      Routes.notFound: (_) => const NotFound(),
    };
