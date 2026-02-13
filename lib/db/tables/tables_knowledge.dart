import 'package:drift/drift.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart';

class Knowledge extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subject => text().map(SubjectConverter)();
  TextColumn get head => text()();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class KnowledgeLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get knowledgeID => integer().references(Knowledge, #id)();
  DateTimeColumn get time => dateTime().withDefault(currentDateAndTime)();
  TextColumn get type => text().map(EnumNameConverter(KnowledgeLogType.values))();
  TextColumn get notes => text().nullable()();
}

class KnowledgeTagLink extends Table {
  IntColumn get knowledgeID => integer().references(Knowledge, #id)();
  IntColumn get tagID => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {knowledgeID, tagID};
}

enum KnowledgeLogType { edit, retry }
