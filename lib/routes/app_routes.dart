import 'package:flutter/material.dart';
import 'package:recipe_finder/routes/routes.dart';
import 'package:recipe_finder/ui/pages/home.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.home: (_) => const HomePage(),
    };
