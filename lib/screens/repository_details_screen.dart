import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../components/layouts/main_layout.dart';
import '../components/repo_detail_screen/repo_detail_bototm_sticky_button.dart';
import '../components/repo_detail_screen/repo_detail_count_row.dart';
import '../components/repo_detail_screen/repo_detail_repo_summary.dart';
import '../components/repo_detail_screen/repo_detail_timestamps.dart';
import '../components/repo_detail_screen/repo_detail_top_bar.dart';
import '../components/repo_detail_screen/repo_detail_topics.dart';
import '../components/repo_detail_screen/repo_detail_utils.dart';
import '../components/shared/something_went_wrong.dart';
import '../providers/single_repo_provider.dart';
import '../util/functions.dart';

class RepositoryDetailsScreen extends ConsumerWidget {
  static final kRouteName = '/repository-detail';
  final int id;

  const RepositoryDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singleRepositoryProvider = ref.watch(
      fetchSingleGithubRepositoryByIdProvider(id),
    );
    return MainLayout(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(
                  fetchSingleGithubRepositoryByIdProvider(id).future,
                ),
                child: singleRepositoryProvider.when(
                  data: (data) => ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    children: [
                      RepoDetailTopBar(
                        githubUrl: data.htmlUrl,
                      ),
                      RepoDetailRepoSummary(singleRepositoryDto: data),
                      SizedBox(height: 10),
                      RepoDetailTimestamps(
                        createdAt: data.createdAt,
                        updatedAt: data.updatedAt,
                        pushedAt: data.pushedAt,
                      ),
                      RepoDetailCountRow(repositoryDto: data),
                      RepoDetailUtils(
                        language: data.language ?? 'N/A',
                        size: formatFileSize(data.size),
                        license: data.license?.spdxId ?? 'N/A',
                      ),
                      RepoDetailTopics(topics: data.topics),
                    ],
                  ),
                  error: (error, stackTrace) {
                    String errorMessage = 'Something went wrong';

                    if (error is DioException) {
                      if (error.response?.statusCode == 403 ||
                          error.response?.statusCode == 429) {
                        errorMessage =
                            'Rate limit exceeded. Please try again later.';
                      } else {
                        errorMessage =
                            'Network error: ${error.response?.statusCode}';
                      }
                    }
                    return Column(
                      children: [
                        RepoDetailTopBar(
                          githubUrl: 'https://github.com',
                        ),
                        Expanded(
                          child: SomethingWentWrong(
                            title: errorMessage,
                            onRetryPressed: () => ref.refresh(
                              fetchSingleGithubRepositoryByIdProvider(id)
                                  .future,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => Skeletonizer(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          RepoDetailTopBarSkeletor(),
                          RepoDetailRepoSummarySkeletor(),
                          SizedBox(height: 10),
                          RepoDetailTimestampsSkeletor(),
                          RepoDetailCountRowSkeletor(),
                          RepoDetailUtilsSkeletor(),
                          RepoDetailTopicsSkeletor(),
                        ],
                      ),
                    ),
                  ),
                  skipLoadingOnRefresh: false,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: singleRepositoryProvider.when(
        data: (data) => RepoDetailBototmStickyButton(githubUrl: data.htmlUrl),
        loading: () => RepoDetailBototmStickyButtonSkeletor(),
        error: (_, __) => RepoDetailBototmStickyButton(
          githubUrl: 'https://github.com',
          hasError: true,
        ),
      ),
    );
  }
}
