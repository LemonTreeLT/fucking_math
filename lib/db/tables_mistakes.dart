import 'package:drift/drift.dart';
import 'package:fucking_math/db/tables_tags.dart';
import 'package:fucking_math/utils/types.dart';

// Warning: This sturcture is designed more for math mistakes, may need adjustments for other subjects.
// 错题表
class Mistakes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subject => text().map(const SubjectConverter())();
  TextColumn get questionHeader => text()(); // 题目标题
  TextColumn get questionBody => text()(); // 题目内容
  TextColumn get correctAnswer => text().nullable()(); // 正确答案
  TextColumn get unvifiedAnswer => text().nullable()(); // 未验证答案
  TextColumn get userAnswer => text().nullable()(); // 用户答案
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)(); // 创建时间
}

class MistakesTagLink extends Table {
  IntColumn get mistakeID => integer().references(Mistakes, #id)();
  IntColumn get tagID => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {mistakeID, tagID};
}
