import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../shared/floating_theme_change_button.dart';

class MainLayout extends StatelessWidget {
  final Widget body;

  const MainLayout({
    super.key,
    required this.body,
  });

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    if (context.canPop()) context.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return BackButtonListener(
      onBackButtonPressed: () => _onBackButtonPressed(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.transparent,
            // statusBarColor: kPrimaryColor.withValues(alpha: 0.1),
            // Status bar brightness (optional)
            statusBarIconBrightness: isDarkTheme
                ? Brightness.light
                : Brightness.dark, // For Android (dark icons)
            statusBarBrightness: isDarkTheme
                ? Brightness.dark
                : Brightness.light, // For iOS (dark icons)
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  kPrimaryColor.withValues(alpha: 0.12), // Soft start
                  kPrimaryColor.withValues(alpha: 0.06), // Lighter end
                ],
                stops: const [0.0, 1.0],
              ),
            ),
            child: SafeArea(
              child: body,
            ),
          ),
        ),
        floatingActionButton: kReleaseMode
            ? null // Don't show FloatingActionButton in release (production) mode
            : const FloatingThemeChangeButton(),
      ),
    );
  }
}
