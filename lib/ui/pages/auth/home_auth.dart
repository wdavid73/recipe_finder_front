import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/widgets/button_custom.dart';

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
              Animate(
                effects: const [FadeEffect()],
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: responsive.dp(35),
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Image(
                          image: AssetImage("assets/logos/Logo.png"),
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        "Recipe Finder",
                        style: getMediumStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(3.5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Gap(spaceBetween * 4),
              ButtonCustom(
                onPressed: () {},
                width: responsive.wp(70),
                height: responsive.hp(5),
                text: "Login",
                backgroundColor: ColorManager.primaryColor,
                fontColor: Colors.white,
                fontSize: responsive.dp(2),
              ),
              Gap(spaceBetween),
              ButtonCustom(
                onPressed: () {},
                width: responsive.wp(70),
                height: responsive.hp(5),
                text: "Sign up",
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
