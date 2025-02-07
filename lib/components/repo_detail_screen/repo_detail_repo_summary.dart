import 'package:flutter/material.dart';
import 'package:popular_gitrepos/dtos/single_repository_dto.dart';

import '../../constants/selectors.dart';

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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 15,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                singleRepositoryDto.owner.avatarUrl,
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 3,
                children: [
                  Text(
                    singleRepositoryDto.owner.login,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: getSecondaryTextColor(isDarkTheme),
                    ),
                  ),
                  Text(
                    singleRepositoryDto.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Text(
          singleRepositoryDto.description.isEmpty
              ? 'No Descriptions Found'
              : singleRepositoryDto.description,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
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
