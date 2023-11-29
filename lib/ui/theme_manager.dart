import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter/ui/color_manager.dart';
import 'package:front_scaffold_flutter/ui/style_text_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: ColorManager.primaryColor,
    primaryColorLight: ColorManager.primaryColorLight,
    primaryColorDark: ColorManager.primaryColorDark,
    disabledColor: ColorManager.disabledColor,
    splashColor: ColorManager.splashColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.secondaryColor,
      primary: ColorManager.primaryColor,
      onPrimary: Colors.white,
      background: ColorManager.backgroundColor,
    ),
    dialogBackgroundColor: ColorManager.secondaryBackgroundColor,
    cardTheme: const CardTheme(
      color: Colors.black12,
      shadowColor: Colors.black54,
      elevation: 4,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      color: ColorManager.primaryColor,
      elevation: 4,
      shadowColor: Colors.black54,
      titleTextStyle: getMediumStyle(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: Colors.grey,
      buttonColor: ColorManager.secondaryColor,
      splashColor: ColorManager.secondaryAccentColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: Colors.white),
        backgroundColor: ColorManager.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(color: ColorManager.textPrimary),
      titleMedium: getMediumStyle(color: ColorManager.textPrimary),
      bodySmall: getRegularStyle(color: ColorManager.textSecondary),
      bodyLarge: getRegularStyle(color: ColorManager.textPrimary),
      labelSmall: getRegularStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      hintStyle: getRegularStyle(color: ColorManager.textSecondary),
      labelStyle: getMediumStyle(color: ColorManager.textPrimary),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryColor,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.disabledColor,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primaryColorDark,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      prefixIconColor: ColorManager.textPrimary,
    ),
  );
}
