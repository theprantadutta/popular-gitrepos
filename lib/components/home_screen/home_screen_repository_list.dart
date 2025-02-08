import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_gitrepos/providers/github_repository_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../dtos/github_response_dto.dart';
import '../../main.dart';
import '../shared/something_went_wrong.dart';
import 'single_home_screen_repository.dart';

class HomeScreenRepositoryList extends ConsumerStatefulWidget {
  final String searchText;

  const HomeScreenRepositoryList({
    super.key,
    required this.searchText,
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

  @override
  void didUpdateWidget(covariant HomeScreenRepositoryList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.searchText != widget.searchText) {
      setState(() {
        pageNumber = 1;
        hasMoreData = true;
        hasError = false;
        repositoryList.clear();
      });

      ref.invalidate(FetchGithubRepositoriesProvider(widget.searchText, 1));
    } else {
      // If coming back from another page, reattach the scroll listener
      repositoryListController.addListener(_repositoryListScrollListener);
    }
  }

  // Restore ScrollController Listener on Rebuild
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    repositoryListController.removeListener(_repositoryListScrollListener);
    repositoryListController.addListener(_repositoryListScrollListener);
  }

  Future<void> _repositoryListScrollListener() async {
    if (repositoryListController.position.pixels ==
        repositoryListController.position.maxScrollExtent) {
      talker?.info('Fetching more github repository...');
      try {
        if (hasMoreData) {
          setState(() {
            hasError = false;
            pageNumber++;
          });
          final _ = await ref.refresh(
            FetchGithubRepositoriesProvider(
              widget.searchText,
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
      ref.invalidate(FetchGithubRepositoriesProvider(widget.searchText, 1));
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
      FetchGithubRepositoriesProvider(widget.searchText, pageNumber),
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
                  index: index,
                );
              },
            );
          },
          error: (error, stackTrace) {
            String errorMessage = 'Something went wrong';

            if (error is DioException) {
              if (error.response?.statusCode == 403 ||
                  error.response?.statusCode == 429) {
                errorMessage = 'Rate limit exceeded. Please try again later.';
              } else {
                errorMessage = 'Network error: ${error.response?.statusCode}';
              }
            }
            return SomethingWentWrong(
              title: errorMessage,
              onRetryPressed: () => _refreshGithubRepository(),
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
                  index: index,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
