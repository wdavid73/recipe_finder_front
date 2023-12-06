import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/widgets/icon_app.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: getSemiBoldStyle(
            color: Colors.white,
            fontSize: responsive.dp(1.8),
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.backgroundDarkColor,
        shadowColor: Colors.black87,
        surfaceTintColor: ColorManager.backgroundDarkColor,
        toolbarHeight: responsive.hp(8),
      ),
      body: SafeArea(
        child: SizedBox(
          width: responsive.width,
          height: responsive.height,
          child: IconApp(
            icon: "assets/images/working_page.svg",
            color: Colors.white,
            size: responsive.dp(25),
          ),
        ),
      ),
    );
  }
}
