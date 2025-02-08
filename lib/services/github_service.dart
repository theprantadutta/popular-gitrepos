import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:popular_gitrepos/dtos/github_response_dto.dart';
import 'package:popular_gitrepos/services/http_service.dart';

import '../database/database.dart';
import '../dtos/single_repository_dto.dart';
import '../main.dart';
import '../service_locator/init_service_locators.dart';

class GithubService {
  GithubService._();

  static Future<GithubResponseDto> fetchGithubRepositories(
    String search,
    int pageNumber,
  ) async {
    const int perPage = 10;
    final database = getIt<AppDatabase>();

    try {
      // Check if we have data stored locally
      final localData = await (database.select(database.githubRepositories)
            ..where((t) =>
                    t.name.like('%$search%') | // Search in repo name
                    t.description.like('%$search%') | // Search in description
                    t.topics.like('%$search%') // Keep topic filtering
                )
            ..orderBy([(t) => OrderingTerm.desc(t.stargazersCount)])
            ..limit(perPage, offset: (pageNumber - 1) * perPage))
          .get();

      talker?.info('Local Repo Length: ${localData.length}');

      if (localData.length >= 5) {
        // Convert local data into RepositoryDto list
        final sortedRepositories = localData
            .map((repo) => RepositoryDto(
                  id: repo.id,
                  name: repo.name,
                  fullName: repo.fullName,
                  // htmlUrl: repo.htmlUrl,
                  description: repo.description ?? '',
                  stargazersCount: repo.stargazersCount,
                  // watchersCount: repo.watchersCount,
                  // forksCount: repo.forksCount,
                  // openIssuesCount: repo.openIssuesCount,
                  topics: repo.topics?.split(',') ?? [],
                  owner: OwnerDto(
                    // login: repo.ownerLogin,
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
          items: sortedRepositories,
        );
      }

      // If local data has less than 5 results, fetch from API
      final String url =
          'https://api.github.com/search/repositories?q=$search&sort=stars&order=desc&page=$pageNumber&per_page=$perPage';

      final response = await HttpService.get(url);
      if (response.statusCode == 200) {
        final githubResponse =
            GithubResponseDto.fromJson(json.decode(response.data));

        // Store fetched data locally if it doesn't already exist
        await database.batch((batch) async {
          for (final repo in githubResponse.items) {
            // Check if the repository already exists in the database
            final existingRepo =
                await (database.select(database.githubRepositories)
                      ..where((t) => t.id.equals(repo.id)))
                    .getSingleOrNull();

            if (existingRepo == null) {
              batch.insert(
                database.githubRepositories,
                GithubRepositoriesCompanion.insert(
                  id: Value(repo.id),
                  name: repo.name,
                  fullName: repo.fullName,
                  // htmlUrl: repo.htmlUrl,
                  description: Value(repo.description),
                  stargazersCount: repo.stargazersCount,
                  // watchersCount: repo.watchersCount,
                  // forksCount: repo.forksCount,
                  // openIssuesCount: repo.openIssuesCount,
                  topics: Value(
                      repo.topics.isNotEmpty ? repo.topics.join(',') : null),
                  // ownerLogin: repo.owner.login,
                  ownerAvatarUrl: repo.owner.avatarUrl,
                  language: Value(repo.language),
                  updatedAt: repo.updatedAt,
                ),
              );
            }
          }
        });

        return githubResponse;
      }
      throw Exception('Failed to fetch GitHub data');
    } catch (e) {
      talker?.error('Failed to fetch repositories', e);
      rethrow;
    }
  }

  static Future<SingleRepositoryDto> fetchGithubRepositoryById(
      int repoId) async {
    final database = getIt<AppDatabase>();

    try {
      // Check if the repository exists locally
      final localRepo = await (database.select(database.githubRepositoryDetails)
            ..where((t) => t.id.equals(repoId)))
          .getSingleOrNull();

      if (localRepo != null) {
        return SingleRepositoryDto(
          id: localRepo.id,
          name: localRepo.name,
          fullName: localRepo.fullName,
          htmlUrl: localRepo.htmlUrl,
          description: localRepo.description ?? '',
          stargazersCount: localRepo.stargazersCount,
          watchersCount: localRepo.watchersCount,
          openIssuesCount: localRepo.openIssuesCount,
          forksCount: localRepo.forksCount,
          topics: localRepo.topics?.split(',') ?? [],
          owner: SingleRepoOwnerDto(
            login: localRepo.ownerLogin,
            avatarUrl: localRepo.ownerAvatarUrl,
          ),
          language: localRepo.language,
          size: localRepo.size,
          updatedAt: localRepo.updatedAt,
          createdAt: localRepo.createdAt,
          pushedAt: localRepo.pushedAt,
          license: RepositoryLicenseDto(
            spdxId: localRepo.licenseSpdxId,
          ),
        );
      }

      // Fetch from GitHub API if not found locally
      final String url = 'https://api.github.com/repositories/$repoId';
      final response = await HttpService.get(url);

      if (response.statusCode == 200) {
        final repo = SingleRepositoryDto.fromJson(json.decode(response.data));

        // Save to local database
        await database.into(database.githubRepositoryDetails).insert(
              GithubRepositoryDetailsCompanion.insert(
                id: Value(repo.id),
                name: repo.name,
                fullName: repo.fullName,
                htmlUrl: repo.htmlUrl,
                description: Value(repo.description),
                stargazersCount: repo.stargazersCount,
                watchersCount: repo.watchersCount,
                openIssuesCount: repo.openIssuesCount,
                forksCount: repo.forksCount,
                topics: Value(
                    repo.topics.isNotEmpty ? repo.topics.join(',') : null),
                ownerLogin: repo.owner.login,
                ownerAvatarUrl: repo.owner.avatarUrl,
                language: Value(repo.language),
                size: repo.size,
                updatedAt: repo.updatedAt,
                createdAt: repo.createdAt,
                pushedAt: repo.pushedAt,
                licenseSpdxId: repo.license?.spdxId ?? 'N/A',
              ),
              mode: InsertMode.insertOrIgnore, // Avoid duplicate inserts
            );

        return repo;
      }
      throw Exception('Failed to fetch repository data');
    } catch (e) {
      talker?.error('Failed to fetch repository', e);
      rethrow;
    }
  }
}
