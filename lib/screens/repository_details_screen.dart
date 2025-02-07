import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_gitrepos/components/layouts/main_layout.dart';
import 'package:popular_gitrepos/components/repo_detail_screen/repo_detail_top_bar.dart';
import 'package:popular_gitrepos/providers/single_repo_provider.dart';

import '../components/repo_detail_screen/repo_detail_repo_summary.dart';

class RepositoryDetailsScreen extends ConsumerWidget {
  static final kRouteName = '/repository-detail';

  final int id;

  const RepositoryDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singleRepositoryProvider = ref.watch(
      fetchSingleGithubRepositoryByIdProvider(id),
    );
    return MainLayout(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            RepoDetailTopBar(),
            singleRepositoryProvider.when(
              data: (data) {
                return Column(
                  children: [
                    RepoDetailRepoSummary(singleRepositoryDto: data),
                  ],
                );
              },
              error: (error, stackTrace) {
                return Center(
                  child: Text('error'),
                );
              },
              loading: () {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
