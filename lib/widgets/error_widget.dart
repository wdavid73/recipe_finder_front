import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

class ShowError extends StatelessWidget {
  final String error;
  const ShowError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_rounded,
          size: responsive.dp(5),
          color: ColorManager.error,
        ),
        Text(
          error,
          style: getMediumStyle(
            color: Colors.white,
            fontSize: responsive.dp(2),
          ),
        )
      ],
    );
  }
}
