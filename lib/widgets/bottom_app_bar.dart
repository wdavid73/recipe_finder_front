import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

class BottomAppBarCustom extends StatefulWidget {
  final Function(String page) onTap;
  final String selectedPage;
  const BottomAppBarCustom({
    super.key,
    required this.onTap,
    required this.selectedPage,
  });

  @override
  State<BottomAppBarCustom> createState() => _BottomAppBarCustomState();
}

class _BottomAppBarCustomState extends State<BottomAppBarCustom> {
  void onTapItem(String page) {
    widget.onTap(page);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ColorManager.backgroundDarkColor,
      surfaceTintColor: ColorManager.secondaryBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () => onTapItem("home"),
            child: ItemNav(
              title: "Home",
              icon: Icons.home,
              isSelected: widget.selectedPage == 'home',
            ),
          ),
          const Gap(20),
          GestureDetector(
            onTap: () => onTapItem("profile"),
            child: ItemNav(
              title: "Profile",
              icon: Icons.person,
              isSelected: widget.selectedPage == 'profile',
            ),
          ),
          const Gap(20),
          GestureDetector(
            onTap: () => onTapItem("settings"),
            child: ItemNav(
              title: "Settings",
              icon: Icons.settings,
              isSelected: widget.selectedPage == 'setting',
            ),
          ),
        ],
      ),
    );
  }
}

class ItemNav extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  const ItemNav({
    super.key,
    required this.title,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Icon(
                icon,
                color: isSelected
                    ? ColorManager.secondaryAccentColor
                    : Colors.white,
                size: isSelected ? responsive.dp(3) : responsive.dp(2.6),
              ),
            ),
            Text(
              title,
              style: isSelected
                  ? getBoldStyle(
                      color: ColorManager.secondaryAccentColor,
                      fontSize: responsive.dp(1.6),
                    )
                  : getMediumStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.4),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
