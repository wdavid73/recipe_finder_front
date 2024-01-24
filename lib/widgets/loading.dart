import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class Loading extends StatelessWidget {
  final Orientation orientation;
  const Loading({super.key, this.orientation = Orientation.portrait});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return SizedBox(
      width: responsive.width,
      child: orientation == Orientation.portrait
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const Gap(10),
                Text(
                  context.translate('loading'),
                  style: getMediumStyle(
                    fontSize: responsive.dp(1.8),
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const Gap(10),
                Text(
                  context.translate('loading'),
                  style: getMediumStyle(
                    fontSize: responsive.dp(1.8),
                  ),
                ),
              ],
            ),
    );
  }
}
