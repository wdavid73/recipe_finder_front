import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/widgets/layout_custom.dart';

class IconApp extends StatelessWidget {
  final double size;
  final String icon;
  final Color? color;
  final double sizeFactorPortrait;
  final double sizeFactorLandscape;

  const IconApp({
    super.key,
    required this.icon,
    this.size = 50,
    this.color,
    this.sizeFactorPortrait = 0.8,
    this.sizeFactorLandscape = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationLayoutCustom(
      portrait: (context) => SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(color ?? Colors.white, BlendMode.srcIn),
        width: size * sizeFactorPortrait,
      ),
    );
  }
}
