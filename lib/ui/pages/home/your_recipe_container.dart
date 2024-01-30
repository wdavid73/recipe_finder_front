import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/recipe/recipe_bloc.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/empty_recipe_list.dart';
import 'package:recipe_finder/widgets/image_network.dart';

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
            BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, state) {
                if (state.loading) {
                  return Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator.adaptive(),
                          const Gap(10),
                          Text(
                            context.translate('loading'),
                            style: getMediumStyle(),
                          )
                        ],
                      ),
                    ),
                  );
                }

                if (state.lastFiveRecipes.isEmpty) {
                  return const EmptyRecipeList();
                }

                return _builderList(state.lastFiveRecipes);
              },
            ),
            const Gap(10),
            ButtonCustom(
              onPressed: () => NavigationManager.go(
                context,
                'create_recipe',
                transition: 'slide',
              ),
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
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  Widget _builderList(List<Recipe> recipes) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: recipes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Recipe recipe = recipes[index];
            return _recipeItem(recipe, context);
          },
        ),
      ),
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
            padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      recipe.rating,
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(1.4),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: responsive.dp(1.6),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
