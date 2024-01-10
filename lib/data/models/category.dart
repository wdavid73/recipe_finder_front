import 'package:recipe_finder/domain/entity/category_entity.dart';

class Category extends CategoryEntity {
  int idCategory;
  String name;

  Category({required this.idCategory, required this.name});

  @override
  int get id => idCategory;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': idCategory,
      'name': name,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      idCategory: json['id'] as int,
      name: json['name'] as String,
    );
  }

  @override
  String toString() {
    return 'Category: $id - $name';
  }
}

List<Category> parseCategories(List<dynamic> data) =>
    data.map<Category>((json) => Category.fromJson(json)).toList();
