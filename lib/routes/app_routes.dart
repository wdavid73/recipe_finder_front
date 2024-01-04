import 'package:flutter/material.dart';
import 'package:recipe_finder/routes/routes.dart';
import 'package:recipe_finder/ui/pages/auth/home_auth.dart';
import 'package:recipe_finder/ui/pages/auth/login.dart';
import 'package:recipe_finder/ui/pages/auth/sign_up.dart';
import 'package:recipe_finder/ui/pages/home/home.dart';
import 'package:recipe_finder/ui/pages/not_found.dart';
import 'package:recipe_finder/ui/pages/profile/profile_page.dart';
import 'package:recipe_finder/ui/pages/recipes/create/create_recipe_page.dart';
import 'package:recipe_finder/ui/pages/recipes/recipes_page.dart';
import 'package:recipe_finder/ui/pages/settings/settings_page.dart';
import 'package:recipe_finder/ui/pages/splash_screen/splash_screen.dart';
import 'package:recipe_finder/ui/pages/test_page.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.splash: (_) => const SplashScreen(),
      Routes.homeAuth: (_) => const HomeAuth(),
      Routes.login: (_) => const Login(),
      Routes.signUp: (_) => const SignUp(),
      Routes.home: (_) => const HomePage(),
      Routes.profile: (_) => const ProfilePage(),
      Routes.settings: (_) => const SettingsPage(),
      Routes.recipes: (_) => const RecipesPage(),
      Routes.createRecipe: (_) => const CreateRecipePage(),
      // ----- NOT FOUND ------ //
      Routes.notFound: (_) => const NotFound(),
      Routes.testPage: (_) => const TestPage(),
    };
