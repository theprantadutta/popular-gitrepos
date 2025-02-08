import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/selectors.dart';
import 'repo_detail_card_row.dart';

class RepoDetailTimestamps extends StatelessWidget {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime pushedAt;

  const RepoDetailTimestamps({
    super.key,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
  });

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return FadeInUp(
      duration: Duration(milliseconds: 200),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kPrimaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            RepoDetailCardRow(
              title: 'Created At',
              value: DateFormat(kDefaultDateFormat).format(createdAt),
              iconData: Icons.create,
            ),
            Divider(
              height: 20,
              thickness: 1,
              color: kPrimaryColor.withValues(alpha: 0.1),
            ),
            RepoDetailCardRow(
              title: 'Updated At',
              value: DateFormat(kDefaultDateFormat).format(updatedAt),
              iconData: Icons.update,
            ),
            Divider(
              height: 20,
              thickness: 1,
              color: kPrimaryColor.withValues(alpha: 0.1),
            ),
            RepoDetailCardRow(
              title: 'Pushed At',
              value: DateFormat(kDefaultDateFormat).format(pushedAt),
              iconData: Icons.update,
            ),
          ],
        ),
      ),
    );
  }
}

class RepoDetailTimestampsSkeletor extends StatelessWidget {
  const RepoDetailTimestampsSkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kPrimaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          RepoDetailCardRow(
            title: 'Created At',
            value: '11-21-2017 18:00',
            iconData: Icons.create,
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: kPrimaryColor.withValues(alpha: 0.1),
          ),
          RepoDetailCardRow(
            title: 'Updated At',
            value: '11-21-2017 18:00',
            iconData: Icons.update,
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: kPrimaryColor.withValues(alpha: 0.1),
          ),
          RepoDetailCardRow(
            title: 'Pushed At',
            value: '11-21-2017 18:00',
            iconData: Icons.update,
          ),
        ],
      ),
    );
  }
}
