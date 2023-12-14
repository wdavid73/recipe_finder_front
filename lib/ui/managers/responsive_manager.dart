import "dart:math" as math;
import 'package:flutter/material.dart';

class Responsive {
  late double _width, _height, _diagonal, _keyboardHeight;
  late bool _isTablet;
  late bool _isPortrait;
  late bool _isLandscape;
  late bool _isKeyboardOpen;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  double get keyboardHeight => _keyboardHeight;
  bool get isTable => _isTablet;
  bool get isPortrait => _isPortrait;
  bool get isLandscape => _isLandscape;
  bool get isKeyboardOpen => _isKeyboardOpen;

  Responsive(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size size = mediaQuery.size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(
      math.pow(_width, 2) + math.pow(_height, 2),
    );
    _isKeyboardOpen = mediaQuery.viewInsets.bottom > 0;
    _keyboardHeight = mediaQuery.viewInsets.bottom;

    _isTablet = size.shortestSide >= 600 ? true : false;
    _isLandscape = mediaQuery.orientation == Orientation.landscape;
    _isPortrait = mediaQuery.orientation == Orientation.portrait;
  }

  static Responsive of(BuildContext context) => Responsive(context);

  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;
}
