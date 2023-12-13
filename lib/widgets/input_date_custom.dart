import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

class InputDateCustom extends StatelessWidget {
  final String hint;
  final String label;
  final double bottomPadding;
  final double? width;
  final Icon? iconPrefix;
  final Color? labelColor;
  final TextEditingController? controller;
  final void Function() onTap;
  final String? Function(String? text)? validator;
  final bool enable;
  final bool readOnly;

  const InputDateCustom({
    super.key,
    required this.onTap,
    required this.hint,
    required this.label,
    this.validator,
    this.iconPrefix,
    this.width,
    this.bottomPadding = 20,
    this.controller,
    this.labelColor,
    this.enable = true,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final InputDecorationTheme inputTheme =
        Theme.of(context).inputDecorationTheme;
    return Container(
      width: width ?? responsive.wp(90),
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: TextFormField(
        enabled: enable,
        readOnly: readOnly,
        controller: controller,
        autofocus: false,
        cursorColor: ColorManager.accentColor,
        maxLines: 1,
        style: getRegularStyle(
          color: Colors.white,
          fontSize: responsive.dp(1.5),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: inputTheme.hintStyle?.merge(
            getRegularStyle(
              fontSize: responsive.dp(1.5),
            ),
          ),
          labelText: label,
          labelStyle: inputTheme.labelStyle?.merge(
            getRegularStyle(
              fontSize: responsive.dp(1.5),
            ),
          ),
          prefixIcon: iconPrefix,
        ),
        textAlign: TextAlign.start,
        validator: validator,
        onTap: onTap,
      ),
    );
  }
}
