import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popular_gitrepos/navigation/app_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

import 'constants/selectors.dart';
import 'constants/shared_preference_keys.dart';
import 'service_locator/init_service_locators.dart';

Talker? talker;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      enabled: true,
      colors: {
        TalkerLogType.debug.key: AnsiPen()..magenta(),
      },
    ),
  );
  initServiceLocator();
  runApp(
    ProviderScope(
      observers: [
        TalkerRiverpodObserver(
          talker: talker!,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

// ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  final kFlexSchemeKey = kSharedPreferenceFlexScheme;
  final kIsDarkModeKey = kSharedPreferenceDarkMode;
  var _flexScheme = kDefaultFlexScheme;
  var _themeMode = kDefaultThemeMode;
  SharedPreferences? _sharedPreferences;

  @override
  void initState() {
    intializeSharedPreferences();
    super.initState();
  }

  void intializeSharedPreferences() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
    } catch (e) {
      talker?.error('Failed to initialize SharedPreferences: $e');
    }
    final isDarkMode = _sharedPreferences?.getBool(kIsDarkModeKey);
    if (isDarkMode != null) {
      setState(
          () => _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light);
    }
    final flexScheme = _sharedPreferences?.getString(kFlexSchemeKey);
    if (flexScheme != null) {
      setState(() => _flexScheme = FlexScheme.values.byName(flexScheme));
    }
  }

  void changeFlexScheme(FlexScheme flexScheme) {
    setState(() {
      _flexScheme = flexScheme;
      _sharedPreferences?.setString(kFlexSchemeKey, flexScheme.name);
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
      _sharedPreferences?.setBool(kIsDarkModeKey, themeMode == ThemeMode.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Popular GitRepos',
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: _flexScheme,
        useMaterial3: true,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        // scaffoldBackground: kDefaultLightScaffoldColor,
        textTheme: GoogleFonts.ubuntuTextTheme(),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: _flexScheme,
        useMaterial3: true,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        // scaffoldBackground: kDefaultDarkScaffoldColor,
        textTheme: GoogleFonts.ubuntuTextTheme(),
      ).copyWith(
        brightness: Brightness.dark,
      ),
      routerConfig: AppNavigation.router,
    );
  }
}
