import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_images.dart';
import 'package:fucking_math/db/tables/tables_knowledge.dart';
import 'package:fucking_math/db/tables/tables_questions.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart' show Subject;

part 'question.g.dart';

@DriftAccessor(
  tables: [
    Questions,
    Answers,
    QuestionLogs,
    QuestionPicsLink,
    AnswersTagsLink,
    AnswerPicsLink,
    QuestionsTagLink,
    Tags,
    Images,
    QuestionAnalysis,
    QuestionKnowledgeLink,
    Knowledge,
  ],
)
class QuestionsDao extends DatabaseAccessor<AppDatabase>
    with _$QuestionsDaoMixin {
  QuestionsDao(super.db);

  // ==================== Questions 基础 CRUD ====================

  Future<int> assignID() async {
    final maxIdQuery = selectOnly(questions)..addColumns([questions.id.max()]);
    final maxId = await maxIdQuery.map((row) => row.read(questions.id.max())).getSingle();
    return (maxId ?? 0) + 1;
  }

  /// 创建题目
  Future<int> createQuestion(QuestionsCompanion entry) =>
      into(questions).insert(entry);

  /// 通过 ID 获取题目
  Future<Question?> getQuestionById(int id) =>
      (select(questions)..where((m) => m.id.equals(id))).getSingleOrNull();

  /// 获取所有题目
  Future<List<Question>> getAllQuestions() => select(questions).get();

  /// 根据学科获取题目
  Future<List<Question>> getQuestionsBySubject(Subject subject) =>
      (select(questions)..where((m) => m.subject.equalsValue(subject))).get();

  /// 模糊搜索题目（在题目标题和内容中搜索）
  Future<List<Question>> searchQuestions(String keyword) =>
      (select(questions)..where(
            (m) =>
                m.questionHeader.like('%$keyword%') |
                m.questionBody.like('%$keyword%'),
          ))
          .get();

  /// 分页查询题目
  Future<List<Question>> getQuestionsPaginated(int limit, int offset) =>
      (select(questions)
            ..orderBy([(m) => OrderingTerm.desc(m.createdAt)])
            ..limit(limit, offset: offset))
          .get();

  /// 更新题目
  Future<bool> updateQuestion(Question question) =>
      update(questions).replace(question);

  /// 通过 Companion 更新题目
  Future<int> updateQuestionWithCompanion(int id, QuestionsCompanion companion) =>
      (update(questions)..where((m) => m.id.equals(id))).write(companion);

  /// 删除题目（级联删除所有关联数据）
  Future<int> deleteQuestion(int id) => transaction(() async {
    // 先删除关联表数据
    await (delete(questionPicsLink)..where((l) => l.questionId.equals(id))).go();
    await (delete(questionsTagLink)..where((l) => l.questionID.equals(id))).go();
    await (delete(questionAnalysis)..where((t) => t.id.equals(id))).go();
    await (delete(
      questionKnowledgeLink,
    )..where((t) => t.questionId.equals(id))).go();

    // 获取所有关联的答案 ID
    final answerIds = await (select(
      answers,
    )..where((a) => a.questionId.equals(id))).map((a) => a.id).get();

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
    await (delete(answers)..where((a) => a.questionId.equals(id))).go();

    // 删除日志
    await (delete(questionLogs)..where((l) => l.questionID.equals(id))).go();

    // 最后删除题目本身
    return (delete(questions)..where((m) => m.id.equals(id))).go();
  });

  // ==================== Answers 基础 CRUD ====================

  /// 创建答案
  Future<int> createAnswer(AnswersCompanion entry) =>
      into(answers).insert(entry);

  /// 通过 ID 获取答案
  Future<Answer?> getAnswerById(int id) =>
      (select(answers)..where((a) => a.id.equals(id))).getSingleOrNull();

  /// 获取某个题目的所有答案
  Future<List<Answer>> getAnswersByQuestionId(int questionId) =>
      (select(answers)..where((a) => a.questionId.equals(questionId))).get();

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

  // ==================== QuestionLogs 基础 CRUD ====================

  /// 创建题目日志
  Future<int> createQuestionLog(QuestionLogsCompanion entry) =>
      into(questionLogs).insert(entry);

  /// 通过 ID 获取日志
  Future<QuestionLog?> getQuestionLogById(int id) =>
      (select(questionLogs)..where((l) => l.id.equals(id))).getSingleOrNull();

  /// 获取某个题目的所有日志（按时间倒序）
  Future<List<QuestionLog>> getLogsByQuestionId(int questionId) =>
      (select(questionLogs)
            ..where((l) => l.questionID.equals(questionId))
            ..orderBy([(l) => OrderingTerm.desc(l.timestamp)]))
          .get();

  /// 获取某个题目特定类型的日志
  Future<List<QuestionLog>> getLogsByQuestionIdAndType(
    int questionId,
    QuestionLogType type,
  ) =>
      (select(questionLogs)
            ..where(
              (l) => l.questionID.equals(questionId) & l.type.equalsValue(type),
            )
            ..orderBy([(l) => OrderingTerm.desc(l.timestamp)]))
          .get();

  /// 更新日志
  Future<bool> updateQuestionLog(QuestionLog log) =>
      update(questionLogs).replace(log);

  /// 通过 Companion 更新日志
  Future<int> updateQuestionLogWithCompanion(
    int id,
    QuestionLogsCompanion companion,
  ) => (update(questionLogs)..where((l) => l.id.equals(id))).write(companion);

  /// 删除日志
  Future<int> deleteQuestionLog(int id) =>
      (delete(questionLogs)..where((l) => l.id.equals(id))).go();

  // ==================== QuestionPicsLink 关联操作 ====================

  /// 为题目添加图片关联
  Future<int> addPicToQuestion(int questionId, int picId) => into(
    questionPicsLink,
  ).insert(QuestionPicsLinkCompanion.insert(questionId: questionId, picId: picId));

  /// 移除题目的图片关联
  Future<int> removePicFromQuestion(int questionId, int picId) => (delete(
    questionPicsLink,
  )..where((l) => l.questionId.equals(questionId) & l.picId.equals(picId))).go();

  /// 获取题目关联的所有图片
  Future<List<Image>> getPicsByQuestionId(int questionId) {
    final query = select(images).join([
      innerJoin(questionPicsLink, questionPicsLink.picId.equalsExp(images.id)),
    ])..where(questionPicsLink.questionId.equals(questionId));

    return query.map((row) => row.readTable(images)).get();
  }

  /// 获取题目关联的所有图片 ID
  Future<List<int>> getPicIdsByQuestionId(int questionId) => (select(
    questionPicsLink,
  )..where((l) => l.questionId.equals(questionId))).map((l) => l.picId).get();

  // ==================== QuestionsTagLink 关联操作 ====================

  /// 为题目添加标签关联
  Future<int> addTagToQuestion(int questionId, int tagId) => into(
    questionsTagLink,
  ).insert(QuestionsTagLinkCompanion.insert(questionID: questionId, tagID: tagId));

  /// 移除题目的标签关联
  Future<int> removeTagFromQuestion(int questionId, int tagId) => (delete(
    questionsTagLink,
  )..where((l) => l.questionID.equals(questionId) & l.tagID.equals(tagId))).go();

  /// 获取题目关联的所有标签
  Future<List<Tag>> getTagsByQuestionId(int questionId) {
    final query = select(tags).join([
      innerJoin(questionsTagLink, questionsTagLink.tagID.equalsExp(tags.id)),
    ])..where(questionsTagLink.questionID.equals(questionId));

    return query.map((row) => row.readTable(tags)).get();
  }

  /// 获取题目关联的所有标签 ID
  Future<List<int>> getTagIdsByQuestionId(int questionId) => (select(
    questionsTagLink,
  )..where((l) => l.questionID.equals(questionId))).map((l) => l.tagID).get();

  /// 根据标签 ID 查询关联的题目
  Future<List<Question>> getQuestionsByTagId(int tagId) {
    final query = select(questions).join([
      innerJoin(
        questionsTagLink,
        questionsTagLink.questionID.equalsExp(questions.id),
      ),
    ])..where(questionsTagLink.tagID.equals(tagId));

    return query.map((row) => row.readTable(questions)).get();
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

  /// 获取题目详情（包含答案、标签、图片）
  /// 返回 Map 包含:
  /// - 'question': Question 对象
  /// - 'answers': List&lt;Answer&gt;
  /// - 'tags': List&lt;Tag&gt;
  /// - 'images': List&lt;Image&gt;
  Future<Map<String, dynamic>?> getQuestionDetail(int questionId) async {
    final question = await getQuestionById(questionId);
    if (question == null) return null;

    return {
      'question': question,
      'answers': await getAnswersByQuestionId(questionId),
      'tags': await getTagsByQuestionId(questionId),
      'images': await getPicsByQuestionId(questionId),
    };
  }

  /// 根据时间范围查询题目
  Future<List<Question>> getQuestionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) =>
      (select(questions)
            ..where(
              (m) =>
                  m.createdAt.isBiggerOrEqualValue(startDate) &
                  m.createdAt.isSmallerOrEqualValue(endDate),
            )
            ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]))
          .get();

  /// 根据多个标签 ID 查询题目（交集）
  /// 返回同时包含所有指定标签的题目
  Future<List<Question>> getQuestionsByTags(List<int> tagIds) async {
    if (tagIds.isEmpty) return [];
    // 查询每个题目匹配的标签数量
    final query = selectOnly(questions)
      ..addColumns([questions.id, questionsTagLink.tagID.count()])
      ..join([
        innerJoin(
          questionsTagLink,
          questionsTagLink.questionID.equalsExp(questions.id),
        ),
      ])
      ..where(questionsTagLink.tagID.isIn(tagIds))
      ..groupBy([questions.id]);
    final results = await query.map((row) {
      return {
        'id': row.read(questions.id)!,
        'count': row.read(questionsTagLink.tagID.count())!,
      };
    }).get();
    // 在 Dart 层过滤：只保留匹配所有标签的题目
    final questionIds = results
        .where((r) => r['count'] == tagIds.length)
        .map((r) => r['id'] as int)
        .toList();
    if (questionIds.isEmpty) return [];
    return (select(questions)..where((m) => m.id.isIn(questionIds))).get();
  }
  // ==================== QuestionAnalysis CRUD ====================

  /// 创建或更新错因分析
  Future<int> upsertQuestionAnalysis(QuestionAnalysisCompanion entry) =>
      into(questionAnalysis).insert(entry, mode: InsertMode.replace);

  /// 获取错因分析
  Future<QuestionAnalysi?> getQuestionAnalysis(int questionId) => (select(
    questionAnalysis,
  )..where((t) => t.id.equals(questionId))).getSingleOrNull();

  /// 删除错因分析
  Future<int> deleteQuestionAnalysis(int questionId) =>
      (delete(questionAnalysis)..where((t) => t.id.equals(questionId))).go();

  // ==================== QuestionKnowledgeLink 关联操作 ====================

  /// 关联知识点
  Future<void> linkKnowledgeToQuestion(int questionId, int knowledgeId) =>
      into(questionKnowledgeLink).insert(
        QuestionKnowledgeLinkCompanion.insert(
          questionId: questionId,
          knowledgeId: knowledgeId,
        ),
        mode: InsertMode.insertOrIgnore, // 忽略已存在的关联
      );

  /// 取消关联知识点
  Future<int> unlinkKnowledgeFromQuestion(int questionId, int knowledgeId) =>
      (delete(questionKnowledgeLink)..where(
            (t) =>
                t.questionId.equals(questionId) &
                t.knowledgeId.equals(knowledgeId),
          ))
          .go();

  /// 获取题目关联的所有知识点
  Future<List<KnowledgeData>> getKnowledgeByQuestionId(int questionId) {
    final query = select(knowledge).join([
      innerJoin(
        questionKnowledgeLink,
        questionKnowledgeLink.knowledgeId.equalsExp(knowledge.id),
      ),
    ])..where(questionKnowledgeLink.questionId.equals(questionId));

    return query.map((row) => row.readTable(knowledge)).get();
  }

  /// 获取题目关联的所有知识点 ID
  Future<List<int>> getKnowledgeIdsByQuestionId(int questionId) =>
      (select(questionKnowledgeLink)
            ..where((l) => l.questionId.equals(questionId)))
          .map((l) => l.knowledgeId)
          .get();

  /// 删除题目的所有知识点关联
  Future<int> deleteKnowledgeLinksByQuestionId(int questionId) =>
      (delete(questionKnowledgeLink)..where((l) => l.questionId.equals(questionId)))
          .go();
}
