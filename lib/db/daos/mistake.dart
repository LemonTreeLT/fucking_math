import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_images.dart';
import 'package:fucking_math/db/tables/tables_mistakes.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart' show Subject;

part 'mistake.g.dart';

@DriftAccessor(
  tables: [
    Mistakes,
    Answers,
    MistakeLogs,
    MistakePicsLink,
    AnswersTagsLink,
    AnswerPicsLink,
    MistakesTagLink,
    Tags,
    Images,
  ],
)
class MistakesDao extends DatabaseAccessor<AppDatabase>
    with _$MistakesDaoMixin {
  MistakesDao(super.db);

  // ==================== Mistakes 基础 CRUD ====================

  /// 创建错题
  Future<int> createMistake(MistakesCompanion entry) =>
      into(mistakes).insert(entry);

  /// 通过 ID 获取错题
  Future<Mistake?> getMistakeById(int id) =>
      (select(mistakes)..where((m) => m.id.equals(id))).getSingleOrNull();

  /// 获取所有错题
  Future<List<Mistake>> getAllMistakes() => select(mistakes).get();

  /// 根据学科获取错题
  Future<List<Mistake>> getMistakesBySubject(Subject subject) =>
      (select(mistakes)..where((m) => m.subject.equalsValue(subject))).get();

  /// 模糊搜索错题（在题目标题和内容中搜索）
  Future<List<Mistake>> searchMistakes(String keyword) =>
      (select(mistakes)..where(
            (m) =>
                m.questionHeader.like('%$keyword%') |
                m.questionBody.like('%$keyword%'),
          ))
          .get();

  /// 分页查询错题
  Future<List<Mistake>> getMistakesPaginated(int limit, int offset) =>
      (select(mistakes)
            ..orderBy([(m) => OrderingTerm.desc(m.createdAt)])
            ..limit(limit, offset: offset))
          .get();

  /// 更新错题
  Future<bool> updateMistake(Mistake mistake) =>
      update(mistakes).replace(mistake);

  /// 通过 Companion 更新错题
  Future<int> updateMistakeWithCompanion(int id, MistakesCompanion companion) =>
      (update(mistakes)..where((m) => m.id.equals(id))).write(companion);

  /// 删除错题（级联删除所有关联数据）
  Future<int> deleteMistake(int id) => transaction(() async {
    // 先删除关联表数据
    await (delete(mistakePicsLink)..where((l) => l.mistakeId.equals(id))).go();
    await (delete(mistakesTagLink)..where((l) => l.mistakeID.equals(id))).go();

    // 获取所有关联的答案 ID
    final answerIds = await (select(
      answers,
    )..where((a) => a.mistakeId.equals(id))).map((a) => a.id).get();

    // 删除答案的关联数据
    for (final answerId in answerIds) {
      await (delete(
        answersTagsLink,
      )..where((l) => l.answerID.equals(answerId))).go();
      await (delete(
        answerPicsLink,
      )..where((l) => l.answerID.equals(answerId))).go();
    }

    // 删除所有答案
    await (delete(answers)..where((a) => a.mistakeId.equals(id))).go();

    // 删除日志
    await (delete(mistakeLogs)..where((l) => l.mistakeID.equals(id))).go();

    // 最后删除错题本身
    return (delete(mistakes)..where((m) => m.id.equals(id))).go();
  });

  // ==================== Answers 基础 CRUD ====================

  /// 创建答案
  Future<int> createAnswer(AnswersCompanion entry) =>
      into(answers).insert(entry);

  /// 通过 ID 获取答案
  Future<Answer?> getAnswerById(int id) =>
      (select(answers)..where((a) => a.id.equals(id))).getSingleOrNull();

  /// 获取某个错题的所有答案
  Future<List<Answer>> getAnswersByMistakeId(int mistakeId) =>
      (select(answers)..where((a) => a.mistakeId.equals(mistakeId))).get();

  /// 更新答案
  Future<bool> updateAnswer(Answer answer) => update(answers).replace(answer);

  /// 通过 Companion 更新答案
  Future<int> updateAnswerWithCompanion(int id, AnswersCompanion companion) =>
      (update(answers)..where((a) => a.id.equals(id))).write(companion);

  /// 删除答案（级联删除关联数据）
  Future<int> deleteAnswer(int id) => transaction(() async {
    // 删除答案的标签和图片关联
    await (delete(answersTagsLink)..where((l) => l.answerID.equals(id))).go();
    await (delete(answerPicsLink)..where((l) => l.answerID.equals(id))).go();

    // 删除答案本身
    return (delete(answers)..where((a) => a.id.equals(id))).go();
  });

  // ==================== MistakeLogs 基础 CRUD ====================

  /// 创建错题日志
  Future<int> createMistakeLog(MistakeLogsCompanion entry) =>
      into(mistakeLogs).insert(entry);

  /// 通过 ID 获取日志
  Future<MistakeLog?> getMistakeLogById(int id) =>
      (select(mistakeLogs)..where((l) => l.id.equals(id))).getSingleOrNull();

  /// 获取某个错题的所有日志（按时间倒序）
  Future<List<MistakeLog>> getLogsByMistakeId(int mistakeId) =>
      (select(mistakeLogs)
            ..where((l) => l.mistakeID.equals(mistakeId))
            ..orderBy([(l) => OrderingTerm.desc(l.timestamp)]))
          .get();

  /// 获取某个错题特定类型的日志
  Future<List<MistakeLog>> getLogsByMistakeIdAndType(
    int mistakeId,
    MistakeLogType type,
  ) =>
      (select(mistakeLogs)
            ..where(
              (l) => l.mistakeID.equals(mistakeId) & l.type.equalsValue(type),
            )
            ..orderBy([(l) => OrderingTerm.desc(l.timestamp)]))
          .get();

  /// 更新日志
  Future<bool> updateMistakeLog(MistakeLog log) =>
      update(mistakeLogs).replace(log);

  /// 通过 Companion 更新日志
  Future<int> updateMistakeLogWithCompanion(
    int id,
    MistakeLogsCompanion companion,
  ) => (update(mistakeLogs)..where((l) => l.id.equals(id))).write(companion);

  /// 删除日志
  Future<int> deleteMistakeLog(int id) =>
      (delete(mistakeLogs)..where((l) => l.id.equals(id))).go();

  // ==================== MistakePicsLink 关联操作 ====================

  /// 为错题添加图片关联
  Future<int> addPicToMistake(int mistakeId, int picId) => into(
    mistakePicsLink,
  ).insert(MistakePicsLinkCompanion.insert(mistakeId: mistakeId, picId: picId));

  /// 移除错题的图片关联
  Future<int> removePicFromMistake(int mistakeId, int picId) => (delete(
    mistakePicsLink,
  )..where((l) => l.mistakeId.equals(mistakeId) & l.picId.equals(picId))).go();

  /// 获取错题关联的所有图片
  Future<List<Image>> getPicsByMistakeId(int mistakeId) {
    final query = select(images).join([
      innerJoin(mistakePicsLink, mistakePicsLink.picId.equalsExp(images.id)),
    ])..where(mistakePicsLink.mistakeId.equals(mistakeId));

    return query.map((row) => row.readTable(images)).get();
  }

  /// 获取错题关联的所有图片 ID
  Future<List<int>> getPicIdsByMistakeId(int mistakeId) => (select(
    mistakePicsLink,
  )..where((l) => l.mistakeId.equals(mistakeId))).map((l) => l.picId).get();

  // ==================== MistakesTagLink 关联操作 ====================

  /// 为错题添加标签关联
  Future<int> addTagToMistake(int mistakeId, int tagId) => into(
    mistakesTagLink,
  ).insert(MistakesTagLinkCompanion.insert(mistakeID: mistakeId, tagID: tagId));

  /// 移除错题的标签关联
  Future<int> removeTagFromMistake(int mistakeId, int tagId) => (delete(
    mistakesTagLink,
  )..where((l) => l.mistakeID.equals(mistakeId) & l.tagID.equals(tagId))).go();

  /// 获取错题关联的所有标签
  Future<List<Tag>> getTagsByMistakeId(int mistakeId) {
    final query = select(tags).join([
      innerJoin(mistakesTagLink, mistakesTagLink.tagID.equalsExp(tags.id)),
    ])..where(mistakesTagLink.mistakeID.equals(mistakeId));

    return query.map((row) => row.readTable(tags)).get();
  }

  /// 获取错题关联的所有标签 ID
  Future<List<int>> getTagIdsByMistakeId(int mistakeId) => (select(
    mistakesTagLink,
  )..where((l) => l.mistakeID.equals(mistakeId))).map((l) => l.tagID).get();

  /// 根据标签 ID 查询关联的错题
  Future<List<Mistake>> getMistakesByTagId(int tagId) {
    final query = select(mistakes).join([
      innerJoin(
        mistakesTagLink,
        mistakesTagLink.mistakeID.equalsExp(mistakes.id),
      ),
    ])..where(mistakesTagLink.tagID.equals(tagId));

    return query.map((row) => row.readTable(mistakes)).get();
  }

  // ==================== AnswersTagsLink 关联操作 ====================

  /// 为答案添加标签关联
  Future<int> addTagToAnswer(int answerId, int tagId) => into(
    answersTagsLink,
  ).insert(AnswersTagsLinkCompanion.insert(answerID: answerId, tagID: tagId));

  /// 移除答案的标签关联
  Future<int> removeTagFromAnswer(int answerId, int tagId) => (delete(
    answersTagsLink,
  )..where((l) => l.answerID.equals(answerId) & l.tagID.equals(tagId))).go();

  /// 获取答案关联的所有标签
  Future<List<Tag>> getTagsByAnswerId(int answerId) {
    final query = select(tags).join([
      innerJoin(answersTagsLink, answersTagsLink.tagID.equalsExp(tags.id)),
    ])..where(answersTagsLink.answerID.equals(answerId));

    return query.map((row) => row.readTable(tags)).get();
  }

  /// 获取答案关联的所有标签 ID
  Future<List<int>> getTagIdsByAnswerId(int answerId) => (select(
    answersTagsLink,
  )..where((l) => l.answerID.equals(answerId))).map((l) => l.tagID).get();

  // ==================== AnswerPicsLink 关联操作 ====================

  /// 为答案添加图片关联
  Future<int> addPicToAnswer(int answerId, int picId) => into(
    answerPicsLink,
  ).insert(AnswerPicsLinkCompanion.insert(answerID: answerId, picID: picId));

  /// 移除答案的图片关联
  Future<int> removePicFromAnswer(int answerId, int picId) => (delete(
    answerPicsLink,
  )..where((l) => l.answerID.equals(answerId) & l.picID.equals(picId))).go();

  /// 获取答案关联的所有图片
  Future<List<Image>> getPicsByAnswerId(int answerId) {
    final query = select(images).join([
      innerJoin(answerPicsLink, answerPicsLink.picID.equalsExp(images.id)),
    ])..where(answerPicsLink.answerID.equals(answerId));

    return query.map((row) => row.readTable(images)).get();
  }

  /// 获取答案关联的所有图片 ID
  Future<List<int>> getPicIdsByAnswerId(int answerId) => (select(
    answerPicsLink,
  )..where((l) => l.answerID.equals(answerId))).map((l) => l.picID).get();

  // ==================== 复合查询 ====================

  /// 获取错题详情（包含答案、标签、图片）
  /// 返回 Map 包含:
  /// - 'mistake': Mistake 对象
  /// - 'answers': List&lt;Answer&gt;
  /// - 'tags': List&lt;Tag&gt;
  /// - 'images': List&lt;Image&gt;
  Future<Map<String, dynamic>?> getMistakeDetail(int mistakeId) async {
    final mistake = await getMistakeById(mistakeId);
    if (mistake == null) return null;

    return {
      'mistake': mistake,
      'answers': await getAnswersByMistakeId(mistakeId),
      'tags': await getTagsByMistakeId(mistakeId),
      'images': await getPicsByMistakeId(mistakeId),
    };
  }

  /// 根据时间范围查询错题
  Future<List<Mistake>> getMistakesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) =>
      (select(mistakes)
            ..where(
              (m) =>
                  m.createdAt.isBiggerOrEqualValue(startDate) &
                  m.createdAt.isSmallerOrEqualValue(endDate),
            )
            ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]))
          .get();

  /// 根据多个标签 ID 查询错题（交集）
  /// 返回同时包含所有指定标签的错题
  Future<List<Mistake>> getMistakesByTags(List<int> tagIds) async {
    if (tagIds.isEmpty) return [];
    // 查询每个错题匹配的标签数量
    final query = selectOnly(mistakes)
      ..addColumns([mistakes.id, mistakesTagLink.tagID.count()])
      ..join([
        innerJoin(
          mistakesTagLink,
          mistakesTagLink.mistakeID.equalsExp(mistakes.id),
        ),
      ])
      ..where(mistakesTagLink.tagID.isIn(tagIds))
      ..groupBy([mistakes.id]);
    final results = await query.map((row) {
      return {
        'id': row.read(mistakes.id)!,
        'count': row.read(mistakesTagLink.tagID.count())!,
      };
    }).get();
    // 在 Dart 层过滤：只保留匹配所有标签的错题
    final mistakeIds = results
        .where((r) => r['count'] == tagIds.length)
        .map((r) => r['id'] as int)
        .toList();
    if (mistakeIds.isEmpty) return [];
    return (select(mistakes)..where((m) => m.id.isIn(mistakeIds))).get();
  }
}
