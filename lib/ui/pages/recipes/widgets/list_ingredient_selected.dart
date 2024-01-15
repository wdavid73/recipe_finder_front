import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';

class ListIngredientsSelected extends StatelessWidget {
  final List<dynamic> items;
  final void Function(int index)? onDeleted;
  final Widget Function(dynamic value) itemBuilder;

  const ListIngredientsSelected({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      width: responsive.width,
      constraints: BoxConstraints(
        minHeight: responsive.hp(0),
        maxHeight: responsive.hp(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: List.generate(items.length, itemBuilder),
        ),
      ),
    );
  }
}
