import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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

FormData parseMapToFormData(Map<String, dynamic> map) {
  FormData formData = FormData();

  map.forEach((key, value) {
    if (value is String) {
      formData.fields.add(MapEntry(key, value));
    } else if (value is int) {
      formData.fields.add(MapEntry(key, value.toString()));
    } else if (value is List<int>) {
      formData.fields
          .add(MapEntry(key, value.map((e) => e.toString()).join(',')));
    } else if (value is List<Map<String, dynamic>>) {
      formData.fields.add(MapEntry(key, jsonEncode(value)));
    } else if (value is File && key == 'main_picture') {
      String extension = value.path.split('.').last;
      formData.files.add(MapEntry(
        key,
        MultipartFile.fromFileSync(value.path, filename: 'image.$extension'),
      ));
    }
  });

  return formData;
}

void insertItemsInList<T>({
  required PagingController<int, T> pagingController,
  required List<T> items,
  required int skip,
  required int limit,
  required int total,
}) {
  final fetchedItemsCount = pagingController.itemList?.length ?? 0;
  final bool isLastPage = fetchedItemsCount >= total || items.isEmpty;

  if (isLastPage) {
    pagingController.appendLastPage(items);
  } else {
    final nextPageKey = (skip + limit).toInt();
    pagingController.appendPage(items, nextPageKey);
  }
}
