import 'package:flutter/material.dart';

class SnackBarManager {
  static void showSnackBar(
    BuildContext context, {
    String? message,
    SnackBarAction? action,
    Widget? customContent,
  }) {
    assert((customContent == null && message != null) ||
        (customContent != null && message == null));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: customContent ?? Text("$message"),
        action: action,
      ),
    );
  }
}
