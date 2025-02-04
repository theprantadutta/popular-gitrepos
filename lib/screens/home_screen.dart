import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:popular_gitrepos/components/layouts/main_layout.dart';
import 'package:popular_gitrepos/screens/repository_details_screen.dart';

class HomeScreen extends StatelessWidget {
  static const kRouteName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Center(
        child: GestureDetector(
          onTap: () =>
              context.push("${RepositoryDetailsScreen.kRouteName}/some"),
          child: Text('Home Screen'),
        ),
      ),
    );
  }
}
