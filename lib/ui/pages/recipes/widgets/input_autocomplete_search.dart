import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class InputAutoCompleteSearch extends StatelessWidget {
  final List<String> items;
  final List<String> selectedItems;
  final double? width;
  final String label;
  final String hintText;
  final void Function(String) onSelected;
  const InputAutoCompleteSearch({
    super.key,
    required this.items,
    required this.label,
    required this.onSelected,
    this.width,
    this.hintText = '',
    this.selectedItems = const [],
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final InputDecorationTheme inputTheme =
        Theme.of(context).inputDecorationTheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: width ?? responsive.width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(top: 20),
        child: TypeAheadField(
          builder: (context, controller, focusNode) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: false,
              decoration: InputDecoration(
                hintStyle: inputTheme.hintStyle?.merge(
                  getRegularStyle(
                    fontSize: responsive.dp(1.5),
                  ),
                ),
                labelStyle: inputTheme.labelStyle?.merge(
                  getRegularStyle(
                    fontSize: responsive.dp(1.5),
                  ),
                ),
                suffixStyle: inputTheme.suffixStyle?.merge(
                  getRegularStyle(
                    fontSize: responsive.dp(1.5),
                  ),
                ),
                labelText: label,
                hintText: hintText,
              ),
            );
          },
          itemBuilder: (context, value) {
            final isSelected = selectedItems.contains(value);
            return ListTile(
              title: Text(
                value,
                style: getMediumStyle(
                  color: ColorManager.textPrimary,
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle_rounded,
                      color: ColorManager.accentColor,
                    )
                  : null,
            );
          },
          onSelected: (value) {
            if (!selectedItems.contains(value)) {
              onSelected(value);
            }
          },
          suggestionsCallback: (pattern) async {
            await Future.delayed(const Duration(seconds: 2));
            return items
                .where((element) =>
                    element.toLowerCase().contains(pattern.toLowerCase()) &&
                    !selectedItems.contains(element))
                .toList();
          },
          offset: const Offset(0, 0),
          loadingBuilder: (context) => _loadingBuilder(context),
          errorBuilder: (context, error) => _errorBuilder(context),
          emptyBuilder: (context) => _emptyBuilder(context),
        ),
      ),
    );
  }

  Widget _emptyBuilder(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: Text(
        context.translate('not_found_item'),
        style: getMediumStyle(
          color: ColorManager.textPrimary,
        ),
      ),
    );
  }

  Widget _errorBuilder(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: Text(
        context.translate('error'),
        style: getMediumStyle(
          color: ColorManager.error,
        ),
      ),
    );
  }

  Widget _loadingBuilder(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator.adaptive(),
          ),
          const Gap(10),
          Text(
            context.translate('loading'),
            style: getMediumStyle(
              color: ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
