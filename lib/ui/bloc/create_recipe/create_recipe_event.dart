part of 'create_recipe_bloc.dart';

sealed class CreateRecipeEvent extends Equatable {
  const CreateRecipeEvent();

  @override
  List<Object> get props => [];
}

class SetImageRecipeEvent extends CreateRecipeEvent {
  final File? file;
  const SetImageRecipeEvent({this.file});
}

class SetIngredientsEvent extends CreateRecipeEvent {
  final List<Ingredient> ingredients;
  const SetIngredientsEvent({required this.ingredients});
}

class RemoveIngredientEvent extends CreateRecipeEvent {
  final Ingredient ingredient;
  const RemoveIngredientEvent({required this.ingredient});
}

class SetStepEvent extends CreateRecipeEvent {
  final StepRecipe step;
  const SetStepEvent({required this.step});
}

class RemoveStepEvent extends CreateRecipeEvent {
  final int index;
  const RemoveStepEvent({required this.index});
}

class UpdateStepNameEvent extends CreateRecipeEvent {
  final String name;
  final int indexStep;
  const UpdateStepNameEvent({required this.name, required this.indexStep});
}

class AddActionToStepEvent extends CreateRecipeEvent {
  final int indexStep;
  const AddActionToStepEvent({required this.indexStep});
}

class UpdateActionNameInStepEvent extends CreateRecipeEvent {
  final int indexStep;
  final int indexAction;
  final String name;
  const UpdateActionNameInStepEvent({
    required this.indexStep,
    required this.indexAction,
    required this.name,
  });
}

class RemoveActionEvent extends CreateRecipeEvent {
  final int indexStep;
  final int indexAction;
  const RemoveActionEvent({
    required this.indexStep,
    required this.indexAction,
  });
}

class SetStepError extends CreateRecipeEvent {
  final String error;
  const SetStepError({this.error = ''});
}
