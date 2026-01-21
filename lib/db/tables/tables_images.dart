import 'package:drift/drift.dart';

/// 不提供 path 字段将此图片视为在软件资源目录中
class Images extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get desc => text().nullable()();
  TextColumn get path => text().nullable()();
}
