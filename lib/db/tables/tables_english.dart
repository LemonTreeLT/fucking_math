import 'package:drift/drift.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';

class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().unique()(); // 单词
  TextColumn get definitionPreview => text().nullable()();
  TextColumn get definition => text().nullable()(); // 释义
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)(); // 创建时间
}

class WordLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordID => integer().references(Words, #id)(); // 关联单词ID
  TextColumn get type => text().map(EnumNameConverter(EnglishLogType.values))(); // 日志类型
  DateTimeColumn get timestamp =>
      dateTime().withDefault(currentDateAndTime)(); // 时间戳
  TextColumn get notes => text().nullable()(); // 备注，可选
}

class WordTagLink extends Table {
  IntColumn get wordID => integer().references(Words, #id)();
  IntColumn get tagID => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {wordID, tagID};
}

class Phrases extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordID => integer().references(Words, #id)(); // 关联单词
  TextColumn get phrase => text().unique()(); // 短语
  TextColumn get definition => text().nullable()(); // 释义
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)(); // 创建时间
}

class PhrasesTagLink extends Table {
  IntColumn get phraseID => integer().references(Phrases, #id)();
  IntColumn get tagID => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {phraseID, tagID};
}

class PhraseLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get phraseID => integer().references(Phrases, #id)(); // 关联短语ID
  TextColumn get type => text().map(EnumNameConverter(EnglishLogType.values))(); // 日志类型
  DateTimeColumn get timestamp =>
      dateTime().withDefault(currentDateAndTime)(); // 时间戳
  TextColumn get notes => text().nullable()(); // 备注，可选
}

enum EnglishLogType { view, test, repeat }
