import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SnackBarManager {
  static void showSnackBar(
    BuildContext context, {
    String? message,
    SnackBarAction? action,
    Widget? customContent,
    IconData? icon,
  }) {
    assert((customContent == null && message != null) ||
        (customContent != null && message == null));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: customContent ??
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                icon != null
                    ? Icon(
                        icon,
                        size: 30,
                      )
                    : const SizedBox.shrink(),
                Gap(icon != null ? 10 : 0),
                Flexible(
                  child: Text("$message"),
                ),
              ],
            ),
        action: action,
      ),
    );
  }
}
