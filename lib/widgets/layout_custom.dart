import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';

class LayoutBuildCustom extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;

  const LayoutBuildCustom({
    super.key,
    required this.mobile,
    this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    if (tablet != null && responsive.isTable) {
      return tablet!(context);
    }
    return mobile(context);
  }
}

class OrientationLayoutCustom extends StatelessWidget {
  final WidgetBuilder portrait;
  final WidgetBuilder? landscape;

  const OrientationLayoutCustom({
    super.key,
    required this.portrait,
    this.landscape,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    if (landscape != null && responsive.isLandscape) {
      return landscape!(context);
    }
    return portrait(context);
  }
}
