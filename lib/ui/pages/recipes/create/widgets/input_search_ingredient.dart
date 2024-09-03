import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/create_recipe/create_recipe_bloc.dart';
import 'package:recipe_finder/ui/bloc/ingredient/ingredient_bloc.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/input_autocomplete_search.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/validations.dart';
import 'package:recipe_finder/widgets/loadings.dart';

class InputSearchIngredient extends StatelessWidget {
  final void Function(String)? onChangeSearchSuggestion;
  final void Function(Ingredient) onTapIngredient;
  final TextEditingController controller;
  final FocusNode focusNode;
  const InputSearchIngredient({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChangeSearchSuggestion,
    required this.onTapIngredient,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
      builder: (context, state) {
        return InputSearchSuggestion(
          label: context.translate('find_ingredient'),
          focusNode: focusNode,
          controller: controller,
          validator: (value) => pipeFirstNotNullOrNull<String, String>(value!, [
            (value) => Validations.isRequired(value,
                message: context.translate('is_required')),
            (_) => Validations.isNotEmptyList(state.ingredients,
                message: context.translate('is_empty_list')),
          ]),
          bottomMargin: 5,
          onChanged: onChangeSearchSuggestion,
          childBuilder: BlocBuilder<IngredientBloc, IngredientState>(
            builder: (context, state) {
              if (state.loading) {
                return const LoadingBuilder();
              }

              if (state.status == IngredientStatus.hasError) {
                return const ErrorBuilder();
              }

              if (state.ingredients.isEmpty) {
                return const EmptyBuilder();
              }

              return ListView.builder(
                itemCount: state.ingredients.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Ingredient ingredient = state.ingredients[index];
                  bool isSelected = !state.ingredients.contains(ingredient);
                  return _itemSearch(ingredient, isSelected);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _itemSearch(Ingredient ingredient, bool isSelected) {
    return ListTile(
      title: Text(ingredient.name.capitalize()),
      subtitle: Text(ingredient.category.capitalize()),
      selected: isSelected,
      trailing: isSelected
          ? Icon(
              Icons.check_circle_outline,
              color: ColorManager.accentColor,
            )
          : null,
      onTap: () => onTapIngredient(ingredient),
    );
  }
}
