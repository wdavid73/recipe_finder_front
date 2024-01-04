import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/data/api/response.dart';
import 'package:recipe_finder/domain/usecase/example_usecase.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleUseCase _exampleUseCase;

  ExampleBloc(this._exampleUseCase) : super(const ExampleInitial()) {
    on<GetExample>((event, emit) async {
      emit(const ExampleLoading());
      emit(await _getExample());
    });
  }
  Future<ExampleState> _getExample() async {
    ResponseState response = await _exampleUseCase.get();
    if (response is ResponseFailed) {
      return ExampleError(response.error?.message);
    }
    return ExampleLoaded(response.data["mensaje"]);
  }
}
