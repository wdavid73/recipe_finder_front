import 'package:flutter/material.dart';
import 'package:recipe_finder/utils/extensions.dart';

DateTime parseStringToDateTime(String date) {
  List<String> dateParts = date.split('-');

  int year = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[2]);

  DateTime dateParsed = DateTime(year, month, day);

  return dateParsed;
}

String formatValidationMessage(
    String key, List<String> dynamicValues, BuildContext context) {
  String message = context.translate(key);
  dynamicValues.asMap().forEach((index, value) {
    message = message.replaceAll('%$index', value);
  });
  return message;
}
