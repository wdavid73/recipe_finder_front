import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

class UploadVideoInput extends StatelessWidget {
  const UploadVideoInput({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DottedBorder(
            radius: const Radius.circular(20),
            color: ColorManager.accentColor,
            borderType: BorderType.RRect,
            child: SizedBox(
              width: responsive.width,
              height: responsive.hp(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: ColorManager.accentColor,
                    size: responsive.dp(6),
                  ),
                  Text(
                    "Upload video (optional)",
                    style: getLightStyle(
                      color: ColorManager.accentColor,
                      fontSize: responsive.dp(1.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "Tip: Recipe preparation video!",
            style: getLightStyle(
              fontSize: responsive.dp(1.3),
            ),
          ),
        ],
      ),
    ).animate().blur();
  }
}
