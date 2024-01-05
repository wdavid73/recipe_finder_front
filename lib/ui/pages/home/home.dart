import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/home/categories_container.dart';
import 'package:recipe_finder/ui/pages/home/widgets/drawer_home.dart';
import 'package:recipe_finder/ui/pages/home/your_recipe_container.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _init();
    super.initState();
  }

  void _init() async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String tokenBloc = authBloc.state.token;
    bool validTokenBloc = tokenBloc != '';
    if (!validTokenBloc) {
      authBloc.add(GetUser("$token"));
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    NavigationManager.goAndRemove(context, "login");
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('title_home'),
          style: getSemiBoldStyle(
            fontSize: responsive.dp(1.8),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: responsive.dp(2.5)),
          )
        ],
        centerTitle: true,
        toolbarHeight: responsive.hp(8),
      ),
      drawer: const DrawerHome(),
      body: SafeArea(
        child: Container(
          width: responsive.width,
          height: responsive.height,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Gap(20),
              Animate(
                effects: const [
                  FadeEffect(),
                  SlideEffect(
                    begin: Offset(-1.0, 0.0),
                    end: Offset.zero,
                    curve: Curves.decelerate,
                  ),
                ],
                onComplete: (controller) {
                  // call service get list
                },
                delay: const Duration(milliseconds: 500),
                child: const YourRecipesContainer(),
              ),
              const Gap(20),
              Animate(
                effects: const [
                  FadeEffect(),
                  SlideEffect(
                    begin: Offset(-1.0, 0.0),
                    end: Offset.zero,
                    curve: Curves.decelerate,
                  ),
                ],
                child: const CategoriesContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
