import 'package:go_router/go_router.dart';
import 'package:popular_gitrepos/screens/repository_details_screen.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../main.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class AppNavigation {
  AppNavigation._();
  static String initial = HomeScreen.kRouteName;

  static final GoRouter router = GoRouter(
    observers: [TalkerRouteObserver(talker!)],
    initialLocation: initial,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: HomeScreen.kRouteName,
        name: "Home",
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '${RepositoryDetailsScreen.kRouteName}/:id',
        name: "RepositoryDetails",
        builder: (context, state) {
          final id = int.parse(state.pathParameters["id"]!);
          return RepositoryDetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: SettingsScreen.kRouteName,
        name: "Settings",
        builder: (context, state) => SettingsScreen(),
      ),
    ],
  );
}
