import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/category/category_bloc.dart';
import 'package:recipe_finder/ui/bloc/create_recipe/create_recipe_bloc.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/input_autocomplete_search.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/validations.dart';
import 'package:recipe_finder/widgets/loadings.dart';

class InputSearchCategory extends StatelessWidget {
  final void Function(Category category) onTapCategory;
  final void Function(dynamic item) onChangeSearchSuggestionCategory;
  final TextEditingController controller;
  final FocusNode focusNode;

  const InputSearchCategory({
    super.key,
    required this.onTapCategory,
    required this.onChangeSearchSuggestionCategory,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
      builder: (context, state) {
        return InputSearchSuggestion(
          label: context.translate(
            'enter_keyword_categories',
          ),
          focusNode: focusNode,
          controller: controller,
          validator: (value) => pipeFirstNotNullOrNull<String, String>(value!, [
            (value) => Validations.isRequired(value,
                message: context.translate('is_required')),
            (_) => Validations.isNotEmptyList(state.ingredients,
                message: context.translate('is_empty_select')),
          ]),
          bottomMargin: 20,
          onChanged: onChangeSearchSuggestionCategory,
          childBuilder: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.loading) {
                return const LoadingBuilder();
              }

              if (state.status == CategoryStatus.hasError) {
                return const ErrorBuilder();
              }

              if (state.categories.isEmpty) {
                return const EmptyBuilder();
              }

              return ListView.builder(
                itemCount: state.categories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Category category = state.categories[index];
                  return _itemSearchCategory(category);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _itemSearchCategory(Category category) {
    return ListTile(
      title: Text(category.name.capitalize()),
      onTap: () => onTapCategory(category),
    );
  }
}
