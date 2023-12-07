import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/widgets/icon_app.dart';

List<BoxShadow> boxShadow = const [
  BoxShadow(
    color: Colors.black26,
    blurRadius: 5,
    offset: Offset(0, 5),
  ),
];

List<Map<String, dynamic>> categories = [
  {
    "name": 'Starters',
    "icon": Icon(
      Icons.fastfood,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Main Courses',
    "icon": Icon(
      Icons.dinner_dining,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Desserts',
    "icon": Icon(
      Icons.cake,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Appetizers',
    "icon": Icon(
      Icons.local_dining,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Salads',
    "icon": IconApp(
      icon: "assets/icons/categories/salads.svg",
      color: ColorManager.textPrimaryLight,
      size: 34,
    ),
  },
  {
    "name": 'Soups and Stews',
    "icon": IconApp(
      icon: "assets/icons/categories/soups_and_stews.svg",
      color: ColorManager.textPrimaryLight,
      size: 34,
    ),
  },
  {
    "name": 'Breakfasts',
    "icon": Icon(
      Icons.free_breakfast,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Beverages',
    "icon": Icon(
      Icons.sports_bar,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Vegan Food',
    "icon": IconApp(
      icon: "assets/icons/categories/vegan_food.svg",
      color: ColorManager.textPrimaryLight,
      size: 34,
    ),
  },
  {
    "name": 'Seafood',
    "icon": IconApp(
      icon: "assets/icons/categories/seafood.svg",
      color: ColorManager.textPrimaryLight,
      size: 34,
    ),
  },
  {
    "name": 'Barbecues and Grills',
    "icon": Icon(
      Icons.whatshot,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Asian Food',
    "icon": Icon(
      Icons.ramen_dining,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Italian Food',
    "icon": Icon(
      Icons.local_pizza,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Mexican Food',
    "icon": Icon(
      Icons.local_dining,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
  {
    "name": 'Vegetarian Food',
    "icon": IconApp(
      icon: "assets/icons/categories/vegan_food.svg",
      color: ColorManager.textPrimaryLight,
      size: 34,
    ),
  },
  {
    "name": 'Other',
    "icon": Icon(
      Icons.extension,
      color: ColorManager.textPrimaryLight,
      size: 34,
    )
  },
];
