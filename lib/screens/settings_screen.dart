import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popular_gitrepos/components/settings_screen/open_talker.dart';

import '../components/layouts/main_layout.dart';
import '../components/settings_screen/about_kds_portal_app.dart';
import '../components/settings_screen/change_display_theme.dart';
import '../components/settings_screen/change_them_mode.dart';
import '../components/settings_screen/open_db.dart';
import '../components/settings_screen/settings_header.dart';
import '../components/settings_screen/settings_menu_section_layout.dart';
import '../components/shared/hero_icon_component.dart';

class SettingsScreen extends StatelessWidget {
  static const kRouteName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        children: [
          SettingsHeader(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              HeroIconComponent(),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                // Apperance
                const SettingsMenuSectionLayout(
                  index: 1,
                  title: 'Appearance',
                  children: [
                    ChangeThemMode(),
                    ChangeDisplayTheme(),
                  ],
                ),
                // Apperance
                const SettingsMenuSectionLayout(
                  index: 2,
                  title: 'About',
                  children: [
                    AboutKdsPortalApp(),
                  ],
                ),
                // Developer Options
                if (kDebugMode)
                  Column(
                    children: [
                      SettingsMenuSectionLayout(
                        index: 3,
                        title: 'Debug Options',
                        children: [
                          OpenDb(),
                          OpenTalker(),
                        ],
                      ),
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
