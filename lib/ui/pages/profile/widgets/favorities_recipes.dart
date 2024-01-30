import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/empty_recipe_list.dart';
import 'package:recipe_finder/widgets/image_network.dart';
import 'package:shimmer/shimmer.dart';

class FavoritesRecipes extends StatelessWidget {
  final List<Recipe> recipes;
  final bool loading;

  const FavoritesRecipes({
    super.key,
    this.recipes = const <Recipe>[],
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.translate('favorite_recipes'),
                style: getMediumStyle(
                  fontSize: responsive.dp(2),
                ),
              ),
              !loading
                  ? Text(
                      context.translate('show_all'),
                      style: getMediumStyle(
                        fontSize: responsive.dp(2),
                        textDecoration: TextDecoration.underline,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          SizedBox(
            width: responsive.width,
            height: responsive.hp(23),
            child: _builderList(
              recipes: recipes,
              context: context,
              loading: loading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _builderList({
    required List<Recipe> recipes,
    bool loading = false,
    required BuildContext context,
  }) {
    if (recipes.isEmpty) {
      return EmptyRecipeList(
        complementMessage: context.translate('not_recipe_favorites'),
      );
    }

    if (loading) {
      return _loading(context);
    }
    return ListView.builder(
      itemCount: recipes.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        Recipe recipe = recipes[index];
        return _recipeItem(recipe, context);
      },
    );
  }

  Widget _recipeItem(Recipe recipe, BuildContext context) {
    final Responsive responsive = Responsive(context);

    String translateText(String text) =>
        context.translate(text.toLowerCase().replaceAll(' ', '_'));

    return Container(
      width: responsive.wp(45),
      height: 250,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ColorManager.placeholderColor,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: responsive.width,
              child: ImageNetwork(
                imageUrl: recipe.mainPicture,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            color: ColorManager.accentColorLight,
            width: responsive.width,
            child: Column(
              children: [
                Text(
                  recipe.name,
                  textAlign: TextAlign.center,
                  style: getBoldStyle(
                    fontSize: responsive.dp(1.4),
                  ),
                ),
                Text(
                  "(${translateText(recipe.category.name)})",
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    fontSize: responsive.dp(1.2),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _loading(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return SizedBox(
      width: responsive.width,
      height: responsive.height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: List.generate(4, (index) {
            return Container(
              width: responsive.wp(80),
              height: 200,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ),
    );
  }
}
