import 'package:flutter/material.dart';
import 'package:popular_gitrepos/components/layouts/main_layout.dart';

class RepositoryDetailsScreen extends StatelessWidget {
  static final kRouteName = '/repository-detail';

  final String id;

  const RepositoryDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        body: Center(
      child: Text('Details'),
    ));
  }
}
