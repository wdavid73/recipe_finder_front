import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/pages/settings/cubit/settings_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final cubit = BlocProvider.of<SettingsCubit>(context);
    cubit.init();
    await Future.delayed(const Duration(seconds: 3));
    _navigate();
  }

  void _navigate() {
    NavigationManager.go(context, "home_auth");
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: Container(
        width: responsive.width,
        height: responsive.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorManager.primaryColor,
              ColorManager.accentColor,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Animate(
              effects: const [
                ScaleEffect(duration: Duration(milliseconds: 1000)),
                FadeEffect(duration: Duration(milliseconds: 1000))
              ],
              child: Image(
                image: const AssetImage("assets/logos/Logo_white.png"),
                alignment: Alignment.center,
                fit: BoxFit.fill,
                width: responsive.dp(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
