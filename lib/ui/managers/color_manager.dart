import 'package:flutter/material.dart';

class ColorManager {
  static Color textPrimary = HexColor.fromHex("#212121");
  static Color textPrimaryLight = HexColor.fromHex("#FFFFFF");
  static Color textSecondary = HexColor.fromHex("#757575");
  static Color backgroundColor = HexColor.fromHex("#FFFFFF");
  static Color backgroundDarkColor = HexColor.fromHex("#272727");
  static Color secondaryBackgroundColor = HexColor.fromHex("#999999");
  /* ------------ PRIMARY ---------------- */
  static Color primaryColor = HexColor.fromHex("#e91e63");
  static Color primaryColorLight = HexColor.fromHex("#f8bbd0");
  static Color primaryColorDark = HexColor.fromHex("#c2185b");
  /* ------------ SECONDARY ---------------- */
  static Color secondaryColor = HexColor.fromHex("#e040fb");
  static Color secondaryAccentColor = HexColor.fromHex("#ff5722");
  /* ------------ UTILS COLORS  -------------- */
  static Color disabledColor = HexColor.fromHex("#bcbcbc");
  static Color splashColor = HexColor.fromHex("#c2185b");
  /* ------------ VARIATION COLORS  -------------- */
  static Color shadowColorDark = HexColor.fromHex('#171717');
  static Color containerColorDark = HexColor.fromHex('#414141');

  static Color error = HexColor.fromHex("#EF5350");
  static Color divider = HexColor.fromHex("#BDBDBD");
}

extension HexColor on Color {
  static Color fromHex(String hexColor) {
    hexColor = hexColor.trim().replaceAll("#", '');

    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    return Color(int.parse(hexColor, radix: 16));
  }
}
