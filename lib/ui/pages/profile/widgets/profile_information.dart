import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class InformationContainer extends StatelessWidget {
  final int totalRecipes;
  final double averageRating;
  final double averageTime;

  const InformationContainer({
    super.key,
    this.totalRecipes = 0,
    this.averageRating = 0,
    this.averageTime = 0,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: responsive.width,
        height: responsive.hp(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ColorManager.accentColorLight,
            width: 5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _itemTextInformation(
              responsive,
              title: context.translate('num_recipes'),
              value: totalRecipes.toString(),
            ),
            _itemTextInformation(
              responsive,
              title: context.translate('average_rating'),
              value: averageRating.toString(),
            ),
            _itemTextInformation(
              responsive,
              title: context.translate('average_time'),
              value: averageTime.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemTextInformation(Responsive responsive,
      {required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: (responsive.width / 3.5),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: getSemiBoldStyle(
              fontSize: responsive.dp(1.6),
            ),
          ),
        ),
        Text(
          value,
          style: getMediumStyle(
            fontSize: responsive.dp(1.4),
          ),
        ),
      ],
    );
  }
}
