import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/domain/usecase/recipe_usecase.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeUseCase _recipeUseCase;
  RecipeBloc(this._recipeUseCase) : super(const RecipeState()) {
    on<CreateRecipe>((event, emit) async {
      emit.call(state.copyWith(
        loadingCreate: true,
        status: CreateRecipeStatus.none,
      ));
      emit.call(await _create(event.data));
    });
  }

  Future<RecipeState> _create(FormData body) async {
    ResponseState response = await _recipeUseCase.create(body: body);
    if (response is ResponseFailed) {
      print(response.error);
      print(response.error!.error.toString());
      return state.copyWith(
        loadingCreate: false,
        status: CreateRecipeStatus.error,
        errorMessage: response.error!.error.toString(),
      );
    }
    return state.copyWith(
      loadingCreate: false,
      status: CreateRecipeStatus.success,
      errorMessage: '',
    );
  }
}
