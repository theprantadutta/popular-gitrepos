import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_gitrepos/providers/github_repository_provider.dart';

import 'single_home_screen_repository.dart';

class HomeScreenRepositoryList extends ConsumerWidget {
  const HomeScreenRepositoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryListProvider = ref.watch(
      FetchGithubRepositoriesProvider('Android', 1),
    );
    return Flexible(
      child: RefreshIndicator(
        onRefresh: () => ref.refresh(
          FetchGithubRepositoriesProvider('Android', 1).future,
        ),
        child: repositoryListProvider.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            final items = data.items;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return SingleHomeScreenRepository(
                  repositoryDto: items[index],
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text('Error'),
            );
          },
          loading: () {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return SingleHomeScreenRepositorySkeletor();
              },
            );
          },
        ),
      ),
    );
  }
}
