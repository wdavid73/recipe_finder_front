import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/font_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/search_input.dart';
import 'package:recipe_finder/utils/constants.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';
import 'package:recipe_finder/widgets/star_ratings.dart';

class BottomSheetFiltersRecipe extends StatefulWidget {
  const BottomSheetFiltersRecipe({
    super.key,
  });

  @override
  State<BottomSheetFiltersRecipe> createState() =>
      _BottomSheetFiltersRecipeState();
}

class _BottomSheetFiltersRecipeState extends State<BottomSheetFiltersRecipe> {
  final SearchController _searchController = SearchController();
  int _selectedRating = -1;

  List<Widget> ratings = [
    const StarRating(rating: 5),
    const StarRating(rating: 4),
    const StarRating(rating: 3),
    const StarRating(rating: 2),
    const StarRating(rating: 1),
  ];

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: responsive.width,
      height: responsive.isKeyboardOpen ? responsive.hp(80) : responsive.hp(55),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                context.translate('filters'),
                style: getSemiBoldStyle(
                  fontSize: FontSizeResponsive(responsive).extraExtraLarge,
                ),
              ),
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    context.translate('rating'),
                    style: getRegularStyle(
                      fontSize: FontSizeResponsive(responsive).large,
                    ),
                  ),
                ),
                SizedBox(
                  width: responsive.width,
                  height: responsive.hp(25),
                  child: ListView.builder(
                    itemCount: ratings.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: index,
                            groupValue: _selectedRating,
                            onChanged: (value) {
                              setState(() {
                                _selectedRating = value as int;
                              });
                            },
                          ),
                          ratings[index],
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    context.translate('category'),
                    style: getRegularStyle(
                      fontSize: FontSizeResponsive(responsive).large,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: SearchInputCustom(
                      items: categories,
                      width: responsive.width,
                      searchController: _searchController,
                      barHintText: context.translate('tap_search'),
                      viewHintText: context.translate('enter_keyword'),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InputCustom(
                    onChange: (value) {},
                    hint: context.translate('cooking_time'),
                    label: context.translate('cooking_time'),
                    iconPrefix: const Icon(Icons.timer_outlined),
                    textSuffix: context.translate('minute'),
                    keyboardType: TextInputType.number,
                    width: responsive.width,
                  ),
                ],
              ),
            ),
            const Gap(20),
            Center(
              child: ButtonCustom(
                onPressed: () {},
                text: context.translate('apply_filter'),
                width: responsive.wp(70),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
