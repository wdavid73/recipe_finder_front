import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

List<Widget> _loadingBase({
  required BuildContext context,
}) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  return [
    const SizedBox(
      width: 25,
      height: 25,
      child: CircularProgressIndicator.adaptive(),
    ),
    const Gap(10),
    Text(
      context.translate('loading'),
      style: getMediumStyle(
        textDecoration: TextDecoration.none,
        fontSize: 22,
        color: colorScheme.onSurface,
      ),
    ),
  ];
}

class LoadingBase extends StatelessWidget {
  const LoadingBase({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: _loadingBase(context: context),
      ),
    );
  }
}

class LoadingBuilder extends StatelessWidget {
  const LoadingBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingBase();
  }
}

class Loading extends StatelessWidget {
  final Orientation orientation;
  const Loading({super.key, this.orientation = Orientation.portrait});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return SizedBox(
      width: responsive.width,
      child: orientation == Orientation.portrait
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _loadingBase(context: context),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _loadingBase(context: context),
            ),
    );
  }
}

class LoadingOverlay {
  BuildContext _context;

  void hide() => Navigator.of(_context).pop();

  void show() {
    showDialog(
      context: _context,
      builder: (ctx) => const _FullScreenLoader(),
      barrierDismissible: false,
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  const _FullScreenLoader();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return SizedBox(
      width: responsive.width,
      height: responsive.height,
      child: Stack(
        children: <Widget>[
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black54,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _loadingBase(context: context),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> overlayLoading({
  bool show = false,
  required BuildContext context,
}) {
  if (show) {
    return [
      const Opacity(
        opacity: 0.5,
        child: ModalBarrier(
          dismissible: false,
          color: Colors.black,
        ),
      ),
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _loadingBase(context: context),
        ),
      )
    ];
  }
  return [];
}

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
