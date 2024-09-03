import 'package:recipe_finder/data/api/api_client.dart';
import 'package:recipe_finder/data/repository_impl/auth_repository_impl.dart';
import 'package:recipe_finder/data/repository_impl/category_repository_impl.dart';
import 'package:recipe_finder/data/repository_impl/ingredient_repository_impl.dart';
import 'package:recipe_finder/data/repository_impl/recipe_repository_impl.dart';
import 'package:recipe_finder/domain/repository/auth_repository.dart';
import 'package:recipe_finder/domain/repository/category_repository.dart';
import 'package:recipe_finder/domain/repository/ingredient_repository.dart';
import 'package:recipe_finder/domain/repository/recipe_repository.dart';
import 'package:recipe_finder/domain/usecase/auth_usecase.dart';
import 'package:recipe_finder/domain/usecase/category_usecase.dart';
import 'package:recipe_finder/domain/usecase/ingredient_usecase.dart';
import 'package:recipe_finder/domain/usecase/recipe_usecase.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/category/category_bloc.dart';
import 'package:recipe_finder/ui/bloc/create_recipe/create_recipe_bloc.dart';
import 'package:recipe_finder/ui/bloc/ingredient/ingredient_bloc.dart';
import 'package:recipe_finder/ui/bloc/recipe/recipe_bloc.dart';
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
    ),
    RepositoryProvider<IngredientRepository>(
      create: (_) => IngredientRepositoryImpl(ApiClient.instance),
    ),
    RepositoryProvider<IngredientUseCase>(
      create: (context) => IngredientUseCase(context.read()),
    ),
    RepositoryProvider<RecipeRepository>(
      create: (_) => RecipeRepositoryImpl(ApiClient.instance),
    ),
    RepositoryProvider<RecipeUseCase>(
      create: (context) => RecipeUseCase(context.read()),
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
    BlocProvider<IngredientBloc>(
      create: (context) => IngredientBloc(context.read()),
    ),
    BlocProvider<RecipeBloc>(
      create: (context) => RecipeBloc(context.read()),
    ),
    BlocProvider<CreateRecipeBloc>(
      create: (context) => CreateRecipeBloc(),
    )
  ];
}
