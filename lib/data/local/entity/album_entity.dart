import 'package:drift/drift.dart';

class Albums extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get imageurl => text()();
  IntColumn get userId => integer()();
  DateTimeColumn get createdAt => dateTime()();
}
