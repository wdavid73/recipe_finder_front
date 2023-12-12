import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/icon_app.dart';

class YourRecipesContainer extends StatelessWidget {
  const YourRecipesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SizedBox(
        height: responsive.hp(35),
        width: responsive.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                context.translate('your_recipes'),
                style: getMediumStyle(
                  fontSize: responsive.dp(2.2),
                ),
              ),
            ),
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
                context.translate('list_empty_home'),
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  fontSize: responsive.dp(1.6),
                ),
              ),
            ),
            const Gap(10),
            ButtonCustom(
              onPressed: () {},
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add),
                  const SizedBox(width: 10),
                  Text(
                    context.translate('add_new_recipe'),
                    style: getRegularStyle(
                      fontSize: responsive.dp(1.6),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
