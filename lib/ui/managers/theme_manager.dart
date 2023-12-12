import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

ThemeData getApplicationDarkTheme({bool isDark = true}) {
  return ThemeData(
    useMaterial3: true,
    primaryColor: isDark ? ColorManager.primaryColor : Colors.red,
    primaryColorLight: ColorManager.primaryColorLight,
    primaryColorDark: ColorManager.primaryColorDark,
    disabledColor: ColorManager.disabledColor,
    splashColor: ColorManager.splashColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.secondaryColor,
      background: ColorManager.backgroundColor,
      surface: isDark ? Colors.white : ColorManager.primaryColorLight,
      onSurface: isDark ? Colors.white : Colors.black, // TEXT COLOR
      error: ColorManager.error,
      primary: ColorManager.primaryColor,
      primaryContainer: isDark
          ? ColorManager.backgroundDarkColor
          : ColorManager.secondaryBackgroundColor,
    ),
    scaffoldBackgroundColor: isDark
        ? ColorManager.backgroundDarkColor
        : ColorManager.backgroundColor,
    dialogBackgroundColor: ColorManager.secondaryBackgroundColor,
    cardTheme: CardTheme(
      color: isDark
          ? ColorManager.backgroundDarkColor
          : ColorManager.secondaryBackgroundColor.withOpacity(0.5),
      shadowColor: isDark ? Colors.black54 : Colors.white54,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      surfaceTintColor:
          isDark ? ColorManager.backgroundColor : Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 4,
      shadowColor: Colors.black87,
      titleTextStyle: getMediumStyle(),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor:
          isDark ? ColorManager.backgroundDarkColor : ColorManager.primaryColor,
      surfaceTintColor:
          isDark ? ColorManager.backgroundDarkColor : ColorManager.primaryColor,
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: Colors.grey,
      buttonColor: ColorManager.secondaryAccentColor,
      splashColor: ColorManager.splashColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: getRegularStyle(
          color: Colors.white,
        ),
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
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(color: ColorManager.textPrimaryLight),
      titleMedium: getMediumStyle(color: ColorManager.textPrimaryLight),
      bodySmall: getRegularStyle(color: ColorManager.textSecondary),
      bodyLarge: getRegularStyle(color: ColorManager.textPrimaryLight),
      labelSmall: getRegularStyle(color: ColorManager.textPrimaryLight),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      hintStyle: getRegularStyle(
        color: isDark ? Colors.white : ColorManager.textPrimary,
      ),
      labelStyle: getMediumStyle(
        color: isDark ? Colors.white : ColorManager.textPrimary,
      ),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? Colors.white : Colors.black,
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
      prefixIconColor: ColorManager.textSecondary,
      floatingLabelStyle: getMediumStyle(
        color: isDark ? Colors.white : ColorManager.textPrimary,
        fontSize: 16,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: isDark
          ? ColorManager.backgroundDarkColor
          : ColorManager.backgroundColor,
      headerBackgroundColor: ColorManager.primaryColorDark,
      headerForegroundColor: Colors.white,
      headerHeadlineStyle: getBoldStyle(fontSize: 30),
      headerHelpStyle: getMediumStyle(fontSize: 16),
      dividerColor: ColorManager.divider,
      dayBackgroundColor: MaterialStatePropertyAll<Color>(
        isDark
            ? ColorManager.secondaryAccentColor.withOpacity(0.8)
            : Colors.white,
      ),
      dayForegroundColor: MaterialStatePropertyAll<Color>(
        isDark ? Colors.white : ColorManager.primaryColorDark,
      ),
      dayOverlayColor: MaterialStatePropertyAll<Color>(
        ColorManager.primaryColorDark.withOpacity(0.8),
      ),
      dayStyle: getRegularStyle(fontSize: 14),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(8),
        hintStyle: getRegularStyle(
          color: isDark ? ColorManager.textSecondary : ColorManager.textPrimary,
        ),
        labelStyle: getMediumStyle(
          color: isDark ? ColorManager.textSecondary : ColorManager.textPrimary,
        ),
        errorStyle: getRegularStyle(color: ColorManager.error),
      ),
      rangePickerBackgroundColor: ColorManager.primaryColorLight,
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
        color:
            isDark ? ColorManager.textPrimaryLight : ColorManager.textPrimary,
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
      backgroundColor: isDark
          ? ColorManager.backgroundDarkColor
          : ColorManager.backgroundColor,
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
    listTileTheme: ListTileThemeData(
      iconColor: isDark ? Colors.white : Colors.black,
    ),
    dividerTheme: DividerThemeData(
      color: ColorManager.divider,
    ),
    fontFamily: 'Nunito',
  );
}
