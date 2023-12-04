import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';
import 'package:recipe_finder/widgets/logo_app.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('sign_up'),
          style: getBoldStyle(
            color: Colors.white,
            fontSize: responsive.dp(3),
          ),
        ),
        backgroundColor: Colors.transparent,
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
              LogoApp(size: responsive.dp(20)),
              const Gap(50),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InputCustom(
                          onChange: (value) {},
                          hint: context.translate('name'),
                          label: context.translate('name'),
                          keyboardType: TextInputType.emailAddress,
                          iconPrefix: const Icon(Icons.person),
                        ),
                        InputCustom(
                          onChange: (value) {},
                          hint: context.translate('email_address'),
                          label: context.translate('email'),
                          keyboardType: TextInputType.emailAddress,
                          iconPrefix: const Icon(Icons.email),
                        ),
                        InputCustom(
                          onChange: (value) {},
                          hint: context.translate('password'),
                          label: context.translate('password'),
                          keyboardType: TextInputType.emailAddress,
                          iconPrefix: const Icon(Icons.lock),
                        ),
                        InputCustom(
                          onChange: (value) {},
                          hint: context.translate('confirm_password'),
                          label: context.translate('confirm_password'),
                          keyboardType: TextInputType.emailAddress,
                          iconPrefix: const Icon(Icons.lock_outline),
                        ),
                        InputCustom(
                          onChange: (value) {},
                          hint: context.translate('birthday'),
                          label: context.translate('birthday'),
                          keyboardType: TextInputType.emailAddress,
                          iconPrefix: const Icon(Icons.calendar_month),
                        ),
                        ButtonCustom(
                          onPressed: () {},
                          width: responsive.wp(60),
                          child: Text(
                            context.translate('sign_up'),
                            style: getMediumStyle(
                              color: Colors.white,
                              fontSize: responsive.dp(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
