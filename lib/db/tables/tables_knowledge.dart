import 'package:drift/drift.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart';

class KnowledgeTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subject => text().map(const SubjectConverter())();
  TextColumn get head => text()();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class KnowledgeLogTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get knowledgeID => integer().references(KnowledgeTable, #id)();
  DateTimeColumn get time => dateTime().withDefault(currentDateAndTime)();
  TextColumn get type => text().map(const KnowledgeLogTypeConverter())();
  TextColumn get notes => text().nullable()();
}

class KnowledgeTagLink extends Table {
  IntColumn get knowledgeID => integer().references(KnowledgeTable, #id)();
  IntColumn get tagID => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {knowledgeID, tagID};
}

enum KnowledgeLogType { edit, retry }

class KnowledgeLogTypeConverter extends TypeConverter<KnowledgeLogType, String> {
  const KnowledgeLogTypeConverter();

  @override
  KnowledgeLogType fromSql(String fromDb) {
    try {
      return KnowledgeLogType.values.byName(fromDb);
    } catch (e) {
      throw ArgumentError('Invalid LogType index: $fromDb');
    }
  }

  @override
  String toSql(KnowledgeLogType value) {
    return value.name;
  }
}
