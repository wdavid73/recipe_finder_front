import 'package:equatable/equatable.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/domain/usecase/category_usecase.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase _categoryUseCase;
  CategoryBloc(this._categoryUseCase) : super(const CategoryState()) {
    on<GetCategories>((event, emit) async {
      emit.call(state.copyWith(loading: true, status: CategoryStatus.none));
      emit.call(await _get());
    });
  }

  Future<CategoryState> _get() async {
    ResponseState response = await _categoryUseCase.get();
    if (response is ResponseFailed) {
      return state.copyWith(
        loading: false,
        categories: [],
        status: CategoryStatus.hasError,
        errorMessage: response.error!.error.toString(),
      );
    }
    return state.copyWith(
      loading: false,
      categories: response.data,
      status: CategoryStatus.none,
      errorMessage: '',
    );
  }
}
