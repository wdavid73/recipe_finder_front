import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_finder/ui/bloc/bloc_imports.dart';
import 'package:recipe_finder/ui/managers/color_manager.dart';
import 'package:recipe_finder/ui/managers/responsive_manager.dart';
import 'package:recipe_finder/ui/managers/style_text_manager.dart';
import 'package:recipe_finder/ui/pages/settings/cubit/settings_cubit.dart';
import 'package:recipe_finder/utils/extensions.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkTheme = true;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    final cubit = BlocProvider.of<SettingsCubit>(context);
    setState(() {
      isDarkTheme = cubit.state == SettingsState.isDarkTheme ? true : false;
    });
  }

  void _setDarkTheme(bool value) {
    setState(() => isDarkTheme = value);
    final cubit = BlocProvider.of<SettingsCubit>(context);
    cubit.setIsDarkMode(value);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate('settings'),
          style: getSemiBoldStyle(
            color: Colors.white,
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ListView(
            children: [
              Gap(responsive.hp(5)),
              Text(
                context.translate('general'),
                style: getSemiBoldStyle(
                  fontSize: responsive.dp(2),
                ),
              ),
              ItemSetting(
                icon: Icons.person_rounded,
                title: context.translate('account'),
              ),
              const ItemSetting(
                icon: Icons.abc,
                title: "title",
              ),
              ItemSetting(
                icon: Icons.delete_forever_rounded,
                title: context.translate('delete_account'),
              ),
              Gap(responsive.hp(5)),
              Text(
                context.translate('feedback'),
                style: getSemiBoldStyle(
                  fontSize: responsive.dp(2),
                ),
              ),
              ItemSetting(
                icon: Icons.warning_rounded,
                title: context.translate('report_bug'),
              ),
              ItemSetting(
                icon: Icons.send_rounded,
                title: context.translate('send_feedback'),
              ),
              Gap(responsive.hp(5)),
              Text(
                context.translate('theme'),
                style: getSemiBoldStyle(
                  fontSize: responsive.dp(2),
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, state) {
                        if (state == SettingsState.isDarkTheme) {
                          return const Icon(
                            Icons.dark_mode_rounded,
                            color: Colors.white,
                          );
                        }
                        if (state == SettingsState.isLightTheme) {
                          return const Icon(
                            Icons.dark_mode_outlined,
                            color: Colors.black,
                          );
                        }
                        return const Icon(
                          Icons.dark_mode_rounded,
                          color: Colors.black,
                        );
                      },
                    ),
                    const Gap(10),
                    Text(
                      context.translate('dark_theme'),
                      style: getRegularStyle(),
                    ),
                  ],
                ),
                value: isDarkTheme,
                onChanged: (bool value) {
                  _setDarkTheme(value);
                },
                dense: true,
                inactiveThumbColor: ColorManager.disabledColor,
                inactiveTrackColor: ColorManager.placeholderColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemSetting extends StatelessWidget {
  final IconData icon;
  final String title;
  const ItemSetting({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: getRegularStyle(),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        Divider(
          height: 0,
          color: ColorManager.divider,
        ),
      ],
    );
  }
}
