part of 'category_bloc.dart';

enum CategoryStatus { none, hasError }

class CategoryState extends Equatable {
  final bool loading;
  final String errorMessage;
  final CategoryStatus status;
  final List<Category> categories;

  const CategoryState({
    this.loading = false,
    this.errorMessage = '',
    this.status = CategoryStatus.none,
    this.categories = const <Category>[],
  });

  @override
  List<Object> get props => [loading, errorMessage, status, categories];

  CategoryState copyWith({
    bool? loading,
    String? errorMessage,
    CategoryStatus? status,
    List<Category>? categories,
  }) =>
      CategoryState(
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        categories: categories ?? this.categories,
      );
}
