import 'package:flutter/material.dart';
import 'package:recipe_finder/i10n/app_localizations.dart';

extension AppLocalization on BuildContext {
  String translate(String key) {
    return AppLocalizations.of(this).translate(key);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
