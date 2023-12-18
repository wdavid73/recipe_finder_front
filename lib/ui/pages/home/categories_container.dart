import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/constants.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';

class CategoriesContainer extends StatelessWidget {
  const CategoriesContainer({
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
        width: responsive.width,
        height: responsive.hp(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                context.translate('find_by_category'),
                style: getMediumStyle(
                  fontSize: responsive.dp(2.2),
                ),
              ),
            ),
            const Gap(5),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                padding: EdgeInsets.zero,
                children: List.generate(categories.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ButtonCustom(
                        onPressed: () {},
                        height: 70,
                        child: categories[index]["icon"],
                      ),
                      const Gap(5),
                      SizedBox(
                        width: responsive.wp(20),
                        child: Text(
                          categories[index]["name"],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getMediumStyle(
                            fontSize: responsive.dp(1.6),
                            height: 1,
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
