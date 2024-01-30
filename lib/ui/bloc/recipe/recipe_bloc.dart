import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/data/models/list_data.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/domain/usecase/recipe_usecase.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeUseCase _recipeUseCase;
  RecipeBloc(this._recipeUseCase) : super(const RecipeState()) {
    on<SetParamsEvent>((event, emit) {
      emit.call(_setParams(key: event.key, value: event.value));
    });

    on<ResetParamsEvent>((event, emit) {
      emit.call(_resetParams());
    });

    on<CreateRecipe>((event, emit) async {
      emit.call(state.copyWith(
        loadingCreate: true,
        status: CreateRecipeStatus.none,
      ));
      emit.call(await _create(event.data));
    });

    on<GetRecipesByUser>((event, emit) async {
      emit.call(state.copyWith(
        loading: true,
        statusGet: GetRecipeStatus.none,
        recipes: const <Recipe>[],
      ));
      emit.call(await _getRecipesByUser());
    });

    on<GetLastFiveRecipe>((event, emit) async {
      emit.call(state.copyWith(
        loading: true,
        lastFiveRecipes: <Recipe>[],
      ));
      emit.call(await _getLastFiveRecipes());
    });
  }

  RecipeState _setParams({required String key, required dynamic value}) {
    Map<String, dynamic> params = {};
    params.addAll(state.params);
    params[key] = value;
    return state.copyWith(params: params);
  }

  RecipeState _resetParams() {
    return state.copyWith(params: {
      'skip': 0,
      'limit': 15,
    });
  }

  Future<RecipeState> _getRecipesByUser() async {
    ResponseState response = await _recipeUseCase.get(
      queryParams: state.params,
    );
    if (response is ResponseFailed) {
      return state.copyWith(
        loading: false,
        recipes: <Recipe>[],
        total: 0,
        statusGet: GetRecipeStatus.error,
        errorMessage: response.error!.error.toString(),
      );
    }
    ListData listData = response.data as ListData;
    return state.copyWith(
      loading: false,
      recipes: listData.data as List<Recipe>,
      total: listData.total,
      statusGet: GetRecipeStatus.success,
    );
  }

  Future<RecipeState> _create(FormData body) async {
    ResponseState response = await _recipeUseCase.create(body: body);
    if (response is ResponseFailed) {
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

  Future<RecipeState> _getLastFiveRecipes() async {
    ResponseState response = await _recipeUseCase.getLastFive();
    if (response is ResponseFailed) {
      return state.copyWith(
        loading: false,
        lastFiveRecipes: <Recipe>[],
        errorMessage: response.error!.error.toString(),
      );
    }
    return state.copyWith(
      loading: false,
      lastFiveRecipes: response.data,
    );
  }
}
