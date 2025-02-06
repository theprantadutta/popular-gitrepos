import 'dart:convert';

import 'package:popular_gitrepos/dtos/github_response_dto.dart';
import 'package:popular_gitrepos/services/http_service.dart';

import '../main.dart';

class GithubService {
  GithubService._();

  static Future<GithubResponseDto> fetchGithubRepositories(
    String search,
    int pageNumber,
  ) async {
    const int perPage = 10;
    final String url =
        'https://api.github.com/search/repositories?q=$search&sort=stars&order=desc&page=$pageNumber&per_page=$perPage';

    try {
      final response = await HttpService.get(url);
      if (response.statusCode == 200) {
        await Future.delayed(Duration(seconds: 10));
        return GithubResponseDto.fromJson(json.decode(response.data));
      }
      throw Exception('Failed to get github data');
    } catch (e) {
      talker?.error('Failed to fetch repositories', e);
      rethrow;
    }
  }
}
