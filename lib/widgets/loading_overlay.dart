import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

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
      child: const Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.5,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black54,
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}

List<Widget> overlayLoading({
  bool show = false,
  required String text,
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
          children: [
            const CircularProgressIndicator(),
            const Gap(10),
            Text(
              text,
              style: getBoldStyle(
                color: Colors.white,
                fontSize: 20,
                textDecoration: TextDecoration.none,
              ),
            )
          ],
        ),
      )
    ];
  }
  return [];
}
