part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends CategoryEvent {}

class FilterCategoriesEvent extends CategoryEvent {
  final String name;
  const FilterCategoriesEvent({required this.name});
}
