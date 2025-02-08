import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SettingsMenuSectionLayout extends StatelessWidget {
  final int index;
  final String title;
  final List<Widget> children;

  const SettingsMenuSectionLayout({
    super.key,
    required this.title,
    required this.children,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: min(index, 5) * 200),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Column(children: children),
          ],
        ),
      ),
    );
  }
}
