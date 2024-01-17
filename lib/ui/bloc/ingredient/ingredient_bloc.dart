import 'package:equatable/equatable.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/domain/usecase/ingredient_usecase.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/utils/extensions.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final IngredientUseCase _ingredientUseCase;

  IngredientBloc(this._ingredientUseCase) : super(const IngredientState()) {
    on<GetIngredientEvent>((event, emit) async {
      emit.call(state.copyWith(loading: true, status: IngredientStatus.none));
      emit.call(await _get());
    });

    on<FilterIngredientsEvent>((event, emit) async {
      emit.call(state.copyWith(loading: true));
      emit.call(await _filter(event.name));
    });
  }

  Future<IngredientState> _get() async {
    ResponseState response = await _ingredientUseCase.get();
    if (response is ResponseFailed) {
      return state.copyWith(
        loading: false,
        ingredients: [],
        status: IngredientStatus.hasError,
        errorMessage: response.error!.error.toString(),
      );
    }
    return state.copyWith(
      loading: false,
      ingredients: response.data,
      status: IngredientStatus.none,
      errorMessage: '',
    );
  }

  Future<IngredientState> _filter(String name) async {
    ResponseState response = await _ingredientUseCase.get(
      queryParams: name.isNotEmpty ? {'name': name.capitalize()} : null,
    );
    return state.copyWith(
      ingredients: response.data,
      loading: false,
    );
  }
}
