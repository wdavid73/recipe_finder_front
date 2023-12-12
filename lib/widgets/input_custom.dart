import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/settings/cubit/settings_cubit.dart';

class InputCustom extends StatelessWidget {
  final String hint;
  final String label;
  final String? textPrefix;
  final String? initialValue;
  final String? textSuffix;
  final int? maxLengthInput;
  final double bottomPadding;
  final double? width;
  final bool isPassword;
  final bool obscureText;
  final Icon? iconPrefix;
  final Color? labelColor;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final void Function(dynamic value) onChange;
  final String? Function(String? text)? validator;
  final void Function()? showPassword;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final bool readOnly;
  final Widget? customSuffixWidget;
  final TextInputAction inputAction;

  const InputCustom({
    super.key,
    required this.onChange,
    required this.hint,
    required this.label,
    this.validator,
    this.iconPrefix,
    this.width,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.obscureText = false,
    this.bottomPadding = 20,
    this.showPassword,
    this.maxLengthInput,
    this.initialValue,
    this.inputFormatters,
    this.controller,
    this.textPrefix,
    this.labelColor,
    this.textSuffix,
    this.enable = true,
    this.readOnly = false,
    this.customSuffixWidget,
    this.inputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final InputDecorationTheme inputTheme =
        Theme.of(context).inputDecorationTheme;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Container(
          width: width ?? responsive.wp(90),
          margin: EdgeInsets.only(bottom: bottomPadding),
          child: TextFormField(
            textInputAction: inputAction,
            enabled: enable,
            readOnly: readOnly,
            controller: controller,
            autofocus: false,
            cursorColor: ColorManager.secondaryAccentColor,
            initialValue: initialValue,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLength: maxLengthInput,
            inputFormatters: inputFormatters,
            maxLines: 1,
            style: getRegularStyle(
              fontSize: responsive.dp(1.5),
              color: state == SettingsState.isDarkTheme
                  ? Colors.white
                  : ColorManager.textPrimary,
              textDecoration: TextDecoration.none,
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
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () => showPassword!(),
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: ColorManager.textSecondary,
                      ),
                    )
                  : customSuffixWidget ?? const SizedBox.shrink(),
            ),
            textAlign: TextAlign.start,
            validator: validator,
            onChanged: onChange,
          ),
        );
      },
    );
  }
}
