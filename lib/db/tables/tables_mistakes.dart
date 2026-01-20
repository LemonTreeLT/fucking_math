import 'package:drift/drift.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart';

// Warning: This sturcture is designed more for math mistakes, may need adjustments for other subjects.
// 错题表
class Mistakes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subject => text().map(SubjectConverter)();
  TextColumn get questionHeader => text()(); // 题目标题
  TextColumn get questionBody => text()(); // 题目内容
  TextColumn get source => text().nullable()(); // 题目来源
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)(); // 创建时间
}

class AnswersLink extends Table {
    IntColumn get id => integer().autoIncrement()();
    IntColumn get mistakeId => integer().references(Mistakes, #id)();

    TextColumn get note => text().nullable()();
    TextColumn get answer => text()();
}

class AnswersTagsLink extends Table {
  IntColumn get answerID => integer().references(AnswersLink, #id)();
  IntColumn get tagID => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {answerID, tagID};
}

class MistakesTagLink extends Table {
  IntColumn get mistakeID => integer().references(Mistakes, #id)();
  IntColumn get tagID => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {mistakeID, tagID};
}

class MistakeLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mistakeID => integer().references(Mistakes, #id)(); // 关联错题ID
  TextColumn get type => text().map(const EnumNameConverter(MistakeLogType.values))(); // 日志类型
  DateTimeColumn get timestamp =>
      dateTime().withDefault(currentDateAndTime)(); // 时间戳
  TextColumn get notes => text().nullable()(); // 备注，可选
}

enum MistakeLogType { view, review, repeat, answer }
