import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/home/widgets/user_avatar.dart';
import 'package:recipe_finder/ui/pages/profile/widgets/favorites_recipes.dart';
import 'package:recipe_finder/ui/pages/profile/widgets/profile_extra_information.dart';
import 'package:recipe_finder/ui/pages/profile/widgets/profile_information.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(GetFullUser());
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('profile'),
          style: getSemiBoldStyle(
            fontSize: responsive.dp(1.8),
          ),
        ),
        centerTitle: true,
        toolbarHeight: responsive.hp(8),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              width: responsive.width,
              height: responsive.height,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserAvatar(
                    responsive: responsive,
                    radius: responsive.dp(9),
                    withBorder: true,
                  ),
                  const Gap(20),
                  ButtonCustom(
                    onPressed: () {},
                    text: context.translate('edit_profile'),
                    width: responsive.wp(45),
                    isDisable: state.fullUserLoading,
                  ),
                  _builderInformation(state, context),
                  _builderList(state, context),
                  _builderExtraInformation(state, context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _builderInformation(AuthState state, BuildContext context) {
    final Responsive responsive = Responsive(context);

    if (state.fullUser == null) {
      return const SizedBox.shrink();
    }

    if (state.fullUserLoading) {
      return _builderBase(
        responsive: responsive,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            Text(
              context.translate('loading'),
              style: getRegularStyle(),
            ),
          ],
        ),
      );
    }

    return InformationContainer(
      totalRecipes: state.fullUser!.totalRecipe,
      averageRating: state.fullUser!.averageRating,
      averageTime: state.fullUser!.averageTime,
    );
  }

  Widget _builderList(AuthState state, BuildContext context) {
    if (state.fullUser == null) {
      return const SizedBox.shrink();
    }

    return FavoritesRecipes(
      recipes: state.fullUser!.recipeFavorites,
      loading: state.fullUserLoading,
    );
  }

  Widget _builderExtraInformation(AuthState state, BuildContext context) {
    final Responsive responsive = Responsive(context);
    if (state.fullUser == null) {
      return const SizedBox.shrink();
    }

    if (state.fullUserLoading) {
      return _builderBase(
        responsive: responsive,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            Text(
              context.translate('loading'),
              style: getRegularStyle(),
            ),
          ],
        ),
      );
    }

    return ExtraInformationContainer(
      totalRecipesDisable: state.fullUser!.totalRecipeDisable,
      totalRecipesEnable: state.fullUser!.totalRecipeEnable,
      totalRecipesHide: state.fullUser!.totalRecipeHide,
    );
  }

  Widget _builderBase({required Responsive responsive, Widget? child}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: responsive.width,
        height: responsive.hp(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ColorManager.secondaryBackgroundColor,
            width: 5,
          ),
        ),
        child: child,
      ),
    );
  }
}
