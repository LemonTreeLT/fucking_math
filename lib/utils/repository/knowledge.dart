import 'package:drift/drift.dart';
import 'package:fucking_math/db/daos/knowledge.dart' show KnowledgeDao;
import 'package:fucking_math/utils/repository/helper/exceptions.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:fucking_math/utils/repository/helper/utils.dart';

import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/db/tables/tables_knowledge.dart' as know;

class KnowledgeRepository {
  final KnowledgeDao _dao;

  KnowledgeRepository(this._dao);

  // 添加或更新知识点
  Future<Knowledge> saveKnowledge(
    Subject subject,
    String head,
    String body, {
    List<int>? tags,
    String? note,
  }) async {
    final knowledge = await _findOrCreateKnowledge(subject, head, body);
    await markKnowledgeEdit(knowledge.id, note: note);
    await _updateKnowledgeContent(knowledge.id, head, body);
    if (tags != null && tags.isNotEmpty) {
      await _associateTagsToKnowledge(knowledge.id, tags);
    }
    return await _buildCompleteKnowledge(knowledge);
  }

  // 标记一次编辑
  Future<void> markKnowledgeEdit(int knowledgeId, {String? note}) async =>
      await _addLog(knowledgeId, know.KnowledgeLogType.edit, note: note);

  // 标记一次重复
  Future<void> markKnowledgeRetry(int knowledgeId, {String? note}) async =>
      await _addLog(knowledgeId, know.KnowledgeLogType.retry, note: note);

  // 获取所有知识点
  Future<List<Knowledge>> getAllKnowledge() async => Future.wait(
    (await _dao.getAllKnowledge())
        .map((k) => _buildCompleteKnowledge(k))
        .toList(),
  );

  // 根据学科获取知识点
  Future<List<Knowledge>> getKnowledgeBySubject(Subject subject) async =>
      Future.wait(
        (await _dao.getKnowledgeBySubject(
          subject,
        )).map((k) => _buildCompleteKnowledge(k)).toList(),
      );

  // 搜索知识点
  Future<List<Knowledge>> searchKnowledge(String query) async => Future.wait(
    (await _dao.searchKnowledge(
      query,
    )).map((k) => _buildCompleteKnowledge(k)).toList(),
  );

  // 获取知识点的标签
  Future<List<Tag>> getKnowledgeTags(int knowledgeId) async =>
      (await _dao.getKnowledgeTags(
        knowledgeId,
      )).map((tag) => dbTagToTag(tag)).toList();

  // 根据标签获取知识点
  Future<List<Knowledge>> getKnowledgeByTag(int tagId) async => Future.wait(
    (await _dao.getKnowledgeByTag(
      tagId,
    )).map((k) => _buildCompleteKnowledge(k)).toList(),
  );

  // 删除知识点
  Future<void> deleteKnowledge(int knowledgeId) async =>
      await _dao.deleteKnowledge(knowledgeId);

  // 根据ID获取单个知识点
  Future<Knowledge?> getKnowledgeById(int id) async {
    final dbKnowledge = await _dao.getKnowledgeById(id);
    if (dbKnowledge == null) return null;
    return await _buildCompleteKnowledge(dbKnowledge);
  }

  // ------ PRIVATE HELPER METHODS BELOW ------

  // 辅助函数: 查找或创建知识点
  Future<db.KnowledgeTableData> _findOrCreateKnowledge(
    Subject subject,
    String head,
    String body,
  ) async {
    // 尝试根据标题和学科查找现有知识点
    final allKnowledge = await _dao.getKnowledgeBySubject(subject);
    final existingKnowledge = allKnowledge
        .cast<db.KnowledgeTableData?>()
        .firstWhere((k) => k?.head == head, orElse: () => null);

    if (existingKnowledge != null) return existingKnowledge;

    // 创建新知识点
    final knowledgeId = await _dao.createKnowledge(
      db.KnowledgeTableCompanion.insert(
        subject: subject,
        head: head,
        body: body,
      ),
    );

    final newKnowledge = await _dao.getKnowledgeById(knowledgeId);
    if (newKnowledge == null) {
      throw AppDatabaseException(
        'Database consistency error: Failed to retrieve knowledge with id $knowledgeId immediately after creation.',
      );
    }
    return newKnowledge;
  }

  // 辅助函数: 更新知识点内容
  Future<void> _updateKnowledgeContent(
    int knowledgeId,
    String head,
    String body,
  ) async {
    final knowledge = await _dao.getKnowledgeById(knowledgeId);
    if (knowledge == null) return;

    // 只有内容变化时才更新
    if (knowledge.head != head || knowledge.body != body) {
      await _dao.updateKnowledge(knowledge.copyWith(head: head, body: body));
    }
  }

  // 辅助函数: 关联标签到知识点
  Future<void> _associateTagsToKnowledge(
    int knowledgeId,
    List<int> tagIds,
  ) async {
    final futures = tagIds.map((tagId) async {
      try {
        await _dao.addTagToKnowledge(knowledgeId, tagId);
      } on sqlite.SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            // 标签已经关联,忽略
            return;
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw TagOrKnowledgeNotFoundException(
              e.message,
              tagID: tagId,
              knowledgeId: knowledgeId,
            );
          default:
            rethrow;
        }
      }
    });

    await Future.wait(futures);
  }

  // 辅助函数: 添加日志
  Future<void> _addLog(
    int knowledgeId,
    know.KnowledgeLogType type, {
    String? note,
  }) async => await _dao.addKnowledgeLog(
    db.KnowledgeLogTableCompanion.insert(
      knowledgeID: knowledgeId,
      type: type,
      notes: Value(note),
    ),
  );

  // 辅助函数: 构建完整的 Knowledge 对象
  Future<Knowledge> _buildCompleteKnowledge(
    db.KnowledgeTableData knowledge,
  ) async {
    final dbTags = await _dao.getKnowledgeTags(knowledge.id);
    final appTags = dbTags.map(dbTagToTag).toList();
    final logs = await _dao.getKnowledgeLogs(knowledge.id);
    final editCount = logs
        .where((log) => log.type == know.KnowledgeLogType.edit)
        .length;
    final lastNote = logs.isNotEmpty ? logs.first.notes : null;

    return _dbKnowledgeToKnowledge(
      knowledge,
      appTags,
      editCount: editCount,
      note: lastNote,
    );
  }

  // 辅助函数: 数据库 Knowledge 转换为应用 Knowledge
  Knowledge _dbKnowledgeToKnowledge(
    db.KnowledgeTableData dbKnowledge,
    List<Tag> tags, {
    int? editCount,
    String? note,
  }) => Knowledge(
    id: dbKnowledge.id,
    subject: dbKnowledge.subject,
    head: dbKnowledge.head,
    body: dbKnowledge.body,
    tags: tags,
    editCount: editCount ?? 0,
    note: note,
    createdAt: dbKnowledge.createdAt,
  );
}
