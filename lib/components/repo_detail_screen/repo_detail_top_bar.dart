import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../main.dart';

class RepoDetailTopBar extends StatelessWidget {
  final String githubUrl;
  const RepoDetailTopBar({
    super.key,
    required this.githubUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.07,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Share.share('check out $githubUrl');

              if (result.status == ShareResultStatus.success) {
                talker!.info('Thank you for sharing my website!');
              }
            },
            child: Row(
              spacing: 5,
              children: [
                Icon(
                  Icons.share,
                  size: 15,
                ),
                Text(
                  'Share',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RepoDetailTopBarSkeletor extends StatelessWidget {
  const RepoDetailTopBarSkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.07,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 15,
              ),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              Icon(
                Icons.share,
                size: 15,
              ),
              Text(
                'Share',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
