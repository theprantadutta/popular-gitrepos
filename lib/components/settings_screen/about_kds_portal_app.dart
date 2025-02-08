import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'settings_menu_row_layout.dart';

class AboutKdsPortalApp extends StatelessWidget {
  const AboutKdsPortalApp({super.key});

  Future<void> showAboutSection(BuildContext context) async {
    final platform = await PackageInfo.fromPlatform();
    final version = platform.version;
    showAboutDialog(
      // ignore: use_build_context_synchronously
      context: context,
      applicationVersion: version,
      applicationName: 'Popular GitRepos',
      children: [
        Column(
          children: [
            Text(
              'Developed & Maintained by',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'Pranta Dutta',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showAboutSection(context),
      child: SettingsMenuRowLayout(
        title: 'About Popular GitRepos',
        iconData: Icons.help_outline,
      ),
    );
  }
}
