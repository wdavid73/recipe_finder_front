import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter/ui/color_manager.dart';
import 'package:front_scaffold_flutter/ui/font_manager.dart';
import 'package:front_scaffold_flutter/ui/responsive_manager.dart';
import 'package:front_scaffold_flutter/ui/style_text_manager.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: SizedBox(
        width: responsive.width,
        height: responsive.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No pudimos encontrar lo que buscabas",
              style: getSemiBoldStyle(
                color: ColorManager.textPrimary,
                fontSize: FontSizeResponsive(responsive).medium,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
