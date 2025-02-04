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
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.88,
      child: repositoryListProvider.when(
        data: (data) {
          final items = data.items;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SingleHomeScreenRepository(repositoryDto: items[index]);
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('Error'),
          );
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
