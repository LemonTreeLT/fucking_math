import 'package:drift/drift.dart';
import 'package:fucking_math/db/tables/tables_images.dart';
import 'package:fucking_math/db/tables/tables_knowledge.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart' show SubjectConverter;

// Warning: This sturcture is designed more for math questions, may need adjustments for other subjects.
// 题目表
class Questions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subject => text().map(SubjectConverter)();
  TextColumn get questionHeader => text()(); // 题目标题
  TextColumn get questionBody => text()(); // 题目内容
  TextColumn get source => text().nullable()(); // 题目来源
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)(); // 创建时间
}

/// 题目正文内嵌图片链接表
class QuestionPicsLink extends Table {
  IntColumn get questionId => integer().references(Questions, #id)();
  IntColumn get picId => integer().references(Images, #id)();

  @override
  Set<Column> get primaryKey => {questionId, picId};
}

class Answers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get questionId => integer().references(Questions, #id)();

  TextColumn get note => text().nullable()();
  TextColumn get head => text().nullable()();
  TextColumn get source => text().nullable()();
  TextColumn get answer => text()();
}

class AnswersTagsLink extends Table {
  IntColumn get answerID => integer().references(Answers, #id)();
  IntColumn get tagID => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {answerID, tagID};
}

class QuestionAnalysis extends Table {
  IntColumn get id => integer().references(Questions, #id).unique()();

  IntColumn get bestAnswer => integer().references(Answers, #id)();

  /// 该字段为错因分析
  TextColumn get reason => text().nullable()();

  /// 该字段为易错点分析
  TextColumn get analysis => text().nullable()();
}

class QuestionKnowledgeLink extends Table {
  IntColumn get questionId => integer().references(Questions, #id)();
  IntColumn get knowledgeId => integer().references(Knowledge, #id)();

  @override
  Set<Column> get primaryKey => {questionId, knowledgeId};
}

/// 回答正文链接图片表
class AnswerPicsLink extends Table {
  IntColumn get answerID => integer().references(Answers, #id)();
  IntColumn get picID => integer().references(Images, #id)();

  @override
  Set<Column> get primaryKey => {answerID, picID};
}

class QuestionsTagLink extends Table {
  IntColumn get questionID => integer().references(Questions, #id)();
  IntColumn get tagID => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {questionID, tagID};
}

class QuestionLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get questionID => integer().references(Questions, #id)(); // 关联题目ID
  TextColumn get type =>
      text().map(const EnumNameConverter(QuestionLogType.values))(); // 日志类型
  DateTimeColumn get timestamp =>
      dateTime().withDefault(currentDateAndTime)(); // 时间戳
  TextColumn get notes => text().nullable()(); // 备注，可选
}

enum QuestionLogType { view, review, repeat, answer }
