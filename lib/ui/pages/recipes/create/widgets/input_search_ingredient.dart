import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/ingredient.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/ingredient/ingredient_bloc.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';

class InputSearchIngredient extends StatefulWidget {
  final void Function(String)? onChangeSearchSuggestion;
  final void Function(List<Ingredient>) onChange;
  final String? Function(List<Ingredient>?)? validator;
  final TextEditingController controller;
  final FocusNode focusNode;

  const InputSearchIngredient({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChange,
    this.onChangeSearchSuggestion,
    this.validator,
  });

  @override
  State<InputSearchIngredient> createState() => _InputSearchIngredientState();
}

class _InputSearchIngredientState extends State<InputSearchIngredient> {
  final _multiKey = GlobalKey<DropdownSearchState<Ingredient>>();
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return BlocBuilder<IngredientBloc, IngredientState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: DropdownSearch<Ingredient>.multiSelection(
            key: _multiKey,
            items: state.ingredients,
            onChanged: widget.onChange,
            validator: widget.validator,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            clearButtonProps: const ClearButtonProps(isVisible: true),
            popupProps: PopupPropsMultiSelection.modalBottomSheet(
              itemBuilder: _customPopupItemBuilder,
              containerBuilder: (ctx, popupWidget) {
                return SizedBox(
                  width: responsive.width,
                  height: responsive.hp(40),
                  child: Card(
                    child: Column(
                      children: [
                        _popupTitle(responsive, ctx),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _selectAll(responsive),
                            _selectNone(responsive),
                            const Spacer(),
                            SizedBox(width: 50, child: _close()),
                          ],
                        ),
                        Expanded(child: popupWidget)
                      ],
                    ),
                  ),
                );
              },
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: context.translate('find_ingredient'),
                hintText: context.translate('find_ingredient'),
              ),
            ),
            itemAsString: (item) {
              return item.name;
            },
            dropdownBuilder: _customDropdownMultiSelection,
          ),
        );
      },
    );
  }

  Widget _customDropdownMultiSelection(
      BuildContext context, List<Ingredient> selectedItems) {
    final Responsive responsive = Responsive(context);
    if (selectedItems.isEmpty) {
      return Text(
        context.translate('no_item_selected'),
      );
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: responsive.hp(7),
      ),
      child: SingleChildScrollView(
        child: Wrap(
          children: selectedItems.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Chip(
                label: Text(
                  e.name,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                visualDensity: VisualDensity.compact,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _customPopupItemBuilder(
      BuildContext context, Ingredient ingredient, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        selected: isSelected,
        title: Text(ingredient.name.capitalize()),
        subtitle: Text(
          ingredient.category.capitalize(),
        ),
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Padding _close() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => _multiKey.currentState?.closeDropDownSearch(),
      ),
    );
  }

  Padding _selectNone(Responsive responsive) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ButtonCustom(
        onPressed: () {
          _multiKey.currentState?.popupDeselectAllItems();
        },
        child: Text(
          'None',
          style: getMediumStyle(
            fontSize: responsive.dp(1.6),
          ),
        ),
      ),
    );
  }

  Padding _selectAll(Responsive responsive) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ButtonCustom(
        onPressed: () {
          _multiKey.currentState?.popupSelectAllItems();
        },
        child: Text(
          'All',
          style: getMediumStyle(
            fontSize: responsive.dp(1.6),
          ),
        ),
      ),
    );
  }

  Container _popupTitle(Responsive responsive, BuildContext context) {
    return Container(
      height: 50,
      width: responsive.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorManager.accentColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      child: Text(
        context.translate("select_ingredient"),
        style: getMediumStyle(
          fontSize: responsive.dp(2),
        ),
      ),
    );
  }
}
