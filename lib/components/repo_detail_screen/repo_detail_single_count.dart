import 'package:flutter/material.dart';

import '../../constants/selectors.dart';

class RepoDetailSingleCount extends StatelessWidget {
  final String label;
  final IconData icon;
  final int count;
  final Color color;

  const RepoDetailSingleCount({
    super.key,
    required this.label,
    required this.icon,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: kPrimaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 3,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,
              children: [
                Icon(icon, size: 22, color: color),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: getSecondaryTextColor(isDarkTheme),
                  ),
                ),
              ],
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
