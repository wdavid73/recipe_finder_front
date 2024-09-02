import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class ExtraInformationContainer extends StatelessWidget {
  final int totalRecipesEnable;
  final int totalRecipesDisable;
  final int totalRecipesHide;

  const ExtraInformationContainer({
    super.key,
    this.totalRecipesEnable = 0,
    this.totalRecipesDisable = 0,
    this.totalRecipesHide = 0,
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
              title: context.translate('total_enable'),
              value: totalRecipesEnable.toString(),
            ),
            _itemTextInformation(
              responsive,
              title: context.translate('total_disable'),
              value: totalRecipesDisable.toString(),
            ),
            _itemTextInformation(
              responsive,
              title: context.translate('total_hide'),
              value: totalRecipesHide.toString(),
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
