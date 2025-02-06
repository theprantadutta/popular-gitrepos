import 'package:flutter/material.dart';

import '../../constants/selectors.dart';

class SingleHomeScreenRepositoryText extends StatelessWidget {
  final String text;
  const SingleHomeScreenRepositoryText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: getSecondaryTextColor(isDarkTheme),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
