import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/snack_bar_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/validations.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';
import 'package:recipe_finder/widgets/logo_app.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _formRecoveryKey = GlobalKey();

  String email = "";
  Map<String, dynamic> data = {};
  bool formSuccess = false;
  bool showFormRecoveryPassword = false;
  bool showPassword = true;
  bool obscureText = true;
  bool showPasswordConfirm = true;
  bool obscureTextConfirm = true;

  void _confirmEmail() {
    var isOk = _formKey.currentState!.validate();
    if (isOk) {
      setState(() => formSuccess = true);
      final authBloc = BlocProvider.of<AuthBloc>(context);
      authBloc.add(ConfirmEmailEvent(email));
    } else {
      setState(() => formSuccess = false);
    }
  }

  void _recoveryPassword() {
    var isOk = _formRecoveryKey.currentState!.validate();
    if (isOk) {
      data["email"] = email;
      final authBloc = BlocProvider.of<AuthBloc>(context);
      authBloc.add(RecoveryPasswordEvent(data));
    }
  }

  void _showSnackBar(String message, IconData icon) {
    SnackBarManager.showSnackBar(
      context,
      message: message,
      icon: icon,
      colorIcon: ColorManager.success,
    );
  }

  void _checkUpdate(AuthState state) {
    if (state.recoveryStatus == RecoveryStatus.isSuccess) {
      _showSnackBar(context.translate("password_update"), Icons.check_circle);
      NavigationManager.goAndRemove(context, "login", transition: "slide");
    }

    if (state.recoveryStatus == RecoveryStatus.hasError) {
      _showSnackBar(state.errorMessage, Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate("forget_password"),
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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              _checkUpdate(state);
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    LogoApp(
                      size: responsive.dp(20),
                    ),
                    const Gap(30),
                    SizedBox(
                      width: responsive.wp(90),
                      child: Text(
                        "* ${context.translate("confirm_email_msg")}",
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(1.6),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const Gap(15),
                    _formConfirmEmail(responsive, context, state),
                    state.isUserExist
                        ? _formRecoveryPassword(responsive, context, state)
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _formRecoveryPassword(
      Responsive responsive, BuildContext context, AuthState state) {
    return Form(
      key: _formRecoveryKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputCustom(
            onChange: (value) => data["new_password"] = value,
            isPassword: showPassword,
            obscureText: obscureText,
            showPassword: () {
              setState(() => obscureText = !obscureText);
            },
            hint: context.translate('new_password'),
            label: context.translate('new_password'),
            keyboardType: TextInputType.emailAddress,
            iconPrefix: const Icon(Icons.lock),
            validator: (value) =>
                pipeFirstNotNullOrNull<String, String>(value!, [
              (value) => Validations.isRequired(value,
                  message: context.translate('is_required')),
              (value) => Validations.isNotEmpty(value,
                  message: context.translate('is_empty')),
            ]),
          ),
          _inputConfirmPassword(context),
          ButtonCustom(
            onPressed: () => _recoveryPassword(),
            isLoading: state.loading,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock),
                const Gap(10),
                Text(
                  context.translate("recovery_password"),
                  style: getMediumStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(2),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _formConfirmEmail(
      Responsive responsive, BuildContext context, AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputCustom(
            onChange: (value) => email = value,
            hint: context.translate('email_address'),
            label: context.translate("email"),
            keyboardType: TextInputType.emailAddress,
            iconPrefix: const Icon(Icons.email),
            enable: !(state.loading || state.isUserExist),
            customSuffixWidget: formSuccess
                ? Icon(
                    Icons.check_circle_rounded,
                    color: ColorManager.success,
                  )
                : null,
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
          state.isUserExist == false
              ? ButtonCustom(
                  onPressed: () => _confirmEmail(),
                  width: responsive.wp(65),
                  isLoading: state.loading,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.email),
                      const Gap(10),
                      Text(
                        context.translate("confirm_email"),
                        style: getMediumStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(2),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  InputCustom _inputConfirmPassword(BuildContext context) {
    return InputCustom(
      onChange: (value) => data["confirm_new_password"] = value,
      isPassword: showPasswordConfirm,
      obscureText: obscureTextConfirm,
      showPassword: () {
        setState(() => obscureTextConfirm = !obscureTextConfirm);
      },
      hint: context.translate('confirm_password'),
      label: context.translate('confirm_password'),
      keyboardType: TextInputType.emailAddress,
      iconPrefix: const Icon(Icons.lock_outline),
      validator: (value) => pipeFirstNotNullOrNull<String, String>(value!, [
        (value) => Validations.isRequired(value,
            message: context.translate('is_required')),
        (value) => Validations.isNotEmpty(value,
            message: context.translate('is_empty')),
        (value) => Validations.isEqual(value, data["new_password"],
            message: context.translate('is_not_equal_password'))
      ]),
    );
  }
}
