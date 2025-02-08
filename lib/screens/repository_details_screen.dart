import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_gitrepos/components/layouts/main_layout.dart';
import 'package:popular_gitrepos/components/repo_detail_screen/repo_detail_bototm_sticky_buton.dart';
import 'package:popular_gitrepos/components/repo_detail_screen/repo_detail_count_row.dart';
import 'package:popular_gitrepos/components/repo_detail_screen/repo_detail_top_bar.dart';
import 'package:popular_gitrepos/components/repo_detail_screen/repo_detail_topics.dart';
import 'package:popular_gitrepos/components/repo_detail_screen/repo_detail_utils.dart';
import 'package:popular_gitrepos/providers/single_repo_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../components/repo_detail_screen/repo_detail_repo_summary.dart';
import '../components/repo_detail_screen/repo_detail_timestamps.dart';
import '../components/shared/something_went_wrong.dart';
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
            const RepoDetailTopBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(
                  fetchSingleGithubRepositoryByIdProvider(id).future,
                ),
                child: singleRepositoryProvider.when(
                  data: (data) => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
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
                    return SomethingWentWrong(
                      title: errorMessage,
                      onRetryPressed: () => ref.refresh(
                        fetchSingleGithubRepositoryByIdProvider(id).future,
                      ),
                    );
                  },
                  loading: () => Skeletonizer(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
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
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RepoDetailBototmStickyButon(onTap: () {}),
    );
  }
}
