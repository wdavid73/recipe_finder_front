import 'package:recipe_finder/data/api/api_client.dart';
import 'package:recipe_finder/data/repository_impl/auth_repository_impl.dart';
import 'package:recipe_finder/data/repository_impl/category_repository_impl.dart';
import 'package:recipe_finder/domain/repository/auth_repository.dart';
import 'package:recipe_finder/domain/repository/category_repository.dart';
import 'package:recipe_finder/domain/usecase/auth_usecase.dart';
import 'package:recipe_finder/domain/usecase/category_usecase.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/category/category_bloc.dart';
import 'package:recipe_finder/ui/pages/settings/cubit/settings_cubit.dart';
import 'package:recipe_finder/ui/pages/splash_screen/cubit/splash_screen_cubit.dart';

List<RepositoryProvider> buildRepositories() {
  return [
    // AUTH
    RepositoryProvider<AuthRepository>(
      create: (_) => AuthRepositoryImpl(ApiClient.instance),
    ),
    RepositoryProvider<AuthUseCase>(
      create: (context) => AuthUseCase(context.read()),
    ),
    RepositoryProvider<CategoryRepository>(
      create: (_) => CategoryRepositoryImpl(ApiClient.instance),
    ),
    RepositoryProvider<CategoryUseCase>(
      create: (context) => CategoryUseCase(context.read()),
    )
  ];
}

List<BlocProvider> buildBlocs() {
  return [
    BlocProvider<SettingsCubit>(create: (_) => SettingsCubit()),
    BlocProvider<SplashScreenCubit>(create: (_) => SplashScreenCubit()),
    BlocProvider<AuthBloc>(create: (context) => AuthBloc(context.read())),
    BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(context.read()),
    ),
  ];
}
