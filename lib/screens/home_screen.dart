import 'package:flutter/material.dart';
import 'package:popular_gitrepos/components/home_screen/home_screen_repository_list.dart';

import '../components/home_screen/home_header.dart';
import '../components/layouts/main_layout.dart';

class HomeScreen extends StatelessWidget {
  static const kRouteName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 5.0,
        ),
        child: Column(
          children: [
            HomeHeader(),
            HomeScreenRepositoryList(),
          ],
        ),
      ),
    );
  }
}
