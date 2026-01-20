import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_mistakes.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart' show Subject;

part 'mistake.g.dart';

@DriftAccessor(tables: [Mistakes, MistakesTagLink, MistakeLogs, Tags])
class MistakesDao extends DatabaseAccessor<AppDatabase>
    with _$MistakesDaoMixin {
  MistakesDao(super.db);

  // 创建错题
  Future<int> createMistake(MistakesCompanion entry) =>
      into(mistakes).insert(entry);

  // 获取所有错题
  Future<List<Mistake>> getAllMistakes() => select(mistakes).get();

  // 根据学科获取错题
  Future<List<Mistake>> getMistakesBySubject(Subject subject) {
    return (select(
      mistakes,
    )..where((m) => m.subject.equalsValue(subject))).get();
  }

  // 根据ID获取错题
  Future<Mistake?> getMistakeById(int id) {
    return (select(mistakes)..where((m) => m.id.equals(id))).getSingleOrNull();
  }

  // 搜索错题(根据题目标题和内容)
  Future<List<Mistake>> searchMistakes(String query) {
    return (select(mistakes)..where(
          (m) =>
              m.questionHeader.like('%$query%') |
              m.questionBody.like('%$query%'),
        ))
        .get();
  }

  // 更新错题
  Future<bool> updateMistake(Mistake mistake) =>
      update(mistakes).replace(mistake);

  // 删除错题
  Future<int> deleteMistake(int id) {
    return (delete(mistakes)..where((m) => m.id.equals(id))).go();
  }

  // 为错题添加标签
  Future<int> addTagToMistake(int mistakeId, int tagId) {
    return into(mistakesTagLink).insert(
      MistakesTagLinkCompanion(
        mistakeID: Value(mistakeId),
        tagID: Value(tagId),
      ),
    );
  }

  // 移除错题的标签
  Future<int> removeTagFromMistake(int mistakeId, int tagId) {
    return (delete(mistakesTagLink)..where(
          (link) => link.mistakeID.equals(mistakeId) & link.tagID.equals(tagId),
        ))
        .go();
  }

  // 获取错题的所有标签
  Future<List<Tag>> getMistakeTags(int mistakeId) {
    final query = select(tags).join([
      innerJoin(mistakesTagLink, mistakesTagLink.tagID.equalsExp(tags.id)),
    ])..where(mistakesTagLink.mistakeID.equals(mistakeId));

    return query.map((row) => row.readTable(tags)).get();
  }

  // 获取带有特定标签的所有错题
  Future<List<Mistake>> getMistakesByTag(int tagId) {
    final query = select(mistakes).join([
      innerJoin(
        mistakesTagLink,
        mistakesTagLink.mistakeID.equalsExp(mistakes.id),
      ),
    ])..where(mistakesTagLink.tagID.equals(tagId));

    return query.map((row) => row.readTable(mistakes)).get();
  }
  
  // 为错题添加日志
  Future<int> addMistakeLog(MistakeLogsCompanion entry) =>
      into(mistakeLogs).insert(entry);

  // 获取错题的所有日志
  Future<List<MistakeLog>> getMistakeLogs(int mistakeId) =>
      (select(mistakeLogs)..where((l) => l.mistakeID.equals(mistakeId))).get();
}
