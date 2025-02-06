import 'package:drift/drift.dart';

class GithubRepositories extends Table {
  IntColumn get id => integer()(); // Repository ID from GitHub
  TextColumn get name => text()(); // Repository name
  TextColumn get fullName => text()(); // Full repository name
  TextColumn get htmlUrl => text()(); // Repository URL
  TextColumn get description => text().nullable()(); // Repository description
  IntColumn get stargazersCount => integer()(); // Stars count
  IntColumn get watchersCount => integer()(); // Watchers count
  IntColumn get forksCount => integer()(); // Forks count
  IntColumn get openIssuesCount => integer()(); // Open issues count
  TextColumn get topics => text().nullable()(); // Comma-separated topics
  TextColumn get ownerLogin => text()(); // Repository owner username
  TextColumn get ownerAvatarUrl => text()(); // Repository owner avatar URL
  TextColumn get language => text().nullable()(); // Programming language used
  DateTimeColumn get updatedAt => dateTime()(); // Last updated time

  @override
  Set<Column> get primaryKey => {id};
}
