import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

class ListIngredientsSelected extends StatelessWidget {
  final List<String> items;
  final void Function(int index)? onDeleted;
  const ListIngredientsSelected({
    super.key,
    required this.items,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      width: responsive.width,
      constraints: BoxConstraints(
        minHeight: responsive.hp(3),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: List.generate(
            items.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Chip(
                  onDeleted: () => onDeleted!(index),
                  label: Text(
                    items[index],
                    style: getRegularStyle(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
