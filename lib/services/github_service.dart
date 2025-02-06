import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:popular_gitrepos/dtos/github_response_dto.dart';
import 'package:popular_gitrepos/services/http_service.dart';

import '../database/database.dart';
import '../main.dart';
import '../service_locator/init_service_locators.dart';

class GithubService {
  GithubService._();

  // static Future<GithubResponseDto> fetchGithubRepositories(
  //   String search,
  //   int pageNumber,
  // ) async {
  //   const int perPage = 10;
  //   final String url =
  //       'https://api.github.com/search/repositories?q=$search&sort=stars&order=desc&page=$pageNumber&per_page=$perPage';

  //   try {
  //     final response = await HttpService.get(url);
  //     if (response.statusCode == 200) {
  //       await Future.delayed(Duration(seconds: 10));
  //       return GithubResponseDto.fromJson(json.decode(response.data));
  //     }
  //     throw Exception('Failed to get github data');
  //   } catch (e) {
  //     talker?.error('Failed to fetch repositories', e);
  //     rethrow;
  //   }
  // }

  static Future<GithubResponseDto> fetchGithubRepositories(
    String search,
    int pageNumber,
  ) async {
    const int perPage = 10;
    final database = getIt<AppDatabase>();

    try {
      // Check if we have data stored locally
      final localData = await (database.select(database.githubRepositories)
            ..limit(perPage, offset: (pageNumber - 1) * perPage))
          .get();

      if (localData.isNotEmpty) {
        // Convert local data into RepositoryDto list
        final sortedRepositories = localData
            .map((repo) => RepositoryDto(
                  id: repo.id,
                  name: repo.name,
                  fullName: repo.fullName,
                  htmlUrl: repo.htmlUrl,
                  description: repo.description ?? '',
                  stargazersCount: repo.stargazersCount,
                  watchersCount: repo.watchersCount,
                  forksCount: repo.forksCount,
                  openIssuesCount: repo.openIssuesCount,
                  topics: repo.topics?.split(',') ?? [],
                  owner: OwnerDto(
                    login: repo.ownerLogin,
                    avatarUrl: repo.ownerAvatarUrl,
                  ),
                  language: repo.language,
                  updatedAt: repo.updatedAt,
                ))
            .toList();

        // Sort the list by stargazersCount in descending order
        sortedRepositories
            .sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));

        // Return the sorted data as GithubResponseDto
        return GithubResponseDto(
          totalCount: sortedRepositories.length,
          items: sortedRepositories,
        );
      }

      // If no data is found, fetch from API
      final String url =
          'https://api.github.com/search/repositories?q=$search&sort=stars&order=desc&page=$pageNumber&per_page=$perPage';

      final response = await HttpService.get(url);
      if (response.statusCode == 200) {
        final githubResponse =
            GithubResponseDto.fromJson(json.decode(response.data));

        // Store fetched data locally
        await database.batch((batch) {
          batch.insertAll(
            database.githubRepositories,
            githubResponse.items
                .map((repo) => GithubRepositoriesCompanion.insert(
                      id: Value(repo.id),
                      name: repo.name,
                      fullName: repo.fullName,
                      htmlUrl: repo.htmlUrl,
                      description: Value(repo.description),
                      stargazersCount: repo.stargazersCount,
                      watchersCount: repo.watchersCount,
                      forksCount: repo.forksCount,
                      openIssuesCount: repo.openIssuesCount,
                      topics: Value(repo.topics.isNotEmpty
                          ? repo.topics.join(',')
                          : null),
                      ownerLogin: repo.owner.login,
                      ownerAvatarUrl: repo.owner.avatarUrl,
                      language: Value(repo.language),
                      updatedAt: repo.updatedAt,
                    ))
                .toList(),
          );
        });

        return githubResponse;
      }
      throw Exception('Failed to fetch GitHub data');
    } catch (e) {
      talker?.error('Failed to fetch repositories', e);
      rethrow;
    }
  }
}
