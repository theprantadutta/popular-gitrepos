import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:popular_gitrepos/constants/colors.dart';
import 'package:popular_gitrepos/dtos/single_repository_dto.dart';

import 'repo_detail_single_count.dart';

class RepoDetailCountRow extends StatelessWidget {
  final SingleRepositoryDto repositoryDto;

  const RepoDetailCountRow({
    super.key,
    required this.repositoryDto,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 5,
              children: [
                RepoDetailSingleCount(
                  label: 'Stars',
                  icon: Icons.star_rounded,
                  count: repositoryDto.stargazersCount,
                  color: kStarColor,
                ),
                RepoDetailSingleCount(
                  label: 'Forks',
                  icon: Icons.fork_right_rounded,
                  count: repositoryDto.forksCount,
                  color: kForkColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 5,
              children: [
                RepoDetailSingleCount(
                  label: 'Watchers',
                  icon: Icons.visibility_rounded,
                  count: repositoryDto.watchersCount,
                  color: kWatchersColor,
                ),
                RepoDetailSingleCount(
                  label: 'Open Issues',
                  icon: Icons.bug_report_outlined,
                  count: repositoryDto.openIssuesCount,
                  color: kOpenIssuesColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RepoDetailCountRowSkeletor extends StatelessWidget {
  const RepoDetailCountRowSkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 5,
            children: [
              RepoDetailSingleCount(
                label: 'Stars',
                icon: Icons.star_rounded,
                count: 117232,
                color: kStarColor,
              ),
              RepoDetailSingleCount(
                label: 'Forks',
                icon: Icons.fork_right_rounded,
                count: 11104,
                color: kForkColor,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 5,
            children: [
              RepoDetailSingleCount(
                label: 'Watchers',
                icon: Icons.visibility_rounded,
                count: 117232,
                color: kWatchersColor,
              ),
              RepoDetailSingleCount(
                label: 'Open Issues',
                icon: Icons.bug_report_outlined,
                count: 2239,
                color: kOpenIssuesColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
