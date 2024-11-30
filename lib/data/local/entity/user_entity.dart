import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get fullname => text()();
  TextColumn get password => text()();
  TextColumn get userProfileUrl => text()();
}
