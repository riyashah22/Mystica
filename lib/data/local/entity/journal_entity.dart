import 'package:drift/drift.dart';

class Journals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get tag => text()();
  IntColumn get userId => integer()();
  DateTimeColumn get createdAt => dateTime()();
}
