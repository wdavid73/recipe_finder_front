import 'package:flutter/material.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'John Doe',
              style: getMediumStyle(
                color: Colors.white,
                fontSize: responsive.dp(1.6),
              ),
            ),
            accountEmail: Text(
              'johndoe@gmail.com',
              style: getRegularStyle(
                color: Colors.white,
                fontSize: responsive.dp(1.4),
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: ColorManager.backgroundDarkColor,
              child: Text(
                "JD",
                style: getBoldStyle(
                  color: Colors.white,
                  fontSize: responsive.dp(4),
                ),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorManager.primaryColor,
                  ColorManager.secondaryAccentColor,
                ],
              ),
            ),
            margin: const EdgeInsets.only(bottom: 10),
          ),
          DrawerItem(
            icon: Icons.person,
            title: context.translate('profile'),
            onTap: () {
              Navigator.pop(context);
              NavigationManager.go(
                context,
                'profile',
                transition: 'slide',
              );
            },
          ),
          DrawerItem(
            icon: Icons.format_list_bulleted,
            title: context.translate('my_recipes'),
            onTap: () {
              Navigator.pop(context);
              NavigationManager.go(
                context,
                'my_recipes',
                transition: 'slide',
              );
            },
          ),
          DrawerItem(
            icon: Icons.settings,
            title: context.translate('settings'),
            onTap: () {
              Navigator.pop(context);
              NavigationManager.go(
                context,
                'settings',
                transition: 'slide',
              );
            },
          ),
          const Divider(),
          DrawerItem(
            icon: Icons.exit_to_app,
            title: context.translate('logout'),
            onTap: () {
              Navigator.pop(context);
              NavigationManager.goAndRemove(
                context,
                'login',
                transition: 'slide',
              );
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: getRegularStyle()),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
