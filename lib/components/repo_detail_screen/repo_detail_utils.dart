import 'package:flutter/material.dart';

import 'repo_detail_card_row.dart';

class RepoDetailUtils extends StatelessWidget {
  final String language;
  final String size;
  final String license;

  const RepoDetailUtils({
    super.key,
    required this.language,
    required this.size,
    required this.license,
  });

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
            title: 'Language',
            value: language,
            iconData: Icons.language_outlined,
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: kPrimaryColor.withValues(alpha: 0.1),
          ),
          RepoDetailCardRow(
            title: 'Size',
            value: size,
            iconData: Icons.zoom_in_outlined,
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: kPrimaryColor.withValues(alpha: 0.1),
          ),
          RepoDetailCardRow(
            title: 'License',
            value: license,
            iconData: Icons.security_outlined,
          ),
        ],
      ),
    );
  }
}

class RepoDetailUtilsSkeletor extends StatelessWidget {
  const RepoDetailUtilsSkeletor({super.key});

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
            title: 'Language',
            value: 'Dart',
            iconData: Icons.language_outlined,
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: kPrimaryColor.withValues(alpha: 0.1),
          ),
          RepoDetailCardRow(
            title: 'Size',
            value: '1.2 MB',
            iconData: Icons.zoom_in_outlined,
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: kPrimaryColor.withValues(alpha: 0.1),
          ),
          RepoDetailCardRow(
            title: 'License',
            value: 'MIT',
            iconData: Icons.security_outlined,
          ),
        ],
      ),
    );
  }
}
