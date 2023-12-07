import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/home/categories_container.dart';
import 'package:recipe_finder/ui/pages/home/widgets/drawer_home.dart';
import 'package:recipe_finder/ui/pages/home/your_recipe_container.dart';
import 'package:recipe_finder/utils/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('title_home'),
          style: getSemiBoldStyle(
            color: Colors.white,
            fontSize: responsive.dp(1.8),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: responsive.dp(2.5)),
          )
        ],
        backgroundColor: ColorManager.backgroundDarkColor,
        shadowColor: Colors.black87,
        surfaceTintColor: ColorManager.backgroundDarkColor,
        toolbarHeight: responsive.hp(8),
      ),
      drawer: const DrawerHome(),
      body: SafeArea(
        child: Container(
          width: responsive.width,
          height: responsive.height,
          alignment: Alignment.center,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Gap(20),
              YourRecipesContainer(),
              Gap(25),
              CategoriesContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
