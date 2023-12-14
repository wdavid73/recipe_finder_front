import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/font_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/constants.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';
import 'package:recipe_finder/widgets/star_ratings.dart';

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
        toolbarHeight: responsive.hp(8),
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
          child: Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return Container(
                    height: 300,
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
                },
              ),
            ),
          ),
        ),
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

class BottomSheetFiltersRecipe extends StatefulWidget {
  const BottomSheetFiltersRecipe({
    super.key,
  });

  @override
  State<BottomSheetFiltersRecipe> createState() =>
      _BottomSheetFiltersRecipeState();
}

class _BottomSheetFiltersRecipeState extends State<BottomSheetFiltersRecipe> {
  int _selectedRating = -1;

  List<Widget> ratings = [
    const StarRating(rating: 5),
    const StarRating(rating: 4),
    const StarRating(rating: 3),
    const StarRating(rating: 2),
    const StarRating(rating: 1),
  ];

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: responsive.width,
      height: responsive.isKeyboardOpen ? responsive.hp(80) : responsive.hp(55),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                context.translate('filters'),
                style: getSemiBoldStyle(
                  fontSize: FontSizeResponsive(responsive).extraExtraLarge,
                ),
              ),
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    context.translate('rating'),
                    style: getRegularStyle(
                      fontSize: FontSizeResponsive(responsive).large,
                    ),
                  ),
                ),
                SizedBox(
                  width: responsive.width,
                  height: responsive.hp(25),
                  child: ListView.builder(
                    itemCount: ratings.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: index,
                            groupValue: _selectedRating,
                            onChanged: (value) {
                              setState(() {
                                _selectedRating = value as int;
                              });
                            },
                          ),
                          ratings[index],
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    context.translate('category'),
                    style: getRegularStyle(
                      fontSize: FontSizeResponsive(responsive).large,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const SearchInputCustom(),
                  ),
                ],
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InputCustom(
                    onChange: (value) {},
                    hint: context.translate('cooking_time'),
                    label: context.translate('cooking_time'),
                    iconPrefix: const Icon(Icons.timer_outlined),
                    textSuffix: context.translate('minute'),
                    keyboardType: TextInputType.number,
                    width: responsive.width,
                  ),
                ],
              ),
            ),
            const Gap(20),
            Center(
              child: ButtonCustom(
                onPressed: () {},
                text: context.translate('apply_filter'),
                width: responsive.wp(70),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class SearchInputCustom extends StatefulWidget {
  const SearchInputCustom({super.key});

  @override
  State<SearchInputCustom> createState() => _SearchInputCustomState();
}

class _SearchInputCustomState extends State<SearchInputCustom> {
  final SearchController _searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return SizedBox(
      width: responsive.width,
      height: 50,
      child: SearchAnchor.bar(
        searchController: _searchController,
        barLeading: const Icon(Icons.search),
        barHintText: context.translate('tap_search'),
        constraints: BoxConstraints(
          maxWidth: responsive.width,
        ),
        viewTrailing: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () => _searchController.clear(),
          ),
        ],
        viewLeading: IconButton(
          onPressed: () {
            FocusNode tempFocusNode = FocusNode();
            FocusScope.of(context).requestFocus(tempFocusNode);
            Future.delayed(const Duration(milliseconds: 50), () {
              _searchController.closeView(_searchController.value.text);
              FocusScope.of(context).requestFocus(tempFocusNode);
            });
          },
          icon: Icon(Icons.adaptive.arrow_back),
        ),
        viewHintText: context.translate('enter_keyword'),
        viewConstraints: const BoxConstraints(
          maxWidth: 300,
          maxHeight: 300,
        ),
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          final keyword = controller.value.text;

          return List.generate(
            categories.length,
            (index) => categories[index]['name'],
          )
              .where((element) => element.toLowerCase().startsWith(
                    keyword.toLowerCase(),
                  ))
              .map(
                (item) => GestureDetector(
                  onTap: () {
                    setState(() => controller.closeView(item));
                  },
                  child: ListTile(
                    title: Text(
                      item,
                      style: getRegularStyle(),
                    ),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                        FocusScope.of(context).unfocus();
                      });
                    },
                  ),
                ),
              );
        },
      ),
    );
  }
}
