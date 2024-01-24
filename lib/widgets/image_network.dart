import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class ImageNetwork extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;

  const ImageNetwork({
    super.key,
    required this.imageUrl,
    this.imageBuilder,
  });

  String manageErrorWidget(Object error, BuildContext context) {
    if (error is HttpException) {
      HttpException httpError = error;
      return (httpError.message.contains('404'))
          ? context.translate('image_not_found')
          : context.translate('error_get_image');
    }
    return context.translate('error_get_image');
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const CircularProgressIndicator.adaptive(),
      errorWidget: (context, url, error) => _errorWidget(
        error: manageErrorWidget(error, context),
      ),
      imageBuilder: imageBuilder,
    );
  }

  Widget _errorWidget({required String error}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Image(
            image: AssetImage("assets/images/not_found.png"),
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
          ),
        ),
        const Gap(10),
        Text(
          error,
          style: getRegularStyle(
            color: ColorManager.error,
            fontSize: 16,
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
