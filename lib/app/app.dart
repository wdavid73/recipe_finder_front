import 'package:flutter/material.dart';
import 'package:recipe_finder/dependencies.dart';
import 'package:recipe_finder/routes/app_routes.dart';
import 'package:recipe_finder/routes/routes.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/pages/home.dart';
import 'package:recipe_finder/ui/pages/not_found.dart';
import 'package:recipe_finder/ui/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MultiBlocProvider(
        providers: buildBlocs(),
        child: MaterialApp(
          title: 'Recipe Finder',
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(),
          home: const HomePage(),
          initialRoute: Routes.home,
          routes: appRoutes,
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (_) => const NotFound(),
            );
          },
        ),
      ),
    );
  }
}
