import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

class LogoApp extends StatelessWidget {
  final double size;
  final double fontSize;
  const LogoApp({
    super.key,
    required this.size,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [FadeEffect()],
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size,
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
                fontSize: size / 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
