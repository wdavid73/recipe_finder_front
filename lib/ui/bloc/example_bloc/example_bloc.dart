import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:front_scaffold_flutter/data/api/response.dart';
import 'package:front_scaffold_flutter/domain/usecase/example_usecase.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleUseCase _exampleUseCase;

  ExampleBloc(this._exampleUseCase) : super(ExampleInitial()) {
    on<ExampleEvent>((event, emit) {
      _getExample();
    });
  }
  Future<ExampleState> _getExample() async {
    ResponseState response = await _exampleUseCase.get();
    if (kDebugMode) {
      print(response);
    }
    return state;
  }
}
