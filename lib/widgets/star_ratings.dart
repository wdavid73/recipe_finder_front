import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/pages/settings/cubit/settings_cubit.dart';

class StarRating extends StatelessWidget {
  final double rating;
  const StarRating({super.key, this.rating = 0.0});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            double threshold = index + 0.5;
            return Icon(
              threshold < rating
                  ? Icons.star
                  : threshold == rating
                      ? Icons.star_half
                      : Icons.star_border,
              color: state == SettingsState.isDarkTheme
                  ? ColorManager.accentColor
                  : ColorManager.primaryColor,
            );
          }),
        );
      },
    );
  }
}
