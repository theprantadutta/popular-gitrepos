import 'package:json_annotation/json_annotation.dart';

import '../util/json_helpers.dart';

part '../generated/dtos/single_repository_dto.g.dart';

@JsonSerializable()
class SingleRepositoryDto {
  final int id;
  final String name;
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String description;
  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;
  @JsonKey(name: 'watchers_count')
  final int watchersCount;
  @JsonKey(name: 'forks_count')
  final int forksCount;
  @JsonKey(name: 'open_issues_count')
  final int openIssuesCount;
  final List<String> topics;
  final SingleRepoOwnerDto owner;
  final String? language;
  @JsonKey(
    name: 'updated_at',
    fromJson: githubApiDateFromJson,
    toJson: githubApiDateToJson,
  )
  final DateTime updatedAt;

  SingleRepositoryDto({
    required this.id,
    required this.name,
    required this.fullName,
    required this.htmlUrl,
    required this.description,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
    required this.topics,
    required this.owner,
    this.language,
    required this.updatedAt,
  });

  /// Connect the generated [_$SingleRepositoryDtoFromJson] function to the `fromJson`
  /// factory.
  factory SingleRepositoryDto.fromJson(Map<String, dynamic> json) =>
      _$SingleRepositoryDtoFromJson(json);

  /// Connect the generated [_$SingleRepositoryDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SingleRepositoryDtoToJson(this);
}

@JsonSerializable()
class SingleRepoOwnerDto {
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  SingleRepoOwnerDto({
    required this.login,
    required this.avatarUrl,
  });

  /// Connect the generated [_$SingleRepoOwnerDtoFromJson] function to the `fromJson`
  /// factory.
  factory SingleRepoOwnerDto.fromJson(Map<String, dynamic> json) =>
      _$SingleRepoOwnerDtoFromJson(json);

  /// Connect the generated [_$SingleRepoOwnerDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SingleRepoOwnerDtoToJson(this);
}
