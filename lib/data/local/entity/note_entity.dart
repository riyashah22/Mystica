import 'package:drift/drift.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get tag => text()();
  IntColumn get userId => integer()();
  IntColumn get notebookId => integer()();
  DateTimeColumn get createdAt => dateTime()();
}
