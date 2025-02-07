import 'package:flutter/material.dart';

import '../shared/reusable_form_field.dart';

class HomeScreenSearchBar extends StatelessWidget {
  final TextEditingController searchController;

  const HomeScreenSearchBar({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.06,
      child: ReusableFormField(
        controller: searchController,
        hintText: 'Search Repository...',
        iconData: Icons.search_rounded,
      ),
    );
  }
}
