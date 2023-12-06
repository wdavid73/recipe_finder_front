import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/home/categories_container.dart';
import 'package:recipe_finder/ui/pages/home/your_recipe_container.dart';
import 'package:recipe_finder/widgets/bottom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  String _selectedPage = "home";

  void _onItemTapped(String page) {
    setState(() => _selectedPage = page);
    NavigationManager.go(context, page);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to RecipeFinder',
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
        leading: Icon(
          Icons.menu,
          size: responsive.dp(2.5),
        ),
        backgroundColor: ColorManager.backgroundDarkColor,
        shadowColor: Colors.black87,
        surfaceTintColor: ColorManager.backgroundDarkColor,
        toolbarHeight: responsive.hp(8),
      ),
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
      bottomNavigationBar: BottomAppBarCustom(
        onTap: (String page) {
          _onItemTapped(page);
        },
        selectedPage: _selectedPage,
      ),
    );
  }
}
