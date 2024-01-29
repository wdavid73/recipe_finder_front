import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/icon_app.dart';

class EmptyRecipeList extends StatelessWidget {
  final String? complementMessage;
  const EmptyRecipeList({super.key, this.complementMessage});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Column(
      children: [
        IconApp(
          icon: "assets/icons/empty_recipes.svg",
          size: responsive.dp(20),
        ),
        Text(
          context.translate('its_empty'),
          textAlign: TextAlign.center,
          style: getRegularStyle(
            fontSize: responsive.dp(1.6),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            complementMessage ?? context.translate('list_empty_home'),
            textAlign: TextAlign.center,
            style: getRegularStyle(
              fontSize: responsive.dp(1.6),
            ),
          ),
        ),
      ],
    );
  }
}
