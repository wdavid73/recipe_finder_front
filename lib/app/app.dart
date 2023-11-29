import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter/dependencies.dart';
import 'package:front_scaffold_flutter/routes/app_routes.dart';
import 'package:front_scaffold_flutter/routes/routes.dart';
import 'package:front_scaffold_flutter/ui/bloc/bloc_imports.dart';
import 'package:front_scaffold_flutter/ui/pages/home.dart';
import 'package:front_scaffold_flutter/ui/pages/not_found.dart';
import 'package:front_scaffold_flutter/ui/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MultiBlocProvider(
        providers: buildBlocs(),
        child: MaterialApp(
          title: 'Front Scaffold Flutter',
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
