import 'package:flutter/material.dart';

class RepoDetailBototmStickyButon extends StatelessWidget {
  final VoidCallback onTap;
  const RepoDetailBototmStickyButon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: kPrimaryColor.withValues(alpha: 0.05),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * 0.06,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                kPrimaryColor.withValues(alpha: isDarkTheme ? 0.6 : 0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: const Text(
            'View on GitHub',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
