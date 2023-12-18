import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/bottom_sheet_filter_recipe.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';

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
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
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
        ),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 5),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return Animate(
                        effects: const [
                          SlideEffect(
                            begin: Offset(1.0, 0.0),
                            end: Offset(0, 0),
                            curve: Curves.decelerate,
                            delay: Duration(milliseconds: 300),
                          )
                        ],
                        child: _recipeItem(responsive, context),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recipeItem(Responsive responsive, BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(bottom: 20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            color: ColorManager.accentColorLight,
            width: responsive.width,
            child: _recipeInformation(responsive, context),
          ),
          Expanded(
            child: Container(
              width: responsive.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/recipe_image_example.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _recipeInformation(Responsive responsive, BuildContext context) {
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
                          const TextSpan(text: 'Chocolate Chip Cookies'),
                          const TextSpan(text: ' - '),
                          TextSpan(
                            text: context.translate(
                              'Soups and Stews'.toLowerCase(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /* Text(
                      "- By You",
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(1.6),
                      ),
                    ), */
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
                      "4.7",
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
