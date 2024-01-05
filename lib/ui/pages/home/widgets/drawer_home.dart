import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/user.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: state.loadingUser
                    ? Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.grey,
                        child: Text(context.translate('loading')),
                      )
                    : Text(
                        state.user != null
                            ? state.user!.name.capitalizeName()
                            : '',
                        style: getMediumStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(1.6),
                        ),
                      ),
                accountEmail: state.loadingUser
                    ? Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.grey,
                        child: Text(context.translate('loading')),
                      )
                    : Text(
                        state.user != null ? state.user!.email : '',
                        style: getRegularStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(1.4),
                        ),
                      ),
                currentAccountPicture:
                    UserAvatar(responsive: responsive, user: state.user),
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
      },
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.responsive,
    this.user,
  });

  final Responsive responsive;
  final User? user;

  String useName(String name) {
    return name
        .split(' ')
        .map((word) => word.isEmpty ? word : word[0].toUpperCase())
        .join('');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.user != null) {
          bool hasImage = state.user!.profilePicture != null;
          return CircleAvatar(
            backgroundColor: ColorManager.backgroundDarkColor,
            child: state.loadingUser
                ? const CircularProgressIndicator()
                : hasImage
                    ? CachedNetworkImage(
                        imageUrl: state.user!.profilePicture!,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        useName(state.user!.name),
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(4),
                        ),
                      ),
          );
        }
        return const SizedBox.shrink();
      },
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
