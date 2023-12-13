import 'package:flutter/material.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('my_recipes'),
          style: getSemiBoldStyle(
            fontSize: responsive.dp(1.8),
          ),
        ),
        centerTitle: true,
        toolbarHeight: responsive.hp(8),
      ),
      body: SafeArea(
        child: Container(
          width: responsive.width,
          height: responsive.height,
          padding: const EdgeInsets.all(10),
          child: Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 300,
                      margin: const EdgeInsets.only(bottom: 20),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: ColorManager.secondaryBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: ColorManager.accentColorLight,
                            width: responsive.width,
                            child: _recipeInformation(responsive, context),
                          ),
                          Expanded(
                            child: Container(
                              width: responsive.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/recipe_image_example.jpg',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _recipeInformation(Responsive responsive, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(1.6),
                        ),
                        children: [
                          const TextSpan(text: 'Chocolate Chip Cookies'),
                          const TextSpan(text: ' - '),
                          TextSpan(
                            text: context.translate(
                              'Soups and Stews'.toLowerCase(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /* Text(
                      "- By You",
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(1.6),
                      ),
                    ), */
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "4.7",
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(1.6),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: responsive.dp(2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
