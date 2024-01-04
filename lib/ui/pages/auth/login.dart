import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/config.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/validations.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/icon_app.dart';
import 'package:recipe_finder/widgets/input_custom.dart';
import 'package:recipe_finder/widgets/logo_app.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('login'),
          style: getBoldStyle(
            fontSize: responsive.dp(3),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: responsive.width,
          height: responsive.height,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LogoApp(size: responsive.dp(25)),
              const Gap(30),
              const Expanded(child: LoginContainer()),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool showPassword = true;
  bool obscureText = true;
  Map<String, dynamic> data = {};

  void _login() {
    /* var isOk = _formKey.currentState!.validate();

    if (isOk) { */
    NavigationManager.goAndRemove(context, "home");
    /* } */
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(5),
            InputCustom(
              onChange: (value) {
                setState(() => data["email"] = value);
              },
              hint: context.translate('email_address'),
              label: context.translate('email'),
              keyboardType: TextInputType.emailAddress,
              iconPrefix: const Icon(Icons.email),
              validator: (value) =>
                  pipeFirstNotNullOrNull<String, String>(value!, [
                (value) => Validations.isRequired(value,
                    message: context.translate('is_required')),
                (value) => Validations.isNotEmpty(value,
                    message: context.translate('is_empty')),
                (value) => Validations.isEmail(value,
                    message: context.translate('is_email'))
              ]),
            ),
            InputCustom(
              onChange: (value) {
                setState(() => data["password"] = value);
              },
              hint: context.translate('password'),
              label: context.translate('password'),
              isPassword: showPassword,
              obscureText: obscureText,
              showPassword: () {
                setState(() => obscureText = !obscureText);
              },
              bottomPadding: 0,
              iconPrefix: const Icon(Icons.lock),
              validator: (value) =>
                  pipeFirstNotNullOrNull<String, String>(value!, [
                (value) => Validations.isRequired(value,
                    message: context.translate('is_required')),
                (value) => Validations.isNotEmpty(value,
                    message: context.translate('is_empty')),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  context.translate('forget_password'),
                  style: getRegularStyle(
                    textDecoration: TextDecoration.underline,
                    fontSize: responsive.dp(1.5),
                  ),
                ),
              ),
            ),
            const Gap(20),
            ButtonCustom(
              onPressed: () => _login(),
              width: responsive.wp(60),
              child: Text(
                context.translate('login'),
                style: getMediumStyle(
                  fontSize: responsive.dp(2),
                ),
              ),
            ),
            const OtherLoginOptions(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${context.translate('not_user_yet')} ",
                  style: getRegularStyle(
                    fontSize: responsive.dp(2),
                  ),
                ),
                GestureDetector(
                  onTap: () => NavigationManager.go(
                    context,
                    "sign_up",
                    transition: "slide",
                  ),
                  child: Text(
                    context.translate('sign_up'),
                    style: getSemiBoldStyle(
                      color: ColorManager.primaryColor,
                      fontSize: responsive.dp(2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OtherLoginOptions extends StatelessWidget {
  const OtherLoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: responsive.hp(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(child: Divider()),
                const Gap(20),
                Text(
                  "Or",
                  style: getMediumStyle(
                    fontSize: responsive.dp(1.6),
                  ),
                ),
                const Gap(20),
                const Expanded(child: Divider()),
              ],
            ),
          ),
          const Gap(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconApp(
                icon: "assets/icons/facebook.svg",
                size: responsive.dp(6),
              ),
              const Gap(20),
              IconApp(
                icon: "assets/icons/google_icon.svg",
                size: responsive.dp(6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
