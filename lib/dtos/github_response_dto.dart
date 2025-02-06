import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part '../generated/dtos/github_response_dto.g.dart';

final _githubApiDateFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

DateTime githubApiDateFromJson(String date) =>
    _githubApiDateFormatter.parseUtc(date);

String githubApiDateToJson(DateTime date) =>
    _githubApiDateFormatter.format(date.toUtc());

@JsonSerializable()
class GithubResponseDto {
  @JsonKey(name: 'total_count')
  final int totalCount;

  final List<RepositoryDto> items;

  GithubResponseDto({
    required this.totalCount,
    required this.items,
  });

  /// Connect the generated [_$GithubResponseDtoFromJson] function to the `fromJson`
  /// factory.
  factory GithubResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GithubResponseDtoFromJson(json);

  /// Connect the generated [_$GithubResponseDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GithubResponseDtoToJson(this);
}

@JsonSerializable()
class RepositoryDto {
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
  final OwnerDto owner;
  final String? language;
  @JsonKey(
    name: 'updated_at',
    fromJson: githubApiDateFromJson,
    toJson: githubApiDateToJson,
  )
  final DateTime updatedAt;

  RepositoryDto({
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

  /// Connect the generated [_$RepositoryDtoFromJson] function to the `fromJson`
  /// factory.
  factory RepositoryDto.fromJson(Map<String, dynamic> json) =>
      _$RepositoryDtoFromJson(json);

  /// Connect the generated [_$RepositoryDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RepositoryDtoToJson(this);
}

@JsonSerializable()
class OwnerDto {
  final String login;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  OwnerDto({
    required this.login,
    required this.avatarUrl,
  });

  /// Connect the generated [_$OwnerDtoFromJson] function to the `fromJson`
  /// factory.
  factory OwnerDto.fromJson(Map<String, dynamic> json) =>
      _$OwnerDtoFromJson(json);

  /// Connect the generated [_$OwnerDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OwnerDtoToJson(this);
}
