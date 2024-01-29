import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/category/category_bloc.dart';
import 'package:recipe_finder/ui/bloc/recipe/recipe_bloc.dart';
import 'package:recipe_finder/ui/managers/font_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/recipes/widgets/input_autocomplete_search.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';
import 'package:recipe_finder/widgets/loadings.dart';
import 'package:recipe_finder/widgets/star_ratings.dart';

class BottomSheetFiltersRecipe extends StatefulWidget {
  const BottomSheetFiltersRecipe({
    super.key,
  });

  @override
  State<BottomSheetFiltersRecipe> createState() =>
      _BottomSheetFiltersRecipeState();
}

class _BottomSheetFiltersRecipeState extends State<BottomSheetFiltersRecipe> {
  final SearchController _searchController = SearchController();
  final FocusNode _focusNodeCategory = FocusNode();
  int _selectedRating = -1;

  List<Widget> ratings = [
    const StarRating(rating: 5),
    const StarRating(rating: 4),
    const StarRating(rating: 3),
    const StarRating(rating: 2),
    const StarRating(rating: 1),
  ];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    if (recipeBloc.state.params['category'] != null) {
      _searchController.text = recipeBloc.state.params['category'];
    }
    setState(
      () => _selectedRating = recipeBloc.state.params['ratings'] ?? -1,
    );
  }

  String _translateText(String text) =>
      context.translate(text.toLowerCase().replaceAll(' ', '_'));

  void setFilterParams({required String key, required dynamic value}) {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    recipeBloc.add(SetParamsEvent(key: key, value: value));
  }

  void onTapCategory(Category category) {
    String translateKey = _translateText(category.name);
    _focusNodeCategory.unfocus();
    _searchController.text = "$translateKey (${category.name})";
    setFilterParams(key: "category", value: category.name);
  }

  void onChangeSearchSuggestionCategory(String text) async {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    await Future.delayed(const Duration(milliseconds: 500));
    categoryBloc.add(FilterCategoriesEvent(name: text));
  }

  void _filterRecipe() {
    Future.delayed(const Duration(milliseconds: 100)).then(
      (_) => Navigator.pop(context, true),
    );
  }

  dynamic _setValue(String key) {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    return recipeBloc.state.params[key] != null
        ? recipeBloc.state.params[key].toString()
        : '';
  }

  void clearCategorySelect() {
    _searchController.text = '';
    setFilterParams(key: "category", value: '');
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: responsive.width,
          height:
              responsive.isKeyboardOpen ? responsive.hp(80) : responsive.hp(55),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(20),
                      _ratingFilter(context, responsive),
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
                            _categoryFilter(responsive, context),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              context.translate('cooking_time'),
                              style: getRegularStyle(
                                fontSize: FontSizeResponsive(responsive).large,
                              ),
                            ),
                            const Gap(10),
                            InputCustom(
                              onChange: (value) {
                                setFilterParams(
                                  key: 'cooking_time',
                                  value: value is String && value != ''
                                      ? int.parse(value)
                                      : value,
                                );
                              },
                              initialValue: _setValue('cooking_time'),
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
                    ],
                  ),
                ),
              ),
              const Divider(),
              const Gap(5),
              Center(
                child: ButtonCustom(
                  onPressed: () => _filterRecipe(),
                  text: context.translate('apply_filter'),
                  width: responsive.wp(70),
                ),
              ),
              const Gap(5),
            ],
          ),
        );
      },
    );
  }

  Widget _categoryFilter(Responsive responsive, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: InputSearchSuggestion(
        label: context.translate('enter_keyword_categories'),
        padding: EdgeInsets.zero,
        focusNode: _focusNodeCategory,
        controller: _searchController,
        bottomMargin: 20,
        onChanged: onChangeSearchSuggestionCategory,
        iconSuffix: const Icon(Icons.close),
        onPressedSuffix: clearCategorySelect,
        childBuilder: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state.loading) {
              return const LoadingBuilder();
            }

            if (state.status == CategoryStatus.hasError) {
              return const ErrorBuilder();
            }

            return ListView.builder(
              itemCount: state.categories.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Category category = state.categories[index];
                return ListTile(
                  title: Text(category.name.capitalize()),
                  onTap: () => onTapCategory(category),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _ratingFilter(BuildContext context, Responsive responsive) {
    return Column(
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
          height: responsive.hp(26),
          child: ListView.builder(
            itemCount: ratings.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: ratings.length - index,
                    groupValue: _selectedRating,
                    onChanged: (value) {
                      setState(() {
                        _selectedRating = value as int;
                      });
                      setFilterParams(key: 'ratings', value: value as int);
                    },
                  ),
                  ratings[index],
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
