import 'package:equatable/equatable.dart';
import 'package:recipe_finder/domain/usecase/category_usecase.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase _categoryUseCase;
  CategoryBloc(this._categoryUseCase) : super(const CategoryState()) {
    on<GetCategories>((event, emit) async {
      emit.call(await _get());
    });
  }

  Future<CategoryState> _get() async {
    return state;
  }
}
