import "dart:math" as math;
import 'package:flutter/material.dart';

class Responsive {
  late double _width, _height, _diagonal;
  late bool _isTablet;
  late bool _isPortrait;
  late bool _isLandscape;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTable => _isTablet;
  bool get isPortrait => _isPortrait;
  bool get isLandscape => _isLandscape;

  Responsive(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size size = mediaQuery.size;

    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(
      math.pow(_width, 2) + math.pow(_height, 2),
    );
    _isTablet = size.shortestSide >= 600 ? true : false;
    _isLandscape = mediaQuery.orientation == Orientation.landscape;
    _isPortrait = mediaQuery.orientation == Orientation.portrait;
  }

  static Responsive of(BuildContext context) => Responsive(context);

  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;
}
