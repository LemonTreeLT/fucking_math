import 'package:drift/drift.dart';
import 'package:fucking_math/db/daos/question.dart';
import 'package:fucking_math/db/tables/tables_questions.dart'
    show QuestionLogType;
import 'package:fucking_math/utils/repository/helper/exceptions.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:fucking_math/utils/repository/helper/utils.dart';

import 'package:fucking_math/db/app_database.dart' as db;

class QuestionsRepository {
  final QuestionsDao _dao;
  QuestionsRepository(this._dao);

  // ==================== 题目核心方法 ====================

  /// 添加或更新题目
  ///
  /// - [id] 为 null 或 0 时创建新题目,否则更新已有题目
  /// - [tags] 和 [imageIds] 采用追加模式(不删除已有关联)
  /// - [knowledgeIds] 采用替换模式(删除已有关联,重新添加)
  /// - 自动记录日志(创建时为 view,更新时为 view)
  Future<Question> saveQuestion({
    int? id,
    required Subject subject,
    required String head,
    required String body,
    String? source,
    List<int>? tags,
    List<int>? imageIds,
    List<int>? knowledgeIds,
    String? note,
  }) async {
    final question = await _findOrCreateQuestion(id, subject, head, body, source);
    await markQuestionView(question.id, note: note);
    await _updateQuestionContent(question.id, subject, head, body, source);

    if (tags != null && tags.isNotEmpty) {
      await _associateTagsToQuestion(question.id, tags);
    }
    if (imageIds != null && imageIds.isNotEmpty) {
      await _associatePicsToQuestion(question.id, imageIds);
    }
    if (knowledgeIds != null && knowledgeIds.isNotEmpty) {
      await _associateKnowledgesToQuestion(question.id, knowledgeIds);
    }
    return await _buildCompleteQuestion(question);
  }

  /// 标记一次查看
  Future<void> markQuestionView(int questionId, {String? note}) async =>
      await _addLog(questionId, QuestionLogType.view, note: note);

  /// 标记一次复习
  Future<void> markQuestionReview(int questionId, {String? note}) async =>
      await _addLog(questionId, QuestionLogType.review, note: note);

  /// 标记一次重做
  Future<void> markQuestionRepeat(int questionId, {String? note}) async =>
      await _addLog(questionId, QuestionLogType.repeat, note: note);

  /// 标记一次答题
  Future<void> markQuestionAnswer(int questionId, {String? note}) async =>
      await _addLog(questionId, QuestionLogType.answer, note: note);

  /// 获取所有题目
  Future<List<Question>> getAllQuestions() async => Future.wait(
    (await _dao.getAllQuestions()).map((m) => _buildCompleteQuestion(m)).toList(),
  );

  /// 根据 ID 获取题目
  Future<Question?> getQuestionById(int id) async {
    final dbQuestion = await _dao.getQuestionById(id);
    if (dbQuestion == null) return null;
    return await _buildCompleteQuestion(dbQuestion);
  }

  /// 更新题目信息
  ///
  /// - [id] 题目 ID
  /// - [subject] 新学科(可选)
  /// - [head] 新标题(可选)
  /// - [body] 新内容(可选)
  /// - [source] 新来源(可选)
  ///
  /// 抛出 [TagOrQuestionNotFoundException] 当题目不存在时
  Future<Question> updateQuestion({
    required int id,
    Subject? subject,
    String? head,
    String? body,
    String? source,
  }) async {
    final existingQuestion = await _dao.getQuestionById(id);
    if (existingQuestion == null) {
      throw TagOrQuestionNotFoundException(
        'Question with id $id not found',
        questionId: id,
      );
    }

    final companion = db.QuestionsCompanion(
      subject: subject != null ? Value(subject) : Value.absent(),
      questionHeader: head != null ? Value(head) : Value.absent(),
      questionBody: body != null ? Value(body) : Value.absent(),
      source: source != null ? Value(source) : Value.absent(),
    );

    await _dao.updateQuestionWithCompanion(id, companion);
    final updatedQuestion = await _dao.getQuestionById(id);
    return await _buildCompleteQuestion(updatedQuestion!);
  }

  /// 删除题目(级联删除所有关联数据)
  Future<void> deleteQuestion(int questionId) async =>
      await _dao.deleteQuestion(questionId);

  /// 分配一个题目id
  /// 查找是否存在为空的条目否则创建新的
  Future<int> assignID() async => _dao.assignID();

  // ==================== 题目关联管理 ====================

  /// 移除题目的图片关联
  Future<void> removePicsFromQuestion(int questionId, List<int> picIds) async {
    final futures = picIds.map(
      (picId) async => await _dao.removePicFromQuestion(questionId, picId),
    );
    await Future.wait(futures);
  }

  /// 移除题目的标签关联
  Future<void> removeTagsFromQuestion(int questionId, List<int> tagIds) async {
    final futures = tagIds.map(
      (tagId) async => await _dao.removeTagFromQuestion(questionId, tagId),
    );
    await Future.wait(futures);
  }

  /// 获取题目的标签
  Future<List<Tag>> getQuestionTags(int questionId) async =>
      (await _dao.getTagsByQuestionId(
        questionId,
      )).map((tag) => dbTagToTag(tag)).toList();

  /// 获取题目的图片
  Future<List<ImageStorage>> getQuestionImages(int questionId) async =>
      (await _dao.getPicsByQuestionId(
        questionId,
      )).map((img) => dbImageToImageStorage(img)).toList();

  /// 获取题目的相关知识点
  Future<List<Knowledge>> getQuestionKnowledge(int questionId) async {
    final knowledgeList = await _dao.getKnowledgeByQuestionId(questionId);
    return knowledgeList
        .map((k) => dbKnowledgeToKnowledge(k, const []))
        .toList();
  }

  // ==================== 答案管理 ====================

  /// 添加或更新答案
  ///
  /// - [id] 为 null 或 0 时创建新答案,否则更新已有答案
  /// - [tags] 和 [imageIds] 采用追加模式
  Future<Answer> saveAnswer({
    required int questionId,
    required String body,
    int? id,
    String? head,
    String? note,
    String? source,
    List<int>? tags,
    List<int>? imageIds,
  }) async {
    final answer = await _findOrCreateAnswer(
      id,
      questionId,
      head,
      body,
      note,
      source,
    );
    await _updateAnswerContent(answer.id, head, body, note);

    if (tags != null && tags.isNotEmpty) {
      await _associateTagsToAnswer(answer.id, tags);
    }
    if (imageIds != null && imageIds.isNotEmpty) {
      await _associatePicsToAnswer(answer.id, imageIds);
    }

    return await _buildCompleteAnswer(answer);
  }

  /// 获取某个题目的所有答案
  Future<List<Answer>> getAnswersByQuestionId(int questionId) async =>
      Future.wait(
        (await _dao.getAnswersByQuestionId(
          questionId,
        )).map((a) => _buildCompleteAnswer(a)).toList(),
      );

  /// 更新答案信息
  ///
  /// - [id] 答案 ID
  /// - [head] 新标题(可选)
  /// - [body] 新内容(可选)
  /// - [note] 新备注(可选)
  /// - [source] 新来源(可选)
  ///
  /// 抛出 [AppDatabaseException] 当答案不存在时
  Future<Answer> updateAnswer({
    required int id,
    String? head,
    String? body,
    String? note,
    String? source,
  }) async {
    final existingAnswer = await _dao.getAnswerById(id);
    if (existingAnswer == null) {
      throw AppDatabaseException('Answer with id $id not found');
    }

    final companion = db.AnswersCompanion(
      head: head != null ? Value(head) : Value.absent(),
      answer: body != null ? Value(body) : Value.absent(),
      note: note != null ? Value(note) : Value.absent(),
      source: source != null ? Value(source) : Value.absent(),
    );

    await _dao.updateAnswerWithCompanion(id, companion);
    final updatedAnswer = await _dao.getAnswerById(id);
    return await _buildCompleteAnswer(updatedAnswer!);
  }

  /// 删除答案(级联删除关联数据)
  Future<void> deleteAnswer(int answerId) async =>
      await _dao.deleteAnswer(answerId);

  /// 移除答案的图片关联
  Future<void> removePicsFromAnswer(int answerId, List<int> picIds) async {
    final futures = picIds.map(
      (picId) async => await _dao.removePicFromAnswer(answerId, picId),
    );
    await Future.wait(futures);
  }

  /// 移除答案的标签关联
  Future<void> removeTagsFromAnswer(int answerId, List<int> tagIds) async {
    final futures = tagIds.map(
      (tagId) async => await _dao.removeTagFromAnswer(answerId, tagId),
    );
    await Future.wait(futures);
  }

  /// 获取答案的标签
  Future<List<Tag>> getAnswerTags(int answerId) async =>
      (await _dao.getTagsByAnswerId(
        answerId,
      )).map((tag) => dbTagToTag(tag)).toList();

  // ==================== 高级查询 ====================

  /// 根据学科获取题目
  Future<List<Question>> getQuestionsBySubject(Subject subject) async =>
      Future.wait(
        (await _dao.getQuestionsBySubject(
          subject,
        )).map((m) => _buildCompleteQuestion(m)).toList(),
      );

  /// 模糊搜索题目
  Future<List<Question>> searchQuestions(String keyword) async => Future.wait(
    (await _dao.searchQuestions(
      keyword,
    )).map((m) => _buildCompleteQuestion(m)).toList(),
  );

  /// 分页查询题目
  Future<List<Question>> getQuestionsPaginated(int limit, int offset) async =>
      Future.wait(
        (await _dao.getQuestionsPaginated(
          limit,
          offset,
        )).map((m) => _buildCompleteQuestion(m)).toList(),
      );

  /// 根据时间范围查询题目
  Future<List<Question>> getQuestionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async => Future.wait(
    (await _dao.getQuestionsByDateRange(
      startDate,
      endDate,
    )).map((m) => _buildCompleteQuestion(m)).toList(),
  );

  /// 根据多个标签 ID 查询题目(交集)
  Future<List<Question>> getQuestionsByTags(List<int> tagIds) async =>
      Future.wait(
        (await _dao.getQuestionsByTags(
          tagIds,
        )).map((m) => _buildCompleteQuestion(m)).toList(),
      );

  // ==================== PRIVATE HELPER METHODS ====================

  /// Find or create a question based on id
  /// - If id is null or 0, create new question
  /// - Otherwise, fetch existing question by id
  ///   - If the specified question with id can not be found,
  ///   - Create a new question
  Future<db.Question> _findOrCreateQuestion(
    int? id,
    Subject subject,
    String head,
    String body,
    String? source,
  ) async {
    if (id != null && id > 0) {
      final existing = await _dao.getQuestionById(id);
      if (existing != null) return existing;
    }

    // Create new question
    final questionId = await _dao.createQuestion(
      db.QuestionsCompanion.insert(
        id: (id != null && id > 0) ? Value(id) : const Value.absent(),
        subject: subject,
        questionHeader: head,
        questionBody: body,
        source: Value(source),
      ),
    );

    final newQuestion = await _dao.getQuestionById(questionId);
    if (newQuestion == null) {
      throw AppDatabaseException(
        'Database consistency error: Failed to retrieve question with id $questionId immediately after creation.',
      );
    }
    return newQuestion;
  }

  /// Update question content (only if changed)
  Future<void> _updateQuestionContent(
    int questionId,
    Subject subject,
    String head,
    String body,
    String? source,
  ) async {
    final question = await _dao.getQuestionById(questionId);
    if (question == null) return;

    if (question.subject != subject ||
        question.questionHeader != head ||
        question.questionBody != body ||
        question.source != source) {
      await _dao.updateQuestion(
        question.copyWith(
          subject: subject,
          questionHeader: head,
          questionBody: body,
          source: Value(source),
        ),
      );
    }
  }

  /// Associate tags to question (append mode, ignore duplicates)
  Future<void> _associateTagsToQuestion(int questionId, List<int> tagIds) async {
    final futures = tagIds.map((tagId) async {
      try {
        await _dao.addTagToQuestion(questionId, tagId);
      } on sqlite.SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            return; // Already associated, ignore
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw TagOrQuestionNotFoundException(
              e.message,
              tagID: tagId,
              questionId: questionId,
            );
          default:
            rethrow;
        }
      }
    });
    await Future.wait(futures);
  }

  /// Associate pictures to question (append mode, ignore duplicates)
  Future<void> _associatePicsToQuestion(int questionId, List<int> picIds) async {
    final futures = picIds.map((picId) async {
      try {
        await _dao.addPicToQuestion(questionId, picId);
      } on sqlite.SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            return; // Already associated, ignore
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw ImageOrQuestionNotFoundException(
              e.message,
              imageId: picId,
              questionId: questionId,
            );
          default:
            rethrow;
        }
      }
    });
    await Future.wait(futures);
  }

  /// Associate knowledge to question (replace mode, clear existing then add new)
  Future<void> _associateKnowledgesToQuestion(
    int questionId,
    List<int> knowledgeIds,
  ) async {
    // Clear existing knowledge links
    await _dao.deleteKnowledgeLinksByQuestionId(questionId);

    // Add new knowledge links
    final futures = knowledgeIds.map((knowledgeId) async {
      try {
        await _dao.linkKnowledgeToQuestion(questionId, knowledgeId);
      } on sqlite.SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            return; // Already associated, ignore
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw KnowledgeOrQuestionNotFoundException(
              e.message,
              knowledgeId: knowledgeId,
              questionId: questionId,
            );
          default:
            rethrow;
        }
      }
    });
    await Future.wait(futures);
  }

  Future<void> _addLog(
    int questionId,
    QuestionLogType type, {
    String? note,
  }) async => await _dao.createQuestionLog(
    db.QuestionLogsCompanion.insert(
      questionID: questionId,
      type: type,
      notes: Value(note),
    ),
  );

  /// Build complete Question object with all associations
  Future<Question> _buildCompleteQuestion(db.Question question) async {
    // Fetch associations in parallel
    final results = await Future.wait([
      _dao.getLogsByQuestionIdAndType(question.id, QuestionLogType.view),
      _dao.getLogsByQuestionIdAndType(question.id, QuestionLogType.review),
      _dao.getLogsByQuestionIdAndType(question.id, QuestionLogType.repeat),
      _dao.getLogsByQuestionIdAndType(question.id, QuestionLogType.answer),
      _dao.getPicsByQuestionId(question.id),
      _dao.getTagsByQuestionId(question.id),
      _dao.getKnowledgeByQuestionId(question.id),
    ]);

    final state = QuestionState(
      view: results[0].length,
      review: results[1].length,
      repeat: results[2].length,
      answer: results[3].length,
    );

    final images = (results[4] as List<db.Image>)
        .map((img) => dbImageToImageStorage(img))
        .toList();

    final tags = results[5].map((tag) => dbTagToTag(tag as db.Tag)).toList();

    final knowledge = (results[6] as List<db.KnowledgeData>)
        .map((k) => dbKnowledgeToKnowledge(k, []))
        .toList();

    final latest = await _dao.getQuestionById(question.id);

    return dbQuestionToQuestion(latest!, state, images, tags, knowledge);
  }

  /// Find or create an answer based on id
  Future<db.Answer> _findOrCreateAnswer(
    int? id,
    int questionId,
    String? head,
    String body,
    String? note,
    String? source,
  ) async {
    if (id != null && id > 0) {
      final existing = await _dao.getAnswerById(id);
      if (existing != null) return existing;
      throw AppDatabaseException(
        'Answer with id $id not found for update operation.',
      );
    }

    // Create new answer
    final answerId = await _dao.createAnswer(
      db.AnswersCompanion.insert(
        questionId: questionId,
        answer: body,
        head: Value(head),
        note: Value(note),
        source: Value(source),
      ),
    );

    final newAnswer = await _dao.getAnswerById(answerId);
    if (newAnswer == null) {
      throw AppDatabaseException(
        'Database consistency error: Failed to retrieve answer with id $answerId immediately after creation.',
      );
    }
    return newAnswer;
  }

  /// Update answer content (only if changed)
  Future<void> _updateAnswerContent(
    int answerId,
    String? head,
    String body,
    String? note,
  ) async {
    final answer = await _dao.getAnswerById(answerId);
    if (answer == null) return;

    if (answer.head != head || answer.answer != body || answer.note != note) {
      await _dao.updateAnswer(
        answer.copyWith(head: Value(head), answer: body, note: Value(note)),
      );
    }
  }

  /// Associate tags to answer (append mode, ignore duplicates)
  Future<void> _associateTagsToAnswer(int answerId, List<int> tagIds) async {
    final futures = tagIds.map((tagId) async {
      try {
        await _dao.addTagToAnswer(answerId, tagId);
      } on sqlite.SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            return; // Already associated, ignore
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw TagOrAnswerNotFoundException(
              e.message,
              tagID: tagId,
              answerId: answerId,
            );
          default:
            rethrow;
        }
      }
    });
    await Future.wait(futures);
  }

  /// Associate pictures to answer (append mode, ignore duplicates)
  Future<void> _associatePicsToAnswer(int answerId, List<int> picIds) async {
    final futures = picIds.map((picId) async {
      try {
        await _dao.addPicToAnswer(answerId, picId);
      } on sqlite.SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            return; // Already associated, ignore
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw ImageOrAnswerNotFoundException(
              e.message,
              imageId: picId,
              answerId: answerId,
            );
          default:
            rethrow;
        }
      }
    });
    await Future.wait(futures);
  }

  /// Build complete Answer object with all associations
  Future<Answer> _buildCompleteAnswer(db.Answer answer) async {
    final results = await Future.wait([
      _dao.getTagsByAnswerId(answer.id),
      _dao.getPicsByAnswerId(answer.id),
    ]);

    final tags = (results[0] as List<db.Tag>)
        .map((tag) => dbTagToTag(tag))
        .toList();

    final images = (results[1] as List<db.Image>)
        .map((img) => dbImageToImageStorage(img))
        .toList();

    return dbAnswerToAnswer(answer, tags, images);
  }
}
