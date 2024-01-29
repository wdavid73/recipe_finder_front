import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class InputSearchSuggestion extends StatelessWidget {
  final Widget childBuilder;
  final String label;
  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final double bottomMargin;
  final String? Function(String?)? validator;
  final EdgeInsets padding;
  final Widget? iconSuffix;
  final void Function()? onPressedSuffix;

  const InputSearchSuggestion({
    super.key,
    required this.childBuilder,
    required this.label,
    required this.focusNode,
    required this.controller,
    this.onChanged,
    this.bottomMargin = 20,
    this.validator,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.iconSuffix,
    this.onPressedSuffix,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      width: responsive.width,
      margin: EdgeInsets.only(bottom: bottomMargin),
      child: Column(
        children: [
          Padding(
            padding: padding,
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              validator: validator,
              decoration: InputDecoration(
                labelText: label,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: iconSuffix != null
                    ? IconButton(
                        icon: iconSuffix!,
                        onPressed: onPressedSuffix,
                      )
                    : null,
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(maxHeight: responsive.hp(30)),
            padding: EdgeInsets.symmetric(
              vertical: focusNode.hasFocus ? 10 : 0,
            ),
            child: Card(
              margin: EdgeInsets.zero,
              child:
                  focusNode.hasFocus ? childBuilder : const SizedBox.shrink(),
            ),
          )
        ],
      ),
    );
  }
}

class EmptyBuilder extends StatelessWidget {
  const EmptyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: Text(
        context.translate('not_found_item'),
        style: getMediumStyle(),
      ),
    );
  }
}

class ErrorBuilder extends StatelessWidget {
  const ErrorBuilder({super.key});

  @override
  Widget build(BuildContext context) {
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
}
