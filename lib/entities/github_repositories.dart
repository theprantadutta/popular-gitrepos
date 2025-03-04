import 'package:drift/drift.dart';

class GithubRepositories extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get fullName => text()();
  TextColumn get description => text().nullable()();
  IntColumn get stargazersCount => integer()();
  TextColumn get ownerAvatarUrl => text()();
  TextColumn get language => text().nullable()();
  TextColumn get topics => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
