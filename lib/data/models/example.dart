import 'package:recipe_finder/domain/entity/example_entity.dart';

class Example implements ExampleEntity {
  final String name;
  final int idExample;

  const Example({required this.name, required this.idExample});

  @override
  String toString() {
    return "Example: $name";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  int get id => idExample;

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      name: json['name'],
      idExample: json['id'] ?? 0,
    );
  }
}
