part of 'recipe_bloc.dart';

enum CreateRecipeStatus { none, success, error }

class RecipeState extends Equatable {
  final bool loading;
  final bool loadingCreate;
  final String errorMessage;
  final CreateRecipeStatus status;
  final List<Recipe> recipes;

  const RecipeState({
    this.loading = false,
    this.loadingCreate = false,
    this.status = CreateRecipeStatus.none,
    this.recipes = const <Recipe>[],
    this.errorMessage = '',
  });

  @override
  List<Object> get props =>
      [loading, loadingCreate, errorMessage, status, recipes];

  RecipeState copyWith({
    bool? loading,
    bool? loadingCreate,
    String? errorMessage,
    CreateRecipeStatus? status,
    List<Recipe>? recipes,
  }) =>
      RecipeState(
        loading: loading ?? this.loading,
        loadingCreate: loadingCreate ?? this.loadingCreate,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        recipes: recipes ?? this.recipes,
      );
}
