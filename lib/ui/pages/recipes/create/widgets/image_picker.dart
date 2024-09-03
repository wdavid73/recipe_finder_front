import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/bloc/create_recipe/create_recipe_bloc.dart';
import 'package:recipe_finder/widgets/image_picker.dart';

class ImagePickerCreateRecipe extends StatelessWidget {
  final void Function(File? file) onFileChanged;
  const ImagePickerCreateRecipe({super.key, required this.onFileChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
      builder: (context, state) {
        return ImagePickerInput(
          image: state.file,
          onFileChanged: (file) => onFileChanged(file),
        );
      },
    );
  }
}
