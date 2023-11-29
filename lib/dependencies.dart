import 'package:front_scaffold_flutter/data/repository_impl/example_repository_impl.dart';
import 'package:front_scaffold_flutter/domain/repository/example_repository.dart';
import 'package:front_scaffold_flutter/domain/usecase/example_usecase.dart';
import 'package:front_scaffold_flutter/ui/bloc/bloc_imports.dart';
import 'package:front_scaffold_flutter/ui/bloc/example_bloc/example_bloc.dart';

List<RepositoryProvider> buildRepositories() {
  return [
    RepositoryProvider<ExampleRepository>(
      create: (context) => ExampleRepositoryImpl(context.read()),
    ),
    RepositoryProvider<ExampleUseCase>(
      create: (context) => ExampleUseCase(context.read()),
    )
  ];
}

List<BlocProvider> buildBlocs() {
  return [
    BlocProvider<ExampleBloc>(
      create: (context) => ExampleBloc(context.read()),
    )
  ];
}
