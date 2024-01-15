import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/i10n/app_localizations.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/category/category_bloc.dart';
import 'package:recipe_finder/ui/bloc/ingredient/ingredient_bloc.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/input_autocomplete_search.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/list_ingredient_selected.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/search_input.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/step_input.dart';
import 'package:recipe_finder/utils/constants.dart';
import 'package:recipe_finder/utils/extensions.dart';
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
  final List<Ingredient> _selectedIngredients = [];
  final List<Map<String, dynamic>> _steps = [];
  final GlobalKey<FormState> _formKey = GlobalKey();

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
    'category': '',
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

  void parseData() {
    data["ingredients"] = _selectedIngredients.map((item) => item.id).toList();
    data['main_picture'] = _file;
    data['steps'] = _steps;
  }

  void _saveRecipe() {
    var isOk = _formKey.currentState!.validate();
    if (isOk) {
      parseData();
      print(data);
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
    String translateKey = context.translate(
      category.name.replaceAll(' ', '_').toLowerCase(),
    );
    _focusNodeCategory.unfocus();
    _searchController.text =
        "${category.name} (${context.translate(translateKey)})";
    setState(
      () => data["category"] = category.name,
    );
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
        child: Container(
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
                    onChange: (value) => data["name"] = value,
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
                    onChange: (value) => data["cooking_time"] = value,
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
                  ),
                  _inputSearchCategory(),
                  _inputSearchIngredient(context),
                  ListIngredientsSelected(
                    items: _selectedIngredients,
                    itemBuilder: (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Chip(
                          onDeleted: () => setState(
                            () => _selectedIngredients.removeAt(index),
                          ),
                          label: Text(
                            context.translate(
                              _selectedIngredients[index]
                                  .name
                                  .replaceAll(' ', '_')
                                  .toLowerCase(),
                            ),
                            style: getRegularStyle(),
                          ),
                        ),
                      );
                    },
                  ),
                  StepInput(steps: _steps),
                  const UploadVideoInput(),
                  ButtonCustom(
                    onPressed: () => _saveRecipe(),
                    text: context.translate('save'),
                    width: responsive.wp(90),
                  )
                ],
              ),
            ),
          ),
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
            message: context.translate('is_empty_list')),
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
      // subtitle: Text(ingredient.category.capitalize()),
      onTap: () => onTapCategory(category),
    );
  }
}
