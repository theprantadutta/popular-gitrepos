import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popular_gitrepos/dtos/github_response_dto.dart';
import 'package:popular_gitrepos/services/github_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/github_repository_provider.g.dart';

@Riverpod(keepAlive: true)
Future<GithubResponseDto> fetchGithubRepositories(
  Ref ref,
  String search,
  int pageNumber,
) async {
  return await GithubService.fetchGithubRepositories(
    search,
    pageNumber,
  );
}
