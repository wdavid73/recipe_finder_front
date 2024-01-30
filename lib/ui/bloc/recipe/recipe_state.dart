part of 'recipe_bloc.dart';

enum CreateRecipeStatus { none, success, error }

enum GetRecipeStatus { none, success, error }

class RecipeState extends Equatable {
  final bool loading;
  final bool loadingCreate;
  final String errorMessage;
  final CreateRecipeStatus status;
  final GetRecipeStatus statusGet;
  final List<Recipe> recipes;
  final List<Recipe> lastFiveRecipes;
  final int total;
  final Map<String, dynamic> params;

  const RecipeState({
    this.loading = false,
    this.loadingCreate = false,
    this.status = CreateRecipeStatus.none,
    this.statusGet = GetRecipeStatus.none,
    this.recipes = const <Recipe>[],
    this.lastFiveRecipes = const <Recipe>[],
    this.total = 0,
    this.errorMessage = '',
    this.params = const {
      'skip': 0,
      'limit': 15,
    },
  });

  @override
  List<Object> get props => [
        loading,
        loadingCreate,
        errorMessage,
        status,
        recipes,
        lastFiveRecipes,
        params,
      ];

  RecipeState copyWith({
    bool? loading,
    bool? loadingCreate,
    String? errorMessage,
    CreateRecipeStatus? status,
    GetRecipeStatus? statusGet,
    List<Recipe>? recipes,
    List<Recipe>? lastFiveRecipes,
    Map<String, dynamic>? params,
    int? total,
  }) =>
      RecipeState(
        loading: loading ?? this.loading,
        loadingCreate: loadingCreate ?? this.loadingCreate,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        statusGet: statusGet ?? this.statusGet,
        recipes: recipes ?? this.recipes,
        lastFiveRecipes: lastFiveRecipes ?? this.lastFiveRecipes,
        params: params ?? this.params,
        total: total ?? this.total,
      );
}
