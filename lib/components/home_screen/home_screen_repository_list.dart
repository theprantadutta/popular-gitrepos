import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_gitrepos/providers/github_repository_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../dtos/github_response_dto.dart';
import '../../main.dart';
import 'single_home_screen_repository.dart';

class HomeScreenRepositoryList extends ConsumerStatefulWidget {
  const HomeScreenRepositoryList({
    super.key,
  });

  @override
  ConsumerState<HomeScreenRepositoryList> createState() =>
      _HomeScreenRepositoryListState();
}

class _HomeScreenRepositoryListState
    extends ConsumerState<HomeScreenRepositoryList> {
  ScrollController repositoryListController = ScrollController();
  int pageNumber = 1;
  int pageSize = 10;
  bool hasMoreData = true;
  bool hasError = false;
  List<RepositoryDto> repositoryList = [];

  @override
  void initState() {
    super.initState();
    repositoryListController.addListener(_repositoryListScrollListener);
  }

  Future<void> _repositoryListScrollListener() async {
    if (repositoryListController.position.pixels ==
        repositoryListController.position.maxScrollExtent) {
      try {
        if (hasMoreData) {
          setState(() {
            hasError = false;
            pageNumber++;
          });
          final _ = await ref.refresh(
            FetchGithubRepositoriesProvider(
              'Android',
              pageNumber,
            ).future,
          );
        }
      } catch (e) {
        talker?.error(
            'Something went wrong while re-fetching github repository', e);
        setState(() => hasError = true);
      }
    }
  }

  @override
  void dispose() {
    repositoryListController.dispose();
    super.dispose();
  }

  Future<void> _refreshGithubRepository() async {
    talker?.info('Refreshing Salary Summary...');
    try {
      ref.invalidate(FetchGithubRepositoriesProvider('Android', 1));
      setState(() {
        pageNumber = 1;
        repositoryList = [];
        hasError = false;
      });
      await _repositoryListScrollListener();
    } catch (e) {
      talker?.error(
          'Something went wrong while fetching github repository list', e);
      setState(() {
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final repositoryListProvider = ref.watch(
      FetchGithubRepositoriesProvider('Android', pageNumber),
    );
    return Flexible(
      child: RefreshIndicator(
        onRefresh: _refreshGithubRepository,
        child: repositoryListProvider.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            final items = data.items;
            if (items.length < pageSize) {
              hasMoreData = false;
            }
            for (var summary in items) {
              if (!repositoryList.any((n) => n.id == summary.id)) {
                repositoryList.add(summary);
              }
            }
            return ListView.builder(
              controller: repositoryListController,
              itemCount: repositoryList.length + (hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == repositoryList.length) {
                  return SingleHomeScreenRepositorySkeletor();
                }
                return SingleHomeScreenRepository(
                  repositoryDto: repositoryList[index],
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
            if (repositoryList.isEmpty) {
              return Skeletonizer(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      SingleHomeScreenRepositorySkeletor(),
                ),
              );
            }
            return ListView.builder(
              controller: repositoryListController,
              itemCount: repositoryList.length + 1,
              itemBuilder: (context, index) {
                if (index == repositoryList.length) {
                  return SingleHomeScreenRepositorySkeletor();
                }
                return SingleHomeScreenRepository(
                  repositoryDto: repositoryList[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
