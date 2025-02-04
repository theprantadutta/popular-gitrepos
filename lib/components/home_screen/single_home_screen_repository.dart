import 'package:flutter/material.dart';
import 'package:popular_gitrepos/dtos/github_response_dto.dart';

class SingleHomeScreenRepository extends StatelessWidget {
  final RepositoryDto repositoryDto;

  const SingleHomeScreenRepository({
    super.key,
    required this.repositoryDto,
  });

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Center(
        child: Text(repositoryDto.fullName),
      ),
    );
  }
}
