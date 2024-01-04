import 'package:recipe_finder/data/api/api_client.dart';
import 'package:recipe_finder/data/repository_impl/auth_repository_impl.dart';
import 'package:recipe_finder/data/repository_impl/example_repository_impl.dart';
import 'package:recipe_finder/domain/repository/auth_repository.dart';
import 'package:recipe_finder/domain/repository/example_repository.dart';
import 'package:recipe_finder/domain/usecase/auth_usecase.dart';
import 'package:recipe_finder/domain/usecase/example_usecase.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/example_bloc/example_bloc.dart';
import 'package:recipe_finder/ui/pages/settings/cubit/settings_cubit.dart';

List<RepositoryProvider> buildRepositories() {
  return [
    // AUTH
    RepositoryProvider<AuthRepository>(
      create: (_) => AuthRepositoryImpl(ApiClient.instance),
    ),
    RepositoryProvider<AuthUseCase>(
      create: (context) => AuthUseCase(context.read()),
    ),
    // EXAMPLE
    RepositoryProvider<ExampleRepository>(
      create: (context) => ExampleRepositoryImpl(ApiClient.instance),
    ),
    RepositoryProvider<ExampleUseCase>(
      create: (context) => ExampleUseCase(context.read()),
    ),
  ];
}

List<BlocProvider> buildBlocs() {
  return [
    BlocProvider<SettingsCubit>(create: (_) => SettingsCubit()),
    BlocProvider<AuthBloc>(create: (context) => AuthBloc(context.read())),
    BlocProvider<ExampleBloc>(
      create: (context) => ExampleBloc(context.read()),
    ),
  ];
}
