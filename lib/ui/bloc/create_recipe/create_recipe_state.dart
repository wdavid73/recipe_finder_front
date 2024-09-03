part of 'create_recipe_bloc.dart';

class CreateRecipeState extends Equatable {
  final File? file;
  final List<Ingredient> ingredients;
  final List<StepRecipe> steps;
  final String stepError;

  const CreateRecipeState({
    this.file,
    this.ingredients = const <Ingredient>[],
    this.steps = const <StepRecipe>[],
    this.stepError = '',
  });

  @override
  List<Object> get props => [
        ingredients,
        steps,
        stepError,
        if (file != null) file!,
      ];

  CreateRecipeState copyWith({
    File? file,
    List<StepRecipe>? steps,
    List<Ingredient>? ingredients,
    String? stepError,
  }) =>
      CreateRecipeState(
        file: file ?? this.file,
        ingredients: ingredients ?? this.ingredients,
        steps: steps ?? this.steps,
        stepError: stepError ?? this.stepError,
      );
}
