import 'package:flutter/material.dart';
import 'package:popular_gitrepos/dtos/single_repository_dto.dart';

import '../../constants/selectors.dart';
import '../shared/reusable_circle_avatar.dart';

class RepoDetailRepoSummary extends StatelessWidget {
  final SingleRepositoryDto singleRepositoryDto;

  const RepoDetailRepoSummary({
    super.key,
    required this.singleRepositoryDto,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 15,
          children: [
            ReusableCircleAvatar(
              avatarUrl: singleRepositoryDto.owner.avatarUrl,
              radius: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  singleRepositoryDto.owner.login,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: getSecondaryTextColor(isDarkTheme),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  singleRepositoryDto.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ),
        Text(
          singleRepositoryDto.description?.trim().isEmpty ?? true
              ? 'No Descriptions Found'
              : singleRepositoryDto.description!,
          style: TextStyle(
            fontSize: 16,
            color: getSecondaryTextColor(isDarkTheme),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          strutStyle: StrutStyle(
            fontSize: 14,
            height: 1.2,
            leading: 0.5,
          ),
        ),
      ],
    );
  }
}

class RepoDetailRepoSummarySkeletor extends StatelessWidget {
  const RepoDetailRepoSummarySkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 15,
          children: [
            ReusableCircleAvatar(
              avatarUrl: 'https://avatars.githubusercontent.com/u/14101776?v=4',
              radius: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'flutter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: getSecondaryTextColor(isDarkTheme),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'react-native',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ),
        Text(
          'Flutter makes it easy and fast to build beautiful apps for mobile and beyond',
          style: TextStyle(
            fontSize: 16,
            color: getSecondaryTextColor(isDarkTheme),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          strutStyle: StrutStyle(
            fontSize: 14,
            height: 1.2,
            leading: 0.5,
          ),
        ),
      ],
    );
  }
}
