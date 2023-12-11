import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/placeholder_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('profile'),
          style: getSemiBoldStyle(
            color: Colors.white,
            fontSize: responsive.dp(1.8),
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.backgroundDarkColor,
        shadowColor: Colors.black87,
        surfaceTintColor: ColorManager.backgroundDarkColor,
        toolbarHeight: responsive.hp(8),
      ),
      body: SafeArea(
        child: Container(
          width: responsive.width,
          height: responsive.height,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: responsive.dp(9),
                backgroundColor: ColorManager.backgroundDarkColor,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                  ),
                  child: const Image(
                    image: AssetImage("assets/images/not_found.png"),
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const Gap(20),
              ButtonCustom(
                onPressed: () {},
                text: context.translate('edit_profile'),
                width: responsive.wp(45),
              ),
              const InformationContainer(),
              const FavoritesRecipes(),
              const InformationContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationContainer extends StatelessWidget {
  const InformationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      width: responsive.width,
      height: responsive.hp(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: ColorManager.backgroundDarkColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorManager.secondaryBackgroundColor,
          width: 5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _itemTextInformation(
            responsive,
            title: context.translate('num_recipes'),
            value: '12',
          ),
          _itemTextInformation(
            responsive,
            title: 'Label',
            value: 'Value',
          ),
          _itemTextInformation(
            responsive,
            title: 'Label',
            value: 'Value',
          ),
        ],
      ),
    );
  }

  Widget _itemTextInformation(Responsive responsive,
      {required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: getSemiBoldStyle(
            color: Colors.white,
            fontSize: responsive.dp(1.8),
          ),
        ),
        Text(
          value,
          style: getMediumStyle(
            color: Colors.white,
            fontSize: responsive.dp(1.6),
          ),
        ),
      ],
    );
  }
}

class FavoritesRecipes extends StatelessWidget {
  const FavoritesRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.translate('favorite_recipes'),
                style: getMediumStyle(
                  color: Colors.white,
                  fontSize: responsive.dp(2),
                ),
              ),
              Text(
                context.translate('show_all'),
                style: getMediumStyle(
                  color: Colors.white,
                  fontSize: responsive.dp(2),
                  textDecoration: TextDecoration.underline,
                ),
              )
            ],
          ),
          SizedBox(
            width: responsive.width,
            height: responsive.hp(20),
            child: ListView.builder(
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: responsive.wp(45),
                  decoration: BoxDecoration(
                    color: ColorManager.secondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: const PlaceholderWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
