import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class EndList extends StatelessWidget {
  const EndList({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.format_list_bulleted_rounded,
            size: responsive.dp(3),
          ),
          const Gap(10),
          Text(
            context.translate('end_list'),
            style: getRegularStyle(
              textDecoration: TextDecoration.underline,
              fontSize: responsive.dp(1.6),
            ),
          ),
        ],
      ),
    );
  }
}
