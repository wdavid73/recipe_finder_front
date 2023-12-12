import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

ThemeData getApplicationDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: ColorManager.primaryColor,
    primaryColorLight: ColorManager.primaryColorLight,
    primaryColorDark: ColorManager.primaryColorDark,
    disabledColor: ColorManager.disabledColor,
    splashColor: ColorManager.splashColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.secondaryColor,
      primary: Colors.white,
      onPrimary: Colors.white,
      background: ColorManager.backgroundColor,
      surface: Colors.white,
      onSurface: Colors.white,
      error: ColorManager.error,
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
      buttonColor: ColorManager.secondaryAccentColor,
      splashColor: ColorManager.splashColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: Colors.white),
        backgroundColor: ColorManager.secondaryAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    dividerColor: ColorManager.divider,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.secondaryAccentColor,
    ),
    scaffoldBackgroundColor: ColorManager.backgroundDarkColor,
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(color: ColorManager.textPrimaryLight),
      titleMedium: getMediumStyle(color: ColorManager.textPrimaryLight),
      bodySmall: getRegularStyle(color: ColorManager.textSecondary),
      bodyLarge: getRegularStyle(color: ColorManager.textPrimaryLight),
      labelSmall: getRegularStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      hintStyle: getRegularStyle(color: ColorManager.textSecondary),
      labelStyle: getMediumStyle(color: ColorManager.textPrimary),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
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
          color: ColorManager.secondaryAccentColor,
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
    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorManager.backgroundDarkColor,
      headerBackgroundColor: ColorManager.primaryColorDark,
      headerForegroundColor: Colors.white,
      headerHeadlineStyle: getBoldStyle(fontSize: 30),
      headerHelpStyle: getMediumStyle(fontSize: 16),
      dividerColor: ColorManager.divider,
      dayBackgroundColor: MaterialStatePropertyAll<Color>(
        ColorManager.secondaryAccentColor.withOpacity(0.8),
      ),
      dayForegroundColor: const MaterialStatePropertyAll<Color>(
        Colors.white,
      ),
      dayOverlayColor: MaterialStatePropertyAll<Color>(
        ColorManager.primaryColorDark.withOpacity(0.8),
      ),
      dayStyle: getRegularStyle(fontSize: 14),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(8),
        hintStyle: getRegularStyle(color: ColorManager.textSecondary),
        labelStyle: getMediumStyle(color: ColorManager.textPrimary),
        errorStyle: getRegularStyle(color: ColorManager.error),
      ),
      rangePickerBackgroundColor: Colors.blue,
      rangePickerElevation: 0,
      rangePickerHeaderBackgroundColor: ColorManager.primaryColorDark,
      rangePickerHeaderForegroundColor: Colors.white,
      rangePickerHeaderHeadlineStyle: getBoldStyle(fontSize: 30),
      rangePickerHeaderHelpStyle: getMediumStyle(fontSize: 16),
      surfaceTintColor: Colors.transparent,
      todayBackgroundColor: MaterialStatePropertyAll<Color>(
        ColorManager.splashColor,
      ),
      todayForegroundColor: const MaterialStatePropertyAll<Color>(
        Colors.white,
      ),
      weekdayStyle: getRegularStyle(
        color: ColorManager.textPrimaryLight,
        fontSize: 14,
      ),
      yearBackgroundColor: MaterialStatePropertyAll<Color>(
        ColorManager.secondaryAccentColor,
      ),
      yearOverlayColor: MaterialStatePropertyAll<Color>(
        ColorManager.primaryColorDark.withOpacity(0.8),
      ),
      yearStyle: getMediumStyle(fontSize: 14),
      yearForegroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: ColorManager.backgroundDarkColor,
      surfaceTintColor: ColorManager.secondaryBackgroundColor,
      scrimColor: Colors.black54,
      shadowColor: ColorManager.shadowColorDark,
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStatePropertyAll<Color>(
        ColorManager.secondaryAccentColor.withOpacity(0.5),
      ),
      thumbColor: MaterialStatePropertyAll<Color>(
        ColorManager.secondaryAccentColor,
      ),
      trackOutlineColor: const MaterialStatePropertyAll<Color>(
        Colors.transparent,
      ),
      trackOutlineWidth: const MaterialStatePropertyAll<double>(0),
    ),
  );
}
