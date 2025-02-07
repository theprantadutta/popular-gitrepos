import 'package:drift/drift.dart';

class GithubRepositoryDetails extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get fullName => text()();
  TextColumn get htmlUrl => text()();
  TextColumn get description => text().nullable()();
  IntColumn get stargazersCount => integer()();
  IntColumn get watchersCount => integer()();
  IntColumn get forksCount => integer()();
  IntColumn get openIssuesCount => integer()();
  TextColumn get topics => text().nullable()();
  TextColumn get ownerLogin => text()();
  TextColumn get ownerAvatarUrl => text()();
  TextColumn get language => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
