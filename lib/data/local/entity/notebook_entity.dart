import 'package:drift/drift.dart';

class Notebooks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get tag => text()();
  IntColumn get userId => integer()();
  DateTimeColumn get createdAt => dateTime()();
}
