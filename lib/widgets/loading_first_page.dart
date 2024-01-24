import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:shimmer/shimmer.dart';

class LoadingFirstPage extends StatelessWidget {
  const LoadingFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return SizedBox(
      width: responsive.width,
      height: responsive.height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: ListView.builder(
          itemBuilder: (context, index) => Container(
            width: responsive.width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
