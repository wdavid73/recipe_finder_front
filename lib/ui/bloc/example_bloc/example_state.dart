part of 'example_bloc.dart';

sealed class ExampleState extends Equatable {
  const ExampleState();

  @override
  List<Object> get props => [];
}

final class ExampleInitial extends ExampleState {
  const ExampleInitial();

  @override
  List<Object> get props => [];
}

final class ExampleLoading extends ExampleState {
  const ExampleLoading();

  @override
  List<Object> get props => [];
}

final class ExampleLoaded extends ExampleState {
  final dynamic data;

  const ExampleLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class ExampleError extends ExampleState {
  final String? errorMessage;

  const ExampleError(this.errorMessage);

  @override
  List<Object> get props => [];
}
