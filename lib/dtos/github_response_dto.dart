import 'package:json_annotation/json_annotation.dart';

import '../util/json_helpers.dart';

part '../generated/dtos/github_response_dto.g.dart';

@JsonSerializable()
class GithubResponseDto {
  final List<RepositoryDto> items;

  GithubResponseDto({
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
  final String? description;
  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;
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
    this.description,
    required this.stargazersCount,
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
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  OwnerDto({
    required this.avatarUrl,
  });

  /// Connect the generated [_$OwnerDtoFromJson] function to the `fromJson`
  /// factory.
  factory OwnerDto.fromJson(Map<String, dynamic> json) =>
      _$OwnerDtoFromJson(json);

  /// Connect the generated [_$OwnerDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OwnerDtoToJson(this);
}
