import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_gitrepos/dtos/single_repository_dto.dart';
import 'package:popular_gitrepos/services/github_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/single_repo_provider.g.dart';

@Riverpod(keepAlive: true)
Future<SingleRepositoryDto> fetchSingleGithubRepositoryById(
  Ref ref,
  int repoId,
) async {
  return await GithubService.fetchGithubRepositoryById(repoId);
}
