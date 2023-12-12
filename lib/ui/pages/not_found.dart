import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/font_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('not_found_title'),
          style: getSemiBoldStyle(
            fontSize: responsive.dp(1.8),
          ),
        ),
        centerTitle: true,
        toolbarHeight: responsive.hp(8),
      ),
      body: SizedBox(
        width: responsive.width,
        height: responsive.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.translate('not_found_info'),
              style: getSemiBoldStyle(
                fontSize: FontSizeResponsive(responsive).large,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
