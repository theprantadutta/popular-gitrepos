import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

// Default Flex Scheme Value
final kDefaultFlexScheme = FlexScheme.tealM3;

// Default Theme Mode
final kDefaultThemeMode = ThemeMode.light;

Color getSecondaryTextColor(bool isDarkTheme) =>
    isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade600;
