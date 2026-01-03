import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/db/tables/tables_english.dart';
import 'package:fucking_math/utils/db/exceptions.dart';
import 'package:fucking_math/utils/db/utils.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

class PhraseRepository {
  final PhrasesDao _dao;
  PhraseRepository(this._dao);

  // 添加或者更新一个短语
  Future<Phrase> savePhrase(
    int linkedWordID,
    String phrase, {
    String? definition,
    String? note,
    List<int>? tags,
  }) async {
    final ephrase = await _findOrCreatePhrase(phrase, linkedWordID, definition);
    await markPhraseRepeat(ephrase.id, note: note);
    await _updatePhraseDefinition(ephrase.id, definition);
    if (tags != null && tags.isNotEmpty) {
      await _associateTagsToPhrase(ephrase.id, tags);
    }
    return await _buildCompletePhrase(ephrase);
  }

  // 标记一次重复
  Future<void> markPhraseRepeat(int phraseId, {String? note}) async =>
      await _addLog(phraseId, EnglishLogType.repeat, note: note);

  // 标记一次复习
  Future<void> markPhraseReview(int phraseId, {String? note}) async =>
      await _addLog(phraseId, EnglishLogType.view, note: note);

  // 标记一次测试
  Future<void> markPhraseTest(int phraseId, {String? note}) async =>
      await _addLog(phraseId, EnglishLogType.test, note: note);

  // 一次性获取全部短语
  Future<List<Phrase>> getAllPhrases() async => Future.wait(
    (await _dao.getAllPhrases())
        .map((phrase) => _buildCompletePhrase(phrase))
        .toList(),
  );

  // 删除短语
  Future<void> deletePhrase(int id) async => await _dao.deletePhrase(id);

  // --------- PUBLIC METHODS END ----------

  // 辅助函数: 关联标签到短语
  Future<void> _associateTagsToPhrase(int phraseId, List<int> tagIds) async {
    final futures = tagIds.map((tagId) async {
      try {
        await _dao.addTagToPhrase(phraseId, tagId);
      } on SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            return;
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw TagOrPhraseNotFoundException(
              e.message,
              tagID: tagId,
              phraseID: phraseId,
            );
          default:
            rethrow;
        }
      }
    });

    await Future.wait(futures);
  }

  // 辅助函数: 更新短语的定义
  Future<void> _updatePhraseDefinition(int phraseId, String? def) async =>
      await _dao.updatePhraseWithCompanion(
        phraseId,
        db.PhrasesCompanion(
          definition: def == null ? Value(def) : Value.absent(),
        ),
      );

  // 辅助函数: 查找或者创建短语
  Future<db.Phrase> _findOrCreatePhrase(
    String phrase,
    int linkedWordID,
    String? definition,
  ) async {
    final existingPhrase = await _dao.getPhrase(phrase);
    if (existingPhrase != null) return existingPhrase;

    final phraseId = await _dao.createPhrase(
      db.PhrasesCompanion.insert(
        wordID: linkedWordID,
        phrase: phrase,
        definition: Value(definition),
      ),
    );

    return await _dao.getPhraseById(phraseId) as db.Phrase;
  }

  // 辅助函数: 添加日志
  Future<void> _addLog(int phraseId, EnglishLogType type, {String? note}) async =>
      await _dao.addPhraseLog(
        db.PhraseLogsCompanion.insert(
          phraseID: phraseId,
          type: type,
          notes: Value(note),
        ),
      );

  // 辅助函数: 数据库 Phrase 转换为应用 Phrase
  Phrase _dbPhraseToPhrase(
    db.Phrase dbPhrase,
    List<Tag> tags, {
    String? note,
    int? count,
  }) => Phrase(
    id: dbPhrase.id,
    linkedWordID: dbPhrase.wordID,
    phrase: dbPhrase.phrase,
    definition: dbPhrase.definition,
    tags: tags,
    note: note,
    repeatCount: count ?? 1,
  );

  // 辅助函数: 构建完整的 Phrase 对象
  Future<Phrase> _buildCompletePhrase(db.Phrase phrase) async {
    final logs = await _dao.getPhraseLogs(phrase.id);
    final count = logs.where((l) => l.type == EnglishLogType.repeat).length;
    final note = logs.first.notes;
    return _dbPhraseToPhrase(
      phrase,
      (await _dao.getPhraseTags(phrase.id)).map(dbTagToTag).toList(),
      note: note,
      count: count
    );
  }
}
