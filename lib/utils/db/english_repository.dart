import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/db/tables_english.dart';
import 'package:fucking_math/utils/types.dart';

import 'package:fucking_math/db/app_database.dart' as db;

class WordsRepository {
  final WordsDao _dao;
  WordsRepository(this._dao);

  // 添加一个单词
  Future<void> addWord(
    String word, {
    String? definition,
    List<int>? tags,
  }) async {
    // 查询是否已存在
    final eword = await _dao.getWord(word);
    if (eword != null) {
      await _dao.addWordLog(
        db.WordLogsCompanion.insert(wordID: eword.id, type: LogType.repeat),
      );
      return;
    }

    // 创建单词
    int wordId = await _dao.createWord(
      db.WordsCompanion.insert(word: word, definition: Value(definition)),
    );

    // 关联标签
    if (tags != null && tags.isNotEmpty) {
      final tagFutures = tags.map((tagId) {
        return _dao.addTagToWord(wordId, tagId);
      }).toList();
      await Future.wait(tagFutures);
    }
  }

  // 获取所有单词
  Future<List<WordWithTags>> getAllWords() async {
    final words = await _dao.getAllWords();

    // 空单词库，直接返回
    if (words.isEmpty) return [];

    final List<Future<WordWithTags>> wordsFutures = words.map((word) async {
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
