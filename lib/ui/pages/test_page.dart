import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/example.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final String text = '';
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {}

  @override
  Widget build(BuildContext context) {
    final Example exampleTest = Example.fromJson({
      'name': 'Prueba',
      'id': 1,
    });
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(child: SizedBox.shrink()),
    );
  }
}
