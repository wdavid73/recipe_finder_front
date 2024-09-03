import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/data/models/step_recipe.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';

part 'create_recipe_event.dart';
part 'create_recipe_state.dart';

class CreateRecipeBloc extends Bloc<CreateRecipeEvent, CreateRecipeState> {
  CreateRecipeBloc() : super(const CreateRecipeState()) {
    // * ----------- EVENTS ------------- * //
    on<SetImageRecipeEvent>((event, emit) {
      emit.call(_setImage(event.file));
    });

    on<SetIngredientsEvent>((event, emit) {
      emit.call(_setIngredients(event.ingredient));
    });

    on<RemoveIngredientEvent>((event, emit) {
      emit.call(_removeIngredient(event.ingredient));
    });

    on<SetStepEvent>((event, emit) {
      emit.call(_setStep(event.step));
    });

    on<RemoveStepEvent>((event, emit) {
      emit.call(_removeStep(event.index));
    });

    on<UpdateStepNameEvent>((event, emit) {
      emit.call(_updateStepName(event.name, event.indexStep));
    });

    on<AddActionToStepEvent>((event, emit) {
      emit.call(_addActionToStep(event.indexStep));
    });

    on<UpdateActionNameInStepEvent>((event, emit) {
      emit.call(
        _updateActionName(
          event.indexStep,
          event.indexAction,
          event.name,
        ),
      );
    });

    on<RemoveActionEvent>((event, emit) {
      emit.call(_removeAction(event.indexStep, event.indexAction));
    });

    on<SetStepError>((event, emit) {
      emit.call(_stepStepError(event.error));
    });
  }

  // * ----------- PRIVATE FUNCTIONS ------------- * //
  CreateRecipeState _setImage(File? file) => state.copyWith(file: file);

  CreateRecipeState _setIngredients(Ingredient ingredient) {
    if (!state.ingredients.contains(ingredient)) {
      return state.copyWith(ingredients: [...state.ingredients, ingredient]);
    }
    return state;
  }

  CreateRecipeState _removeIngredient(Ingredient ingredient) {
    if (state.ingredients.any((item) => item.id == ingredient.id)) {
      return state.copyWith(
        ingredients: state.ingredients
            .where((element) => element.id != ingredient.id)
            .toList(),
      );
    }
    return state;
  }

  CreateRecipeState _setStep(StepRecipe step) {
    return state.copyWith(steps: [...state.steps, step]);
  }

  CreateRecipeState _updateStepName(String name, int index) {
    return state.copyWith(
      steps: state.steps.asMap().entries.map((entry) {
        return entry.key == index
            ? entry.value.copyWith(name: name)
            : entry.value;
      }).toList(),
    );
  }

  CreateRecipeState _removeStep(int index) {
    return state.copyWith(
        steps: state.steps
            .where((step) => state.steps.indexOf(step) != index)
            .toList());
  }

  CreateRecipeState _addActionToStep(int indexStep) {
    return state.copyWith(
        steps: state.steps.asMap().entries.map((entry) {
      if (entry.key == indexStep) {
        return entry.value.copyWith(
          actions: [...entry.value.actions, const ActionStepRecipe()],
        );
      }
      return entry.value;
    }).toList());
  }

  CreateRecipeState _updateActionName(
    int indexStep,
    int indexAction,
    String name,
  ) {
    return state.copyWith(
        steps: state.steps.asMap().entries.map((entry) {
      if (entry.key == indexStep) {
        List<ActionStepRecipe> updatedActions =
            entry.value.actions.asMap().entries.map((action) {
          return action.key == indexAction
              ? action.value.copyWith(name: name)
              : action.value;
        }).toList();
        return entry.value.copyWith(actions: updatedActions);
      }
      return entry.value;
    }).toList());
  }

  CreateRecipeState _removeAction(int indexStep, int indexAction) {
    return state.copyWith(
        steps: state.steps.asMap().entries.map((entry) {
      if (entry.key == indexStep) {
        List<ActionStepRecipe> updatedActions = entry.value.actions
            .where(
                (action) => entry.value.actions.indexOf(action) != indexAction)
            .toList();
        return entry.value.copyWith(actions: updatedActions);
      }
      return entry.value;
    }).toList());
  }

  CreateRecipeState _stepStepError(String error) {
    return state.copyWith(stepError: error);
  }
}
