import 'package:recipe_finder/domain/entity/ingredient_entity.dart';

class Ingredient extends IngredientEntity {
  int idIngredient;
  String name;
  String category;

  Ingredient({
    required this.idIngredient,
    required this.name,
    required this.category,
  });

  @override
  int get id => idIngredient;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      idIngredient: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
    );
  }

  @override
  String toString() {
    return 'Ingredient: $id - $name - $category';
  }
}

List<Ingredient> parseIngredients(List<dynamic> data) =>
    data.map<Ingredient>((json) => Ingredient.fromJson(json)).toList();
