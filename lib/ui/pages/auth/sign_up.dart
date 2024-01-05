import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:recipe_finder/routes/navigation_manager.dart';
import 'package:recipe_finder/ui/bloc/auth/auth_bloc.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/snack_bar_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/utils/extensions.dart';
import 'package:recipe_finder/utils/validations.dart';
import 'package:recipe_finder/widgets/button_custom.dart';
import 'package:recipe_finder/widgets/input_custom.dart';
import 'package:recipe_finder/widgets/input_date_custom.dart';
import 'package:recipe_finder/widgets/logo_app.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _dateController = TextEditingController();
  Map<String, dynamic> data = {};
  bool showPassword = true;
  bool obscureText = true;
  bool showPasswordConfirm = true;
  bool obscureTextConfirm = true;

  void _registerUser() {
    var isOk = _formKey.currentState!.validate();
    if (isOk) {
      FocusManager.instance.primaryFocus?.unfocus();
      final authBloc = BlocProvider.of<AuthBloc>(context);
      authBloc.add(RegisterUser(data));
    }
  }

  void _openDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(3000),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      confirmText: "Aceptar",
      cancelText: "Cancelar",
    );
    if (pickedDate != null) {
      String date = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dateController.text = date;
        data["birthday"] = date;
      });
    }
  }

  void _showSnackBar(String message, IconData icon) {
    SnackBarManager.showSnackBar(
      context,
      message: message,
      icon: icon,
    );
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    _dateController.text = '';
  }

  void _goToLogin() {
    NavigationManager.goAndRemove(context, "login");
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('sign_up'),
          style: getBoldStyle(
            fontSize: responsive.dp(3),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.isCreate) {
            _showSnackBar(
              context.translate('register_success'),
              Icons.check_circle,
            );
            _clearForm();
            Future.delayed(const Duration(milliseconds: 1000)).then(
              (value) => _goToLogin(),
            );
          } else if (state.status == AuthStatus.hasError) {
            _showSnackBar(context.translate('register_error'), Icons.error);
            _showSnackBar(state.errorMessage, Icons.error);
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputCustom(
                              onChange: (value) {
                                setState(() => data["name"] = value);
                              },
                              hint: context.translate('name'),
                              label: context.translate('name'),
                              keyboardType: TextInputType.emailAddress,
                              iconPrefix: const Icon(Icons.person),
                              validator: (value) =>
                                  pipeFirstNotNullOrNull<String, String>(
                                      value!, [
                                (value) => Validations.isRequired(value,
                                    message: context.translate('is_required')),
                                (value) => Validations.isNotEmpty(value,
                                    message: context.translate('is_empty')),
                              ]),
                            ),
                            InputCustom(
                              onChange: (value) {
                                setState(() => data["email"] = value);
                              },
                              hint: context.translate('email_address'),
                              label: context.translate('email'),
                              keyboardType: TextInputType.emailAddress,
                              iconPrefix: const Icon(Icons.email),
                              validator: (value) =>
                                  pipeFirstNotNullOrNull<String, String>(
                                      value!, [
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
                              isPassword: showPassword,
                              obscureText: obscureText,
                              showPassword: () {
                                setState(() => obscureText = !obscureText);
                              },
                              hint: context.translate('password'),
                              label: context.translate('password'),
                              keyboardType: TextInputType.emailAddress,
                              iconPrefix: const Icon(Icons.lock),
                              validator: (value) =>
                                  pipeFirstNotNullOrNull<String, String>(
                                      value!, [
                                (value) => Validations.isRequired(value,
                                    message: context.translate('is_required')),
                                (value) => Validations.isNotEmpty(value,
                                    message: context.translate('is_empty')),
                              ]),
                            ),
                            _inputConfirmPassword(context),
                            InputDateCustom(
                              onTap: () => _openDatePicker(),
                              hint: context.translate('birthday'),
                              label: context.translate('birthday'),
                              iconPrefix: const Icon(Icons.calendar_month),
                              readOnly: true,
                              controller: _dateController,
                              validator: (value) =>
                                  pipeFirstNotNullOrNull(value, [
                                (value) => Validations.isNotEmptyDate(value,
                                    message: context.translate('is_empty')),
                              ]),
                            ),
                            ButtonCustom(
                              onPressed: () => _registerUser(),
                              width: responsive.wp(60),
                              isLoading: state.loading,
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
          );
        },
      ),
    );
  }

  InputCustom _inputConfirmPassword(BuildContext context) {
    return InputCustom(
      onChange: (value) {},
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
        (value) => Validations.isEqual(value, data["password"],
            message: context.translate('is_not_equal_password'))
      ]),
    );
  }
}
