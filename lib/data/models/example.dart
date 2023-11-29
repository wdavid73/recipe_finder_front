import 'package:front_scaffold_flutter/domain/entity/example_entity.dart';

class Example implements ExampleEntity {
  final String name;

  const Example({required this.name});

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(name: json['name']);
  }

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
}
