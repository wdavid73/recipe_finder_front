import 'package:flutter/material.dart';

class ColorManager {
  static Color textPrimary = HexColor.fromHex("#212121");
  static Color textPrimaryLight = HexColor.fromHex("#FFFFFF");
  static Color textSecondary = HexColor.fromHex("#757575");
  static Color backgroundColor = HexColor.fromHex("#FFFFFF");
  static Color backgroundDarkColor = HexColor.fromHex("#272727");
  /* ------------ PRIMARY ---------------- */
  static Color primaryColor = HexColor.fromHex("#9b27b0");
  static Color primaryColorLight = HexColor.fromHex("#E241FF");
  static Color primaryColorDark = HexColor.fromHex("#641a71");
  /* ------------ SECONDARY ---------------- */
  static Color secondaryColor = HexColor.fromHex("#2195f3");
  static Color secondaryAccentColor = HexColor.fromHex("#038dfd");
  static Color secondaryBackgroundColor = HexColor.fromHex("#999999");
  static Color splashColor = HexColor.fromHex("#9a08b4");
  /* ------------ UTILS COLORS  -------------- */
  static Color disabledColor = HexColor.fromHex("#bcbcbc");

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
