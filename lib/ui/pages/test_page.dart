import 'package:flutter/material.dart';
import 'package:recipe_finder/data/models/example.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/example_bloc/example_bloc.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';

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

  void _init() {
    final exampleBloc = BlocProvider.of<ExampleBloc>(context);
    exampleBloc.add(GetExample());
  }

  @override
  Widget build(BuildContext context) {
    final Example exampleTest = Example.fromJson({
      'name': 'Prueba',
      'id': 1,
    });
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<ExampleBloc, ExampleState>(
          builder: (context, state) {
            if (state is ExampleLoading) {
              return const CircularProgressIndicator();
            }

            if (state is ExampleError) {
              return Center(
                child: Text(
                  "${state.errorMessage}",
                  style: getBoldStyle(
                    fontSize: 30,
                  ),
                ),
              );
            }

            if (state is ExampleLoaded) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      "${state.data}",
                      style: getBoldStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Text("${exampleTest.name}"),
                  Text("${exampleTest.id}"),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
