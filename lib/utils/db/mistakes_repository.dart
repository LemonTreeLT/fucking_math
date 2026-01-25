import 'package:drift/drift.dart';
import 'package:fucking_math/db/daos/mistake.dart';
import 'package:fucking_math/db/tables/tables_mistakes.dart'
    show MistakeLogType;
import 'package:fucking_math/utils/db/exceptions.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:fucking_math/utils/db/utils.dart';

import 'package:fucking_math/db/app_database.dart' as db;

class MistakesRepository {
  final MistakesDao _dao;
  MistakesRepository(this._dao);

  // ==================== 错题核心方法 ====================

  /// 添加或更新错题
  ///
  /// - [id] 为 null 或 0 时创建新错题,否则更新已有错题
  /// - [tags] 和 [imageIds] 采用追加模式(不删除已有关联)
  /// - 自动记录日志(创建时为 view,更新时为 view)
  Future<Mistake> saveMistake({
    int? id,
    required Subject subject,
    required String head,
    required String body,
    String? source,
    List<int>? tags,
    List<int>? imageIds,
    String? note,
  }) async {
    final mistake = await _findOrCreateMistake(id, subject, head, body, source);
    await markMistakeView(mistake.id, note: note);
    await _updateMistakeContent(mistake.id, subject, head, body, source);

    if (tags != null && tags.isNotEmpty) {
      await _associateTagsToMistake(mistake.id, tags);
    }
    if (imageIds != null && imageIds.isNotEmpty) {
      await _associatePicsToMistake(mistake.id, imageIds);
    }

    return await _buildCompleteMistake(mistake);
  }

  /// 标记一次查看
  Future<void> markMistakeView(int mistakeId, {String? note}) async =>
      await _addLog(mistakeId, MistakeLogType.view, note: note);

  /// 标记一次复习
  Future<void> markMistakeReview(int mistakeId, {String? note}) async =>
      await _addLog(mistakeId, MistakeLogType.review, note: note);

  /// 标记一次重做
  Future<void> markMistakeRepeat(int mistakeId, {String? note}) async =>
      await _addLog(mistakeId, MistakeLogType.repeat, note: note);

  /// 标记一次答题
  Future<void> markMistakeAnswer(int mistakeId, {String? note}) async =>
      await _addLog(mistakeId, MistakeLogType.answer, note: note);

  /// 获取所有错题
  Future<List<Mistake>> getAllMistakes() async => Future.wait(
    (await _dao.getAllMistakes()).map((m) => _buildCompleteMistake(m)).toList(),
  );

  /// 根据 ID 获取错题
  Future<Mistake?> getMistakeById(int id) async {
    final dbMistake = await _dao.getMistakeById(id);
    if (dbMistake == null) return null;
    return await _buildCompleteMistake(dbMistake);
  }

  /// 删除错题(级联删除所有关联数据)
  Future<void> deleteMistake(int mistakeId) async =>
      await _dao.deleteMistake(mistakeId);

  // ==================== 错题关联管理 ====================

  /// 移除错题的图片关联
  Future<void> removePicsFromMistake(int mistakeId, List<int> picIds) async {
    final futures = picIds.map(
      (picId) async => await _dao.removePicFromMistake(mistakeId, picId),
    );
    await Future.wait(futures);
  }

  /// 移除错题的标签关联
  Future<void> removeTagsFromMistake(int mistakeId, List<int> tagIds) async {
    final futures = tagIds.map(
      (tagId) async => await _dao.removeTagFromMistake(mistakeId, tagId),
    );
    await Future.wait(futures);
  }

  /// 获取错题的标签
  Future<List<Tag>> getMistakeTags(int mistakeId) async =>
      (await _dao.getTagsByMistakeId(
        mistakeId,
      )).map((tag) => dbTagToTag(tag)).toList();

  /// 获取错题的图片
  Future<List<ImageStorage>> getMistakeImages(int mistakeId) async =>
      (await _dao.getPicsByMistakeId(
        mistakeId,
      )).map((img) => dbImageToImageStorage(img)).toList();

  // ==================== 答案管理 ====================

  /// 添加或更新答案
  ///
  /// - [id] 为 null 或 0 时创建新答案,否则更新已有答案
  /// - [tags] 和 [imageIds] 采用追加模式
  Future<Answer> saveAnswer({
    int? id,
    required int mistakeId,
    String? head,
    required String body,
    String? note,
    List<int>? tags,
    List<int>? imageIds,
  }) async {
    final answer = await _findOrCreateAnswer(id, mistakeId, head, body, note);
    await _updateAnswerContent(answer.id, head, body, note);

    if (tags != null && tags.isNotEmpty) {
      await _associateTagsToAnswer(answer.id, tags);
    }
    if (imageIds != null && imageIds.isNotEmpty) {
      await _associatePicsToAnswer(answer.id, imageIds);
    }

    return await _buildCompleteAnswer(answer);
  }

  /// 获取某个错题的所有答案
  Future<List<Answer>> getAnswersByMistakeId(int mistakeId) async =>
      Future.wait(
        (await _dao.getAnswersByMistakeId(
          mistakeId,
        )).map((a) => _buildCompleteAnswer(a)).toList(),
      );

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

  /// 根据学科获取错题
  Future<List<Mistake>> getMistakesBySubject(Subject subject) async =>
      Future.wait(
        (await _dao.getMistakesBySubject(
          subject,
        )).map((m) => _buildCompleteMistake(m)).toList(),
      );

  /// 模糊搜索错题
  Future<List<Mistake>> searchMistakes(String keyword) async => Future.wait(
    (await _dao.searchMistakes(
      keyword,
    )).map((m) => _buildCompleteMistake(m)).toList(),
  );

  /// 分页查询错题
  Future<List<Mistake>> getMistakesPaginated(int limit, int offset) async =>
      Future.wait(
        (await _dao.getMistakesPaginated(
          limit,
          offset,
        )).map((m) => _buildCompleteMistake(m)).toList(),
      );

  /// 根据时间范围查询错题
  Future<List<Mistake>> getMistakesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async => Future.wait(
    (await _dao.getMistakesByDateRange(
      startDate,
      endDate,
    )).map((m) => _buildCompleteMistake(m)).toList(),
  );

  /// 根据多个标签 ID 查询错题(交集)
  Future<List<Mistake>> getMistakesByTags(List<int> tagIds) async =>
      Future.wait(
        (await _dao.getMistakesByTags(
          tagIds,
        )).map((m) => _buildCompleteMistake(m)).toList(),
      );

  // ==================== PRIVATE HELPER METHODS ====================

  /// Find or create a mistake based on id
  /// - If id is null or 0, create new mistake
  /// - Otherwise, fetch existing mistake by id
  Future<db.Mistake> _findOrCreateMistake(
    int? id,
    Subject subject,
    String head,
    String body,
    String? source,
  ) async {
    if (id != null && id > 0) {
      final existing = await _dao.getMistakeById(id);
      if (existing != null) return existing;
      throw AppDatabaseException(
        'Mistake with id $id not found for update operation.',
      );
    }

    // Create new mistake
    final mistakeId = await _dao.createMistake(
      db.MistakesCompanion.insert(
        subject: subject,
        questionHeader: head,
        questionBody: body,
        source: Value(source),
      ),
    );

    final newMistake = await _dao.getMistakeById(mistakeId);
    if (newMistake == null) {
      throw AppDatabaseException(
        'Database consistency error: Failed to retrieve mistake with id $mistakeId immediately after creation.',
      );
    }
    return newMistake;
  }

  /// Update mistake content (only if changed)
  Future<void> _updateMistakeContent(
    int mistakeId,
    Subject subject,
    String head,
    String body,
    String? source,
  ) async {
    final mistake = await _dao.getMistakeById(mistakeId);
    if (mistake == null) return;

    if (mistake.subject != subject ||
        mistake.questionHeader != head ||
        mistake.questionBody != body ||
        mistake.source != source) {
      await _dao.updateMistake(
        mistake.copyWith(
          subject: subject,
          questionHeader: head,
          questionBody: body,
          source: Value(source),
        ),
      );
    }
  }

  /// Associate tags to mistake (append mode, ignore duplicates)
  Future<void> _associateTagsToMistake(int mistakeId, List<int> tagIds) async {
    final futures = tagIds.map((tagId) async {
      try {
        await _dao.addTagToMistake(mistakeId, tagId);
      } on sqlite.SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            return; // Already associated, ignore
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw TagOrMistakeNotFoundException(
              e.message,
              tagID: tagId,
              mistakeId: mistakeId,
            );
          default:
            rethrow;
        }
      }
    });
    await Future.wait(futures);
  }

  /// Associate pictures to mistake (append mode, ignore duplicates)
  Future<void> _associatePicsToMistake(int mistakeId, List<int> picIds) async {
    final futures = picIds.map((picId) async {
      try {
        await _dao.addPicToMistake(mistakeId, picId);
      } on sqlite.SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            return; // Already associated, ignore
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw ImageOrMistakeNotFoundException(
              e.message,
              imageId: picId,
              mistakeId: mistakeId,
            );
          default:
            rethrow;
        }
      }
    });
    await Future.wait(futures);
  }

  /// Add a log entry for a mistake
  Future<void> _addLog(
    int mistakeId,
    MistakeLogType type, {
    String? note,
  }) async => await _dao.createMistakeLog(
    db.MistakeLogsCompanion.insert(
      mistakeID: mistakeId,
      type: type,
      notes: Value(note),
    ),
  );

  /// Build complete Mistake object with all associations
  Future<Mistake> _buildCompleteMistake(db.Mistake mistake) async {
    // Fetch associations in parallel
    final results = await Future.wait([
      _dao.getLogsByMistakeIdAndType(mistake.id, MistakeLogType.view),
      _dao.getLogsByMistakeIdAndType(mistake.id, MistakeLogType.review),
      _dao.getLogsByMistakeIdAndType(mistake.id, MistakeLogType.repeat),
      _dao.getLogsByMistakeIdAndType(mistake.id, MistakeLogType.answer),
      _dao.getPicsByMistakeId(mistake.id),
    ]);

    final state = MistakeState(
      view: results[0].length,
      review: results[1].length,
      repeat: results[2].length,
      answer: results[3].length,
    );

    final images = (results[4] as List<db.Image>)
        .map((img) => dbImageToImageStorage(img))
        .toList();

    return dbMistakeToMistake(mistake, state, images);
  }

  /// Find or create an answer based on id
  Future<db.Answer> _findOrCreateAnswer(
    int? id,
    int mistakeId,
    String? head,
    String body,
    String? note,
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
        mistakeId: mistakeId,
        answer: body,
        head: Value(head),
        note: Value(note),
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
