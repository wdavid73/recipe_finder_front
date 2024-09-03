import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/create_recipe/create_recipe_bloc.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/list_ingredient_selected.dart';
import 'package:recipe_finder/utils/extensions.dart';

class ListIngredientCreateRecipe extends StatelessWidget {
  final void Function(Ingredient ingredient) onDeleted;
  const ListIngredientCreateRecipe({
    super.key,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
      builder: (context, state) {
        String translateText(String text) =>
            context.translate(text.toLowerCase().replaceAll(' ', '_'));

        return ListIngredientsSelected(
          items: state.ingredients,
          itemBuilder: (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Chip(
                onDeleted: () => onDeleted(state.ingredients[index]),
                label: Text(
                  translateText(state.ingredients[index].name),
                  style: getRegularStyle(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
