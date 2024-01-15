part of 'ingredient_bloc.dart';

enum IngredientStatus { none, hasError }

class IngredientState extends Equatable {
  final bool loading;
  final String errorMessage;
  final IngredientStatus status;
  final List<Ingredient> ingredients;

  const IngredientState({
    this.loading = false,
    this.errorMessage = '',
    this.status = IngredientStatus.none,
    this.ingredients = const <Ingredient>[],
  });

  @override
  List<Object> get props => [loading, status, errorMessage, ingredients];

  IngredientState copyWith({
    bool? loading,
    String? errorMessage,
    IngredientStatus? status,
    List<Ingredient>? ingredients,
  }) =>
      IngredientState(
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        ingredients: ingredients ?? this.ingredients,
      );
}
