import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/recipe/recipe_bloc.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/snack_bar_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/create/create_recipe_viewmodel.dart';
import 'package:recipe_finder/ui/pages/recipes/create/widgets/image_picker.dart';
import 'package:recipe_finder/ui/pages/recipes/create/widgets/input_search_category.dart';
import 'package:recipe_finder/ui/pages/recipes/create/widgets/input_search_ingredient.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/step_input.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/validations.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';

class CreateRecipePage extends StatelessWidget {
  const CreateRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ChangeNotifierProvider(
      create: (_) => CreateRecipeViewModel(context),
      child: Consumer<CreateRecipeViewModel>(
        builder: (context, viewModel, child) => Scaffold(
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
                  viewModel.createSuccess();
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
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImagePickerCreateRecipe(
                            onFileChanged: (file) =>
                                viewModel.handlePickImage(file),
                          ),
                          InputCustom(
                            formKey: viewModel.formKey,
                            onChange: (value) {
                              viewModel.data["name"] = value;
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
                            formKey: viewModel.formKey,
                            onChange: (value) =>
                                viewModel.data["description"] = value,
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
                            formKey: viewModel.formKey,
                            onChange: (value) {
                              if (value.isNotEmpty) {
                                viewModel.data["cooking_time"] =
                                    int.parse(value);
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
                          InputSearchCategory(
                            onTapCategory: (Category category) {
                              viewModel.onTapCategory(category);
                            },
                            onChangeSearchSuggestionCategory: (item) {
                              viewModel.onChangeSearchSuggestionCategory(item);
                            },
                            controller: viewModel.searchController,
                            focusNode: viewModel.focusNodeCategory,
                          ),
                          InputSearchIngredient(
                            controller: viewModel.controller,
                            focusNode: viewModel.focusNode,
                            onChange: (ingredients) {
                              viewModel.onTapIngredient(ingredients);
                            },
                            onChangeSearchSuggestion: (text) {
                              viewModel.onChangeSearchSuggestion(text);
                            },
                            validator: (value) => pipeFirstNotNullOrNull<String,
                                List<Ingredient>>(value!, [
                              (value) => Validations.isRequired(value,
                                  message: context.translate('is_required')),
                              (value) => Validations.isNotEmptyList(value,
                                  message: context.translate('is_empty'))
                            ]),
                          ),
                          const StepInput(),
                          /* const UploadVideoInput(), */
                          ButtonCustom(
                            onPressed: () => viewModel.saveRecipe(),
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
        ),
      ),
    );
  }
}
