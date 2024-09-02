import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/category/category_bloc.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/constants.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/error_widget.dart';
import 'package:shimmer/shimmer.dart';

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
        height: responsive.hp(45),
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
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state.loading) {
                    return _loadingCategory();
                  }

                  if (state.status == CategoryStatus.hasError) {
                    return ShowError(error: state.errorMessage);
                  }

                  return GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    padding: EdgeInsets.zero,
                    children: List.generate(state.categories.length, (index) {
                      return _itemCategory(
                        responsive,
                        state.categories[index],
                        context,
                      );
                    }),
                  );
                },
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _itemCategory(
      Responsive responsive, Category category, BuildContext ctx) {
    Widget icon =
        kCategories.firstWhere((e) => e['name'] == category.name, orElse: () {
      return {
        "icon": Icon(
          Icons.extension,
          color: ColorManager.textPrimaryLight,
          size: 34,
        )
      };
    })['icon'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ButtonCustom(
          onPressed: () {},
          height: 70,
          child: icon,
        ),
        const Gap(5),
        SizedBox(
          width: responsive.wp(20),
          child: Text(
            ctx.translate(category.name.toLowerCase().replaceAll(' ', '_')),
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
  }

  Widget _loadingCategory() {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        padding: EdgeInsets.zero,
        children: List.generate(
          9,
          (index) => Container(
            height: 10,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
