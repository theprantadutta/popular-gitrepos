import 'package:flutter/material.dart';

import '../../main.dart';
import 'settings_menu_row_layout.dart';

class ChangeThemMode extends StatelessWidget {
  const ChangeThemMode({super.key});

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return SettingsMenuRowLayout(
      title: 'Dark Mode',
      iconData: Icons.contrast_outlined,
      child: Switch(
        padding: EdgeInsets.symmetric(horizontal: 0),
        activeColor: kPrimaryColor,
        inactiveThumbColor: kPrimaryColor.withValues(alpha: 0.3),
        inactiveTrackColor: kPrimaryColor.withValues(alpha: 0.3),
        trackColor: WidgetStateProperty.all(
          kPrimaryColor.withValues(alpha: 0.1),
        ),
        trackOutlineColor: WidgetStateProperty.all(
          kPrimaryColor.withValues(alpha: 0.2),
        ),
        value: MyApp.of(context).isDarkMode,
        onChanged: (value) => MyApp.of(context).changeTheme(
          value ? ThemeMode.dark : ThemeMode.light,
        ),
      ),
    );
  }
}
