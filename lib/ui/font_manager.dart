import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter/ui/responsive_manager.dart';

class FontConstants {
  static const String fontFamily = 'Roboto';
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSizeResponsive {
  final Responsive _responsive;

  FontSizeResponsive(this._responsive);

  double get tiny => _responsive.dp(1.2);
  double get small => _responsive.dp(1.4);
  double get medium => _responsive.dp(1.6);
  double get large => _responsive.dp(1.8);
  double get extraLarge => _responsive.dp(2);
  double get extraExtraLarge => _responsive.dp(2.2);
}
