import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/data/models/step.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/category/category_bloc.dart';
import 'package:recipe_finder/ui/bloc/ingredient/ingredient_bloc.dart';
import 'package:recipe_finder/ui/bloc/recipe/recipe_bloc.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/snack_bar_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/input_autocomplete_search.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/list_ingredient_selected.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/step_input.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/functions.dart';
import 'package:recipe_finder/utils/validations.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/image_picker.dart';
import 'package:recipe_finder/widgets/input_custom.dart';
import 'package:recipe_finder/widgets/upload_video.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({super.key});

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  File? _file;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNodeCategory = FocusNode();
  List<Ingredient> _selectedIngredients = [];
  List<Map<String, dynamic>> _steps = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  String stepsError = '';

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryBloc.add(GetCategories());

    final ingredientBloc = BlocProvider.of<IngredientBloc>(context);
    ingredientBloc.add(GetIngredientEvent());
  }

  Map<String, dynamic> data = {
    'name': '',
    'description': '',
    'cooking_time': null,
    'category_id': null,
    'main_picture': null,
    'ingredients': [],
    'steps': [],
  };

  handlePickImage(file) {
    if (file != null) {
      setState(() => _file = file);
    } else {
      setState(() => _file = null);
    }
  }

  FormData parseData() {
    data["ingredients"] = _selectedIngredients.map((item) => item.id).toList();
    data["main_picture"] = _file;
    data['steps'] = _steps;

    FormData formData = parseMapToFormData(data);
    return formData;
  }

  void _saveRecipe() {
    var isOk = _formKey.currentState!.validate();
    if (validateSteps() && isOk) {
      FormData formData = parseData();
      final recipeBloc = BlocProvider.of<RecipeBloc>(context);
      recipeBloc.add(CreateRecipe(data: formData));
    }
  }

  String _translateText(String text) =>
      context.translate(text.toLowerCase().replaceAll(' ', '_'));

  void onChangeSearchSuggestion(String text) async {
    final ingredientBloc = BlocProvider.of<IngredientBloc>(context);
    await Future.delayed(const Duration(milliseconds: 500));
    ingredientBloc.add(FilterIngredientsEvent(name: text));
  }

  void onChangeSearchSuggestionCategory(String text) async {}

  void onTapIngredient(Ingredient ingredient) {
    if (!_selectedIngredients.contains(ingredient)) {
      _focusNode.unfocus();
      setState(
        () => _selectedIngredients.add(ingredient),
      );
    }
  }

  void onTapCategory(Category category) {
    String translateKey = _translateText(category.name);
    _focusNodeCategory.unfocus();
    _searchController.text =
        "${category.name} (${context.translate(translateKey)})";
    setState(
      () => data["category_id"] = category.id,
    );
  }

  bool validateSteps() {
    if (_steps.isEmpty) {
      setStepsError('is_step_empty');
      return false;
    }
    for (var e in _steps) {
      int index = _steps.indexOf(e);
      StepData step = StepData.fromJson(e);
      if (step.name == '') {
        setStepsError('is_step_name_empty', value: ['${index + 1}']);
        return false;
      }

      if (step.actions.isEmpty) {
        setStepsError('is_step_without_actions', value: ['"${step.name}"']);
        return false;
      }

      if (step.actions.isNotEmpty) {
        for (var a in step.actions) {
          int index = step.actions.indexOf(a);
          if (a.name == '' || a.name == null) {
            setStepsError(
              'is_action_step_empty',
              value: ['#${index + 1}', '"${step.name}"'],
            );
            return false;
          }
        }
      }
    }
    clearStepsError();
    return true;
  }

  void setStepsError(String key, {List<String> value = const []}) {
    setState(() => stepsError = formatValidationMessage(key, value, context));
  }

  void clearStepsError() {
    setState(() => stepsError = '');
  }

  void _createSuccess() {
    _formKey.currentState!.reset();
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _selectedIngredients = [];
      _steps = [];
      data = {};
      _file = null;
    });
    SnackBarManager.showSnackBar(
      context,
      message: context.translate('recipe_created'),
      icon: Icons.check_circle_outline,
      colorIcon: Colors.greenAccent,
    );
    Future.delayed(const Duration(milliseconds: 1000))
        .then((_) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('create_recipe'),
          style: getSemiBoldStyle(
            fontSize: responsive.dp(1.8),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<RecipeBloc, RecipeState>(
          listener: (context, state) {
            if (state.status == CreateRecipeStatus.success) {
              _createSuccess();
            }
            if (state.status == CreateRecipeStatus.error) {
              SnackBarManager.showSnackBar(
                context,
                message: state.errorMessage,
                icon: Icons.error,
              );
            }
          },
          builder: (context, state) {
            return Container(
              width: responsive.width,
              height: responsive.height,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ImagePickerInput(
                        image: _file,
                        onFileChanged: (file) => handlePickImage(file),
                      ),
                      InputCustom(
                        formKey: _formKey,
                        onChange: (value) {
                          data["name"] = value;
                        },
                        hint: context.translate('name_recipe'),
                        label: context.translate('name_recipe'),
                        validator: (value) =>
                            pipeFirstNotNullOrNull<String, String>(value!, [
                          (value) => Validations.isRequired(value,
                              message: context.translate('is_required')),
                          (value) => Validations.isNotEmpty(value,
                              message: context.translate('is_empty')),
                        ]),
                      ),
                      InputCustom(
                        formKey: _formKey,
                        onChange: (value) => data["description"] = value,
                        hint: context.translate('description_recipe'),
                        label: context.translate('description_recipe'),
                        validator: (value) =>
                            pipeFirstNotNullOrNull<String, String>(value!, [
                          (value) => Validations.isRequired(value,
                              message: context.translate('is_required')),
                          (value) => Validations.isNotEmpty(value,
                              message: context.translate('is_empty')),
                        ]),
                      ),
                      InputCustom(
                        formKey: _formKey,
                        onChange: (value) {
                          if (value.isNotEmpty) {
                            data["cooking_time"] = int.parse(value);
                          }
                        },
                        hint: context.translate('cooking_time'),
                        label: context.translate('cooking_time'),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            pipeFirstNotNullOrNull<String, String>(value!, [
                          (value) => Validations.isRequired(value,
                              message: context.translate('is_required')),
                          (value) => Validations.isNotEmpty(value,
                              message: context.translate('is_empty')),
                        ]),
                        textSuffix: "Min",
                      ),
                      _inputSearchCategory(),
                      _inputSearchIngredient(context),
                      ListIngredientsSelected(
                        items: _selectedIngredients,
                        itemBuilder: (index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 1.0),
                            child: Chip(
                              onDeleted: () => setState(
                                () => _selectedIngredients.removeAt(index),
                              ),
                              label: Text(
                                _translateText(
                                    _selectedIngredients[index].name),
                                style: getRegularStyle(),
                              ),
                            ),
                          );
                        },
                      ),
                      StepInput(
                        steps: _steps,
                        messageError: stepsError,
                      ),
                      const UploadVideoInput(),
                      ButtonCustom(
                        onPressed: () => _saveRecipe(),
                        text: context.translate('save'),
                        width: responsive.wp(90),
                        isLoading: state.loadingCreate,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _inputSearchCategory() {
    return InputSearchSuggestion(
      label: context.translate(
        'enter_keyword_categories',
      ),
      focusNode: _focusNodeCategory,
      controller: _searchController,
      validator: (value) => pipeFirstNotNullOrNull<String, String>(value!, [
        (value) => Validations.isRequired(value,
            message: context.translate('is_required')),
        (_) => Validations.isNotEmptyList(_selectedIngredients,
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
  }

  Widget _inputSearchIngredient(BuildContext context) {
    return InputSearchSuggestion(
      label: context.translate('find_ingredient'),
      focusNode: _focusNode,
      controller: _controller,
      validator: (value) => pipeFirstNotNullOrNull<String, String>(value!, [
        (value) => Validations.isRequired(value,
            message: context.translate('is_required')),
        (_) => Validations.isNotEmptyList(_selectedIngredients,
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

  Widget _itemSearchCategory(Category category) {
    return ListTile(
      title: Text(category.name.capitalize()),
      onTap: () => onTapCategory(category),
    );
  }
}
