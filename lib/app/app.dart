import 'package:flutter/material.dart';
import 'package:recipe_finder/dependencies.dart';
import 'package:recipe_finder/routes/app_routes.dart';
import 'package:recipe_finder/routes/routes.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/locale_manager.dart';
import 'package:recipe_finder/ui/pages/home/home.dart';
import 'package:recipe_finder/ui/pages/not_found.dart';
import 'package:recipe_finder/ui/managers/theme_manager.dart';
import 'package:recipe_finder/ui/pages/settings/cubit/settings_cubit.dart';
import 'package:recipe_finder/ui/pages/settings/theme_preference.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemePreference _themePreference = ThemePreference();
  ThemeMode themeMode = ThemeMode.dark;

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    bool isDarkTheme = await _themePreference.getTheme();
    if (isDarkTheme) {
      setState(() => themeMode = ThemeMode.dark);
    } else {
      setState(() => themeMode = ThemeMode.light);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MultiBlocProvider(
        providers: buildBlocs(),
        child: BlocListener<SettingsCubit, SettingsState>(
          listener: (context, state) {
            getCurrentAppTheme();
          },
          child: MaterialApp(
            title: 'Recipe Finder',
            debugShowCheckedModeBanner: false,
            darkTheme: getApplicationDarkTheme(),
            themeMode: themeMode,
            home: const HomePage(),
            initialRoute: Routes.splash,
            routes: appRoutes,
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (_) => const NotFound(),
              );
            },
            localizationsDelegates: LocaleManager.localizationsDelegates,
            supportedLocales: LocaleManager.supportedLocales,
          ),
        ),
      ),
    );
  }
}
