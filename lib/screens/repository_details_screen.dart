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
import '../util/functions.dart';

// class RepositoryDetailsScreen extends ConsumerWidget {
//   static final kRouteName = '/repository-detail';

//   final int id;

//   const RepositoryDetailsScreen({
//     super.key,
//     required this.id,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final singleRepositoryProvider = ref.watch(
//       fetchSingleGithubRepositoryByIdProvider(id),
//     );
//     final kPrimaryColor = Theme.of(context).primaryColor;
//     return MainLayout(
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 12.0),
//         child: Column(
//           children: [
//             RepoDetailTopBar(),
//             singleRepositoryProvider.when(
//               data: (data) {
//                 return Stack(
//                   children: [
//                     Positioned(
//                       bottom: 0,
//                       child: Container(
//                         height: MediaQuery.sizeOf(context).height * 0.07,
//                         decoration: BoxDecoration(
//                           color: kPrimaryColor.withValues(alpha: 0.7),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Center(
//                           child: Text('Open Repository'),
//                         ),
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         RepoDetailRepoSummary(singleRepositoryDto: data),
//                         RepoDetailCountRow(repositoryDto: data),
//                         RepoDetailTopics(topics: data.topics),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//               error: (error, stackTrace) {
//                 return Center(
//                   child: Text('error'),
//                 );
//               },
//               loading: () {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
                error: (error, stackTrace) =>
                    const Center(child: Text('Error')),
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
          ],
        ),
      ),
      bottomNavigationBar: RepoDetailBototmStickyButon(onTap: () {}),
    );
  }
}
