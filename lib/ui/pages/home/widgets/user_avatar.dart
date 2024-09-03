import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/user.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/constants.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/functions.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.responsive,
    this.user,
    this.radius,
    this.withBorder = false,
  });

  final Responsive responsive;
  final double? radius;
  final bool withBorder;
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
        if (state.userLoading == true) {
          return _builderCircleAvatar(
            child: const CircularProgressIndicator.adaptive(),
          );
        }

        if (state.user != null && state.user!.profilePicture != null) {
          return _builderCircleAvatar(
            child: CachedNetworkImage(
              imageUrl: transformProfilePictureUrl(state.user!.profilePicture!),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                return Icon(
                  Icons.error,
                  color: ColorManager.error,
                  size: responsive.dp(5),
                );
              },
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }

        return _builderCircleAvatar(
          child: Text(
            context.translate('not_user'),
            textAlign: TextAlign.center,
            style: getBoldStyle(
              color: Colors.white,
              fontSize: responsive.dp(1.5),
            ),
          ),
        );
      },
    );
  }

  CircleAvatar _builderCircleAvatar({required Widget child}) {
    return CircleAvatar(
      backgroundColor: ColorManager.backgroundDarkColor,
      radius: radius,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: withBorder
              ? Border.all(color: ColorManager.backgroundColor, width: 1)
              : null,
          boxShadow: kBoxShadowCircle,
        ),
        child: child,
      ),
    );
  }
}
