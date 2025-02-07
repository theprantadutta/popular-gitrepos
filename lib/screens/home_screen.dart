import 'dart:async';

import 'package:flutter/material.dart';
import 'package:popular_gitrepos/components/home_screen/home_screen_repository_list.dart';
import 'package:popular_gitrepos/components/home_screen/home_screen_search_bar.dart';

import '../components/home_screen/home_header.dart';
import '../components/layouts/main_layout.dart';

class HomeScreen extends StatefulWidget {
  static const kRouteName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  Timer? _searchDebounce;

  @override
  void initState() {
    searchController = TextEditingController(text: 'Android');
    super.initState();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
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
            ValueListenableBuilder(
              valueListenable: searchController,
              builder: (context, value, _) {
                // Cancel previous debounce timer
                _searchDebounce?.cancel();

                // Start a new debounce timer
                _searchDebounce = Timer(const Duration(seconds: 3), () {
                  if (mounted) {
                    setState(() {}); // Trigger rebuild after debounce delay
                  }
                });
                return HomeScreenRepositoryList(searchText: value.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
