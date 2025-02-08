import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen_repository_list.dart';

class HomeRepositoryListListenable extends StatefulWidget {
  final TextEditingController searchController;
  const HomeRepositoryListListenable(
      {super.key, required this.searchController});

  @override
  State<HomeRepositoryListListenable> createState() =>
      _HomeRepositoryListListenableState();
}

class _HomeRepositoryListListenableState
    extends State<HomeRepositoryListListenable> {
  late ValueNotifier<String> debouncedSearchNotifier;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    debouncedSearchNotifier = ValueNotifier(widget.searchController.text);

    widget.searchController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      if (mounted) {
        debouncedSearchNotifier.value = widget.searchController.text;
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    debouncedSearchNotifier.dispose();
    widget.searchController.removeListener(_onSearchTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: debouncedSearchNotifier,
      builder: (context, value, child) {
        return HomeScreenRepositoryList(searchText: value);
      },
    );
  }
}
