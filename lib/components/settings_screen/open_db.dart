import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../../service_locator/init_service_locators.dart';
import 'settings_menu_row_layout.dart';

class OpenDb extends StatelessWidget {
  const OpenDb({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final db = getIt.get<AppDatabase>();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DriftDbViewer(db),
          ),
        );
      },
      child: SettingsMenuRowLayout(
        title: 'Open DB',
        iconData: Icons.save_outlined,
      ),
    );
  }
}
