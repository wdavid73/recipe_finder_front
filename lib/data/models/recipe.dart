import 'package:recipe_finder/data/models/category.dart';
import 'package:recipe_finder/domain/entity/recipe_entity.dart';

class Recipe extends RecipeEntity {
  int idRecipe;
  String name;
  String description;
  int cookingTime;
  bool isFavorite;
  String mainPicture;
  Category category;
  String rating;

  Recipe({
    required this.idRecipe,
    required this.name,
    required this.description,
    required this.cookingTime,
    this.isFavorite = false,
    required this.mainPicture,
    required this.category,
    this.rating = '0.0',
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      idRecipe: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      cookingTime: json['cooking_time'] as int,
      mainPicture: json["main_picture"] as String,
      rating: json['ratings'] as String,
      category: Category.fromJson(json['category']),
    );
  }

  @override
  int get id => idRecipe;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cooking_time': cookingTime,
      'main_picture': mainPicture,
      'category': category.toJson(),
    };
  }
}

List<Recipe> parseRecipes(List<dynamic> data) =>
    data.map<Recipe>((json) => Recipe.fromJson(json)).toList();
