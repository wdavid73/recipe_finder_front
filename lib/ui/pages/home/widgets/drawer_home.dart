import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/user.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/home/widgets/drawer_item.dart';
import 'package:recipe_finder/ui/pages/home/widgets/user_avatar.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  void _logout() async {
    // Close Drawer
    Navigator.pop(context);

    // Logout Event Store
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(LogoutEvent());

    // Go to Login page
    _navigateToLogin();

    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _navigateToLogin() {
    NavigationManager.goAndRemove(
      context,
      'login',
      transition: 'slide',
    );
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.userLoading == true) {
                return UserHeaderCustom(
                  responsive: responsive,
                  accountName: const ShimmerTextContainer(width: 50),
                  accountEmail: const ShimmerTextContainer(width: 30),
                );
              }

              if (state.userStatus == UserStatus.hasError) {
                return UserHeaderCustom(
                  responsive: responsive,
                  accountName: const Text(""),
                  accountEmail: const Text(""),
                  user: null,
                );
              }

              return UserHeaderCustom(
                accountName: Text(
                  state.user != null ? state.user!.name.capitalizeName() : '',
                  style: getMediumStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(1.6),
                  ),
                ),
                accountEmail: Text(
                  state.user != null ? state.user!.email : '',
                  style: getRegularStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(1.4),
                  ),
                ),
                user: state.user,
                responsive: responsive,
              );
            },
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
                'recipes',
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
            onTap: () => _logout(),
          ),
        ],
      ),
    );
  }
}

class ShimmerTextContainer extends StatelessWidget {
  const ShimmerTextContainer({
    super.key,
    this.width = 60,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        width: responsive.wp(width),
        height: 10,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class UserHeaderCustom extends StatelessWidget {
  const UserHeaderCustom({
    super.key,
    required this.responsive,
    required this.accountName,
    required this.accountEmail,
    this.user,
  });

  final Responsive responsive;
  final Widget accountName;
  final Widget accountEmail;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: accountName,
      accountEmail: accountEmail,
      currentAccountPicture: UserAvatar(responsive: responsive, user: user),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorManager.primaryColor,
            ColorManager.accentColor,
          ],
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
    );
  }
}
