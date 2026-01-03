import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/db/tables/tables_english.dart';
import 'package:fucking_math/utils/db/exceptions.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:fucking_math/utils/db/utils.dart';

import 'package:fucking_math/db/app_database.dart' as db;

class WordsRepository {
  final WordsDao _dao;
  WordsRepository(this._dao);

  // 添加或者更新一个单词
  Future<Word> saveWord(
    String word, {
    String? definitionPreview,
    String? definition,
    List<int>? tags,
    String? note,
  }) async {
    final eword = await _findOrCreateWord(word, definition, definitionPreview);
    await markWordRepeat(eword.id, note: note);
    await _updateWordDefinition(eword.id, definition, definitionPreview);
    if (tags != null && tags.isNotEmpty) {
      await _associateTagsToWord(eword.id, tags);
    }
    return await _buildCompleteWord(eword);
  }

  // 标记一次重复
  Future<void> markWordRepeat(int wordId, {String? note}) async =>
      await _addLog(wordId, LogType.repeat, note: note);

  // 标记一次复习
  Future<void> markWordReview(int wordId, {String? note}) async =>
      await _addLog(wordId, LogType.view, note: note);

  // 标记一次测试
  Future<void> markWordTest(int wordId, {String? note}) async =>
      await _addLog(wordId, LogType.test, note: note);

  // 获取所有单词
  Future<List<Word>> getAllWords() async => Future.wait(
    (await _dao.getAllWords()).map((word) => _buildCompleteWord(word)).toList(),
  );

  // 获取单词的标签
  Future<List<Tag>> getWordTags(int wordId) async =>
      (await _dao.getWordTags(wordId)).map((tag) => dbTagToTag(tag)).toList();

  // 删除单词
  Future<void> deleteWord(int wordId) async => await _dao.deleteWord(wordId);

  // ------ PUBLIC METHODS ABOVE ------

  // 辅助函数: 查找或者创建单词
  Future<db.Word> _findOrCreateWord(
    String word,
    String? def,
    String? defPreview,
  ) async {
    final existingWord = await _dao.getWord(word);
    if (existingWord != null) return existingWord;

    final wordId = await _dao.createWord(
      db.WordsCompanion.insert(
        word: word,
        definition: Value(def),
        definitionPreview: Value(defPreview),
      ),
    );
    final newWord = await _dao.getWordById(wordId);
    if (newWord == null) {
      // 这是一个严重的、不应发生的情况，必须抛出异常
      throw AppDatabaseException(
        'Database consistency error: Failed to retrieve word with id $wordId immediately after creation.',
      );
    }
    return newWord;
  }

  // 辅助函数: 更新单词的定义和预览
  Future<void> _updateWordDefinition(
    int wordId,
    String? def,
    String? defPreview,
  ) async {
    if (def == null && defPreview == null) return;

    final companion = db.WordsCompanion(
      definition: def != null ? Value(def) : Value.absent(),
      definitionPreview: defPreview != null
          ? Value(defPreview)
          : Value.absent(),
    );

    await _dao.updateWordWithCompanion(wordId, companion);
  }

  // 辅助函数: 关联标签到单词
  Future<void> _associateTagsToWord(int wordId, List<int> tagIds) async {
    final futures = tagIds.map((tagId) async {
      try {
        await _dao.addTagToWord(wordId, tagId);
      } on SqliteException catch (e) {
        switch (e.extendedResultCode) {
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_UNIQUE:
            return;
          case sqlite.SqlExtendedError.SQLITE_CONSTRAINT_FOREIGNKEY:
            throw TagOrWordNotFoundException(
              e.message,
              tagID: tagId,
              wordId: wordId,
            );
          default:
            rethrow;
        }
      }
    });

    await Future.wait(futures);
  }

  // 辅助函数: 添加日志
  Future<void> _addLog(int wordId, LogType type, {String? note}) async =>
      await _dao.addWordLog(
        db.WordLogsCompanion.insert(
          wordID: wordId,
          type: type,
          notes: Value(note),
        ),
      );

  // 辅助函数: 构建完整的 Word 对象
  Future<Word> _buildCompleteWord(db.Word word) async {
    final dbTags = await _dao.getWordTags(word.id);
    final appTags = dbTags.map(dbTagToTag).toList();
    final logs = await _dao.getWordLogs(word.id);
    final note = logs.first.notes;
    final repeat = logs.where((log) => log.type == LogType.repeat).length;

    return _dbWordToWord(word, appTags, repeat: repeat, note: note);
  }

  // 辅助函数: 数据库 Word 转换为应用 Word
  Word _dbWordToWord(
    db.Word dbWord,
    List<Tag> tags, {
    int? repeat,
    String? note,
  }) => Word(
    id: dbWord.id,
    word: dbWord.word,
    definition: dbWord.definition,
    definitionPreview: dbWord.definitionPreview,
    tags: tags,
    repeatCount: repeat ?? 0,
    note: note,
  );
}
