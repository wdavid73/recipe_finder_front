import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

class ButtonCustom extends StatelessWidget {
  final double? width;
  final double? height;
  final void Function() onPressed;
  final String? text;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final double elevation;
  final bool isDisable;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  const ButtonCustom({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.elevation = 10,
    this.isDisable = false,
    this.width,
    this.height,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.child,
    this.padding,
    this.fontSize,
  }) : assert(
          (text == null && child != null) || (child == null && text != null),
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(
            color: borderColor ??
                backgroundColor ??
                ColorManager.secondaryAccentColor,
            width: 1,
          ),
          textStyle: getRegularStyle(),
        ),
        onPressed: !isLoading && !isDisable ? onPressed : null,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              width: isLoading ? 24 : 0,
              height: isLoading ? 24 : 0,
            ),
            child ??
                Text(
                  "$text",
                  textAlign: TextAlign.center,
                  style: getMediumStyle(
                    fontSize: fontSize ?? 14,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
