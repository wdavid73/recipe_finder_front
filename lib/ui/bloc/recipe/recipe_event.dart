part of 'recipe_bloc.dart';

sealed class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class GetRecipesByUser extends RecipeEvent {}

class CreateRecipe extends RecipeEvent {
  final FormData data;
  const CreateRecipe({required this.data});
}

class SetParamsEvent extends RecipeEvent {
  final String key;
  final dynamic value;

  const SetParamsEvent({required this.key, required this.value});
}

class ResetParamsEvent extends RecipeEvent {}

class GetLastFiveRecipe extends RecipeEvent {}
