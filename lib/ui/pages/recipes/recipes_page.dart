import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipe_finder/data/models/recipe.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/recipe/recipe_bloc.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/bottom_sheet_filter_recipe.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/functions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/image_network.dart';
import 'package:recipe_finder/widgets/input_custom.dart';
import 'package:recipe_finder/widgets/loading.dart';
import 'package:recipe_finder/widgets/loading_first_page.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage>
    with SingleTickerProviderStateMixin {
  bool showSearchRecipe = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  Duration animationDuration = const Duration(milliseconds: 500);
  final PagingController<int, Recipe> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: animationDuration,
      reverseDuration: animationDuration,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _resetParams();
    _init();
    super.initState();
  }

  void showSearchRecipeBar(bool show) {
    if (show) {
      setState(() => showSearchRecipe = show);
      _animationController.forward();
    } else {
      _animationController
          .reverse()
          .then((value) => setState(() => showSearchRecipe = show));
    }
  }

  void showBottomSheetFilter() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return const BottomSheetFiltersRecipe();
      },
      isDismissible: false,
    ).then((value) {
      if (value != null) {
        _pagingController.refresh();
      }
    });
  }

  void _resetParams() {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    recipeBloc.add(ResetParamsEvent());
  }

  void _init() {
    _pagingController.addPageRequestListener(_fetchData);
  }

  Future<void> _fetchData(int pageKey) async {
    try {
      final recipeBloc = BlocProvider.of<RecipeBloc>(context);
      recipeBloc.add(SetParamsEvent(key: 'skip', value: pageKey));
      recipeBloc.add(GetRecipesByUser());
    } catch (e) {
      _pagingController.error = e;
    }
  }

  void _setItemsInPage() {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    insertItemsInList(
      pagingController: _pagingController,
      items: recipeBloc.state.recipes,
      skip: recipeBloc.state.params['skip'],
      limit: recipeBloc.state.params['limit'],
      total: recipeBloc.state.total,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: _titleAppBar(context, responsive),
        centerTitle: true,
        actions: [
          !showSearchRecipe
              ? IconButton(
                  onPressed: () => showSearchRecipeBar(true),
                  icon: Icon(Icons.search, size: responsive.dp(2.5)),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: responsive.width,
          height: responsive.height,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ButtonCustom(
                  onPressed: () => NavigationManager.go(
                    context,
                    'create_recipe',
                    transition: 'slide',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add),
                      Text(
                        context.translate('create_recipe'),
                        style: getMediumStyle(
                          fontSize: responsive.dp(1.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocConsumer<RecipeBloc, RecipeState>(
                listenWhen: (previous, current) {
                  return previous.statusGet == GetRecipeStatus.none &&
                      current.statusGet == GetRecipeStatus.success;
                },
                listener: (context, state) {
                  if (state.statusGet == GetRecipeStatus.success) {
                    _setItemsInPage();
                  }
                },
                builder: (context, state) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(milliseconds: 500))
                            .then(
                          (_) => Future.sync(
                            () => _pagingController.refresh(),
                          ),
                        );
                      },
                      child: PagedListView<int, Recipe>(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Recipe>(
                          firstPageProgressIndicatorBuilder: (context) {
                            return const LoadingFirstPage();
                          },
                          newPageProgressIndicatorBuilder: (context) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Loading(
                                orientation: Orientation.landscape,
                              ),
                            );
                          },
                          itemBuilder: (context, recipe, index) {
                            return Animate(
                              effects: const [
                                SlideEffect(
                                  begin: Offset(1.0, 0.0),
                                  end: Offset(0, 0),
                                  curve: Curves.decelerate,
                                ),
                              ],
                              child: _recipeItem(recipe, responsive, context),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedSwitcher _titleAppBar(BuildContext context, Responsive responsive) {
    return AnimatedSwitcher(
      duration: animationDuration,
      child: showSearchRecipe
          ? SlideTransition(
              position: _slideAnimation,
              child: InputCustom(
                onChange: (value) {},
                hint: context.translate('search'),
                label: context.translate('search'),
                bottomPadding: 0,
                iconPrefix: const Icon(Icons.search),
                customSuffixWidget: Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => showSearchRecipeBar(false),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Gap(5),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => showBottomSheetFilter(),
                          icon: const Icon(
                            Icons.tune,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Text(
              context.translate('my_recipes'),
              style: getSemiBoldStyle(
                fontSize: responsive.dp(1.8),
              ),
            ),
    );
  }

  Widget _recipeItem(
      Recipe recipe, Responsive responsive, BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(bottom: 20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ColorManager.placeholderColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            color: ColorManager.accentColorLight,
            width: responsive.width,
            child: _recipeInformation(
              recipe,
              responsive,
              context,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: responsive.width,
              child: ImageNetwork(
                imageUrl: recipe.mainPicture,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _recipeInformation(
      Recipe recipe, Responsive responsive, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(1.6),
                        ),
                        children: [
                          TextSpan(text: "${recipe.id} - "),
                          TextSpan(text: recipe.name.capitalize()),
                          const TextSpan(text: ' - '),
                          TextSpan(
                            text: context.translate(
                              recipe.category.name
                                  .toLowerCase()
                                  .replaceAll(' ', '_'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      recipe.rating,
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(1.6),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: responsive.dp(2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
