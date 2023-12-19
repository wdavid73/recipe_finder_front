import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/input_autocomplete_search.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/list_ingredient_selected.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/search_input.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/step_input.dart';
import 'package:recipe_finder/utils/constants.dart';
import 'package:recipe_finder/utils/extensions.dart';
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
  final SearchController _searchController = SearchController();
  final List<String> _selectedIngredients = [];
  final List<Map<String, dynamic>> _steps = [];

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
    data["ingredients"] = _selectedIngredients;
    data['main_picture'] = _file;
    data['steps'] = _steps;
    data['category'] = _searchController.value.text;
  }

  void _saveRecipe() {
    parseData();
    debugPrint("prueba");
    debugPrint("$data");
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
                ),
                InputCustom(
                  onChange: (value) => data["description"] = value,
                  hint: context.translate('description_recipe'),
                  label: context.translate('description_recipe'),
                ),
                InputCustom(
                  onChange: (value) => data["cooking_time"] = value,
                  hint: context.translate('cooking_time'),
                  label: context.translate('cooking_time'),
                  keyboardType: TextInputType.number,
                ),
                SearchInputCustom(
                  items: categories,
                  searchController: _searchController,
                  barHintText: context.translate('tap_search_categories'),
                  viewHintText: context.translate('enter_keyword_categories'),
                ),
                InputAutoCompleteSearch(
                  label: context.translate('find_ingredient'),
                  items: List.generate(20, (index) => 'Ingredient #$index'),
                  selectedItems: _selectedIngredients,
                  onSelected: (value) {
                    setState(() => _selectedIngredients.add(value));
                  },
                ),
                ListIngredientsSelected(
                  items: _selectedIngredients,
                  onDeleted: (index) {
                    setState(() => _selectedIngredients.removeAt(index));
                  },
                ),
                StepInput(steps: _steps),
                const UploadVideoInput(),
                ButtonCustom(
                  onPressed: () => _saveRecipe(),
                  text: "Save",
                  width: responsive.wp(90),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
