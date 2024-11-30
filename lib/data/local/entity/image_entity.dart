import 'package:drift/drift.dart';

class MyImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get alttext => text()();
  TextColumn get imageurl => text()();
  TextColumn get tag => text()();
  IntColumn get userId => integer()();
  IntColumn get albumId => integer()();
  DateTimeColumn get createdAt => dateTime()();
}
