part of 'ingredient_bloc.dart';

sealed class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object> get props => [];
}

class GetIngredientEvent extends IngredientEvent {}

class FilterIngredientsEvent extends IngredientEvent {
  final String name;
  const FilterIngredientsEvent({required this.name});
}
