import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../main.dart';
import 'settings_menu_row_layout.dart';

class OpenTalker extends StatelessWidget {
  const OpenTalker({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TalkerScreen(talker: talker!),
        ));
      },
      child: SettingsMenuRowLayout(
        title: 'Open Talker',
        iconData: Icons.save_outlined,
      ),
    );
  }
}
