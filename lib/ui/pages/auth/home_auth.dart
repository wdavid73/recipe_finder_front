import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/logo_app.dart';

class HomeAuth extends StatelessWidget {
  const HomeAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double spaceBetween = 20;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: responsive.width,
          height: responsive.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoApp(
                size: responsive.dp(35),
              ),
              Gap(spaceBetween * 4),
              ButtonCustom(
                onPressed: () => NavigationManager.go(
                  context,
                  "login",
                  transition: 'slide',
                ),
                width: responsive.wp(70),
                height: responsive.hp(5),
                text: context.translate('login'),
                backgroundColor: ColorManager.primaryColor,
                fontColor: Colors.white,
                fontSize: responsive.dp(2),
              ),
              Gap(spaceBetween),
              ButtonCustom(
                onPressed: () => NavigationManager.go(
                  context,
                  "sign_up",
                  transition: 'slide',
                ),
                width: responsive.wp(70),
                height: responsive.hp(5),
                text: context.translate('sign_up'),
                backgroundColor: Colors.white,
                fontColor: ColorManager.primaryColor,
                fontSize: responsive.dp(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
