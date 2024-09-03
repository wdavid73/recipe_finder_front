import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/data/models/step_recipe.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/category/category_bloc.dart';
import 'package:recipe_finder/ui/bloc/create_recipe/create_recipe_bloc.dart';
import 'package:recipe_finder/ui/bloc/ingredient/ingredient_bloc.dart';
import 'package:recipe_finder/ui/bloc/recipe/recipe_bloc.dart';
import 'package:recipe_finder/ui/managers/snack_bar_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/functions.dart';

class CreateRecipeViewModel extends ChangeNotifier {
  final BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNodeCategory = FocusNode();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  Map<String, dynamic> data = {
    'name': '',
    'description': '',
    'cooking_time': null,
    'category_id': null,
    'main_picture': null,
    'ingredients': [],
    'steps': [],
  };

  CreateRecipeViewModel(this.context) {
    _init();
  }

  void _init() {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryBloc.add(GetCategories());

    final ingredientBloc = BlocProvider.of<IngredientBloc>(context);
    ingredientBloc.add(GetIngredientEvent());
  }

  String _translateText(String text) =>
      context.translate(text.toLowerCase().replaceAll(' ', '_'));

  void handlePickImage(file) {
    final createRecipeBloc = BlocProvider.of<CreateRecipeBloc>(context);
    createRecipeBloc.add(SetImageRecipeEvent(file: file));
  }

  void saveRecipe() {
    var isOk = formKey.currentState!.validate();
    if (validateSteps() && isOk) {
      FormData formData = _parseData();

      final recipeBloc = BlocProvider.of<RecipeBloc>(context);
      recipeBloc.add(CreateRecipe(data: formData));
    }
  }

  FormData _parseData() {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    data["ingredients"] =
        bloc.state.ingredients.map((item) => item.id).toList();
    data["main_picture"] = bloc.state.file;
    data['steps'] = bloc.state.steps.map((e) => e.toJson()).toList();
    FormData formData = parseMapToFormData(data);
    return formData;
  }

  void onChangeSearchSuggestion(String text) async {
    final ingredientBloc = BlocProvider.of<IngredientBloc>(context);
    await Future.delayed(const Duration(milliseconds: 500));
    ingredientBloc.add(FilterIngredientsEvent(name: text));
  }

  void onChangeSearchSuggestionCategory(String text) async {
    // TODO: -----------------
  }

  void onTapIngredient(Ingredient ingredient) {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    focusNode.unfocus();
    bloc.add(SetIngredientsEvent(ingredient: ingredient));
  }

  void removeIngredient(Ingredient ingredient) {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    bloc.add(
      RemoveIngredientEvent(ingredient: ingredient),
    );
  }

  void onTapCategory(Category category) {
    String translateKey = _translateText(category.name);
    focusNodeCategory.unfocus();
    searchController.text =
        "${category.name} (${context.translate(translateKey)})";
    data["category_id"] = category.id;
  }

  bool validateSteps() {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    if (bloc.state.steps.isEmpty) {
      _setStepsError('is_step_empty');
      return false;
    }

    for (var i = 0; i < bloc.state.steps.length; i++) {
      StepRecipe step = bloc.state.steps[i];

      if (step.name == '') {
        _setStepsError('is_step_name_empty', value: ['${i + 1}']);
        return false;
      }

      if (step.actions.isEmpty) {
        _setStepsError('is_step_without_actions', value: ['"${step.name}"']);
        return false;
      }

      for (var j = 0; j < step.actions.length; j++) {
        if (step.actions[j].name.isEmpty) {
          _setStepsError(
            'is_action_step_empty',
            value: ['${j + 1}', '"${step.name}'],
          );
          return false;
        }
      }
    }

    _clearStepsError();
    return true;
  }

  void _setStepsError(String key, {List<String> value = const []}) {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    bloc.add(SetStepError(error: formatValidationMessage(key, value, context)));
  }

  void _clearStepsError() {
    final bloc = BlocProvider.of<CreateRecipeBloc>(context);
    bloc.add(const SetStepError(error: ''));
  }

  void createSuccess() {
    formKey.currentState!.reset();
    FocusManager.instance.primaryFocus?.unfocus();

    data = {};

    SnackBarManager.showSnackBar(
      context,
      message: context.translate('recipe_created'),
      icon: Icons.check_circle_outline,
      colorIcon: Colors.greenAccent,
    );
    Future.delayed(const Duration(milliseconds: 1000))
        .then((_) => Navigator.pop(context));
  }
}
