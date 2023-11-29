import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter/ui/font_manager.dart';

TextStyle _getTextStyle({
  FontWeight? fontWeight,
  Color? color,
  double? fontSize,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
  String fontFamily = FontConstants.fontFamily,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    decoration: textDecoration,
    fontStyle: fontStyle,
    fontFamily: fontFamily,
  );
}

TextStyle getLightStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
  String fontFamily = FontConstants.fontFamily,
}) {
  return _getTextStyle(
    color: color,
    fontFamily: fontFamily,
    fontWeight: FontWeightManager.light,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
    fontSize: fontSize,
  );
}

TextStyle getRegularStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
  String fontFamily = FontConstants.fontFamily,
}) {
  return _getTextStyle(
    color: color,
    fontFamily: fontFamily,
    fontWeight: FontWeightManager.regular,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
    fontSize: fontSize,
  );
}

TextStyle getMediumStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
  String fontFamily = FontConstants.fontFamily,
}) {
  return _getTextStyle(
    color: color,
    fontFamily: fontFamily,
    fontWeight: FontWeightManager.medium,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
    fontSize: fontSize,
  );
}

TextStyle getSemiBoldStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
  String fontFamily = FontConstants.fontFamily,
}) {
  return _getTextStyle(
    color: color,
    fontFamily: fontFamily,
    fontWeight: FontWeightManager.semiBold,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
    fontSize: fontSize,
  );
}

TextStyle getBoldStyle({
  double fontSize = 12,
  Color? color,
  TextDecoration? textDecoration,
  FontStyle? fontStyle,
  String fontFamily = FontConstants.fontFamily,
}) {
  return _getTextStyle(
    color: color,
    fontFamily: fontFamily,
    fontWeight: FontWeightManager.bold,
    textDecoration: textDecoration,
    fontStyle: fontStyle,
    fontSize: fontSize,
  );
}
