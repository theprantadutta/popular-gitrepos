import 'package:flutter/material.dart';
import 'package:popular_gitrepos/components/home_screen/home_screen_search_bar.dart';

import '../components/home_screen/home_header.dart';
import '../components/home_screen/home_repository_list_listenable.dart';
import '../components/layouts/main_layout.dart';

class HomeScreen extends StatefulWidget {
  static const kRouteName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: 'Android');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
            HomeScreenSearchBar(searchController: searchController),
            SizedBox(height: 5),
            HomeRepositoryListListenable(searchController: searchController),
          ],
        ),
      ),
    );
  }
}
