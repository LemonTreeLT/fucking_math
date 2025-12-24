import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/db/tables_english.dart';
import 'package:fucking_math/utils/types.dart';

import 'package:fucking_math/db/app_database.dart' as db;

class WordsRepository {
  final WordsDao _dao;
  WordsRepository(this._dao);

  // 添加或者更新一个单词
  Future<void> saveWord(
    String word, {
    String? definitionPreview,
    String? definition,
    List<int>? tags,
    String? note,
  }) async {
    // 查询是否已存在
    final eword = await _dao.getWord(word);
    if (eword != null) {
      await _dao.addWordLog(
        db.WordLogsCompanion.insert(
          wordID: eword.id,
          type: LogType.repeat,
          notes: Value(note),
        ),
      );
      // 补充tag
      final tags = (await _dao.getWordTags(eword.id)).map((e) => e.id).toList();
      for (var tagId in tags) {
        try {
          _dao.addTagToWord(eword.id, tagId);
        } on SqliteException catch (e) {
          if (e.message.contains("FOREIGN KEY constraint failed")) {
            throw Exception('无法关联：标签或单词不存在。');
          } else if (e.message.contains("UNIQUE constraint failed")) {
            break; // 已存在该关联，跳过
          }
        }
      }

      if (definition == null && definitionPreview == null) return; // 无需更新

      final wordUnsaved = db.Word(
        id: eword.id,
        word: eword.word,
        definition: definition ?? eword.definition,
        definitionPreview: definitionPreview ?? eword.definitionPreview,
        createdAt: eword.createdAt,
      );

      await _dao.updateWord(wordUnsaved);
      return;
    } else {
      // 不存在单词

      // 创建单词
      int wordId = await _dao.createWord(
        db.WordsCompanion.insert(
          word: word,
          definition: Value(definition),
          definitionPreview: Value(definitionPreview),
        ),
      );

      // 创建日志
      await _dao.addWordLog(
        db.WordLogsCompanion.insert(
          wordID: wordId,
          type: LogType.repeat,
          notes: Value(note),
        ),
      );

      // 关联标签
      if (tags != null && tags.isNotEmpty) {
        final tagFutures = tags.map((tagId) {
          return _dao.addTagToWord(wordId, tagId);
        }).toList();
        await Future.wait(tagFutures);
      }
    }
  }

  // 标记一次复习
  Future<void> markWordRepeat(int wordId, {String? note}) async {
    await _dao.addWordLog(
      db.WordLogsCompanion.insert(
        wordID: wordId,
        type: LogType.view,
        notes: Value(note),
      ),
    );
  }

  // 标记一次测试
  Future<void> markWordTest(int wordId, {String? note}) async {
    await _dao.addWordLog(
      db.WordLogsCompanion.insert(
        wordID: wordId,
        type: LogType.test,
        notes: Value(note),
      ),
    );
  }

  // 获取所有单词
  Future<List<Word>> getAllWords() async {
    final words = await _dao.getAllWords();

    // 空单词库，直接返回
    if (words.isEmpty) return [];

    final List<Future<Word>> wordsFutures = words.map((word) async {
      final List<db.Tag> dbTags = await _dao.getWordTags(word.id);
      final List<Tag> tags = dbTags.map((tag) {
        return (
          name: tag.tag,
          description: tag.description,
          color: tag.color,
          subject: null,
        );
      }).toList();

      return (
        word: word.word,
        wordID: word.id,
        definition: word.definition,
        definitionPreview: word.definitionPreview,
        tags: tags,
      );
    }).toList();

    return await Future.wait(wordsFutures);
  }

  // 获取单词的标签
  Future<List<Tag>> getWordTags(int wordId) async {
    final dbTags = await _dao.getWordTags(wordId);
    return dbTags.map((tag) {
      return (
        name: tag.tag,
        description: tag.description,
        color: tag.color,
        subject: null,
      );
    }).toList();
  }

  // 删除单词
  Future<void> deleteWord(int wordId) async {
    await _dao.deleteWord(wordId);
  }
}
