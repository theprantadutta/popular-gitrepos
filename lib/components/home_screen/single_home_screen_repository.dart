import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:popular_gitrepos/components/shared/reusable_circle_avatar.dart';
import 'package:popular_gitrepos/dtos/github_response_dto.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/colors.dart';
import '../../constants/selectors.dart';
import '../../screens/repository_details_screen.dart';
import 'single_home_screen_repository_text.dart';

class SingleHomeScreenRepository extends StatelessWidget {
  final RepositoryDto repositoryDto;

  const SingleHomeScreenRepository({
    super.key,
    required this.repositoryDto,
  });

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return TouchRipple(
      onTap: () => context
          .push('${RepositoryDetailsScreen.kRouteName}/${repositoryDto.id}'),
      rippleColor: kPrimaryColor.withValues(alpha: 0.05),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 5,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Row(
              spacing: 10,
              children: [
                ReusableCircleAvatar(
                  avatarUrl: repositoryDto.owner.avatarUrl,
                  radius: 10,
                ),
                Expanded(
                  child: Text(
                    repositoryDto.fullName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(
                  Icons.open_in_new,
                  color: kPrimaryColor,
                  size: 16,
                ),
              ],
            ),
            Text(
              repositoryDto.description.isEmpty
                  ? 'No Descriptions Found'
                  : repositoryDto.description,
              style: TextStyle(
                fontSize: 14,
                color: getSecondaryTextColor(isDarkTheme),
              ),
              maxLines: 2,
            ),
            Divider(
              color: kPrimaryColor.withValues(alpha: 0.15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (repositoryDto.language != null)
                  Row(
                    spacing: 5,
                    children: [
                      Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SingleHomeScreenRepositoryText(
                        text: repositoryDto.language!,
                      ),
                    ],
                  ),
                Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.star,
                      size: 15,
                      color: kStarColor,
                    ),
                    SingleHomeScreenRepositoryText(
                      text: repositoryDto.stargazersCount.toString(),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      size: 15,
                      color: getSecondaryTextColor(isDarkTheme),
                    ),
                    SingleHomeScreenRepositoryText(
                      text:
                          'Updated ${DateFormat('d MMM, yyyy').format(repositoryDto.updatedAt)}',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SingleHomeScreenRepositorySkeletor extends StatelessWidget {
  const SingleHomeScreenRepositorySkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Skeletonizer(
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 5,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Row(
              spacing: 10,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/14101776?v=4',
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'flutter/flutter',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Text(
              'Flutter makes it easy and fast to build beautiful apps for mobile and beyond',
              style: TextStyle(
                fontSize: 14,
                color: getSecondaryTextColor(isDarkTheme),
              ),
              maxLines: 2,
            ),
            Divider(
              color: kPrimaryColor.withValues(alpha: 0.15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    SingleHomeScreenRepositoryText(
                      text: 'Dart',
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.star,
                      size: 15,
                      color: kStarColor,
                    ),
                    SingleHomeScreenRepositoryText(
                      text: '168348',
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      size: 15,
                      color: getSecondaryTextColor(isDarkTheme),
                    ),
                    SingleHomeScreenRepositoryText(
                      text: 'Updated 6 Feb, 2025',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
