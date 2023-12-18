import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/constants.dart';
import 'package:recipe_finder/utils/extensions.dart';

class ImagePickerInput extends StatelessWidget {
  final File? image;
  final ValueChanged<File?> onFileChanged;

  const ImagePickerInput({
    super.key,
    this.image,
    required this.onFileChanged,
  });

  Future<dynamic> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onFileChanged(File(image.path));
    } else {
      onFileChanged(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    if (image == null) {
      return _containerImagePicker(
        responsive,
        context: context,
        child: Icon(
          Icons.camera_alt_outlined,
          size: responsive.dp(6),
          color: Colors.white,
        ),
      );
    }

    return ImagePickerSelected(
      image: image,
      getImage: () => getImage(),
    );
  }

  Widget _containerImagePicker(
    Responsive responsive, {
    required Widget child,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => getImage(),
            borderRadius: BorderRadius.circular(20),
            splashColor: ColorManager.accentColor,
            child: Ink(
              width: responsive.wp(90),
              height: responsive.hp(25),
              decoration: BoxDecoration(
                color: ColorManager.containerColorDark,
                borderRadius: BorderRadius.circular(20),
                boxShadow: boxShadow,
              ),
              child: child,
            ),
          ),
          Text(
            context.translate('tip_photo_recipe'),
            style: getLightStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePickerSelected extends StatelessWidget {
  final File? image;
  final void Function()? getImage;
  const ImagePickerSelected({
    super.key,
    this.image,
    this.getImage,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: responsive.wp(90),
            height: responsive.hp(28),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  width: responsive.wp(90),
                  height: responsive.hp(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: Image.file(image!).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: () => getImage!(),
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.transparent,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ColorManager.accentColor,
                        shape: BoxShape.circle,
                        boxShadow: boxShadow,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: responsive.dp(3.5),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Text(
                    context.translate('tip_photo_recipe'),
                    style: getLightStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
