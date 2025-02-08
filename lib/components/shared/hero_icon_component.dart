import 'package:flutter/material.dart';

class HeroIconComponent extends StatelessWidget {
  const HeroIconComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'settings-hero',
      child: Center(
        child: Icon(
          Icons.settings_outlined,
          size: 24,
        ),
      ),
    );
  }
}
