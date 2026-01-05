import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_english.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';

part 'word.g.dart';

@DriftAccessor(tables: [Words, WordLogs, WordTagLink, Tags])
class WordsDao extends DatabaseAccessor<AppDatabase> with _$WordsDaoMixin {
  WordsDao(super.db);

  // 创建单词
  Future<int> createWord(WordsCompanion entry) => into(words).insert(entry);

  // 获取所有单词
  Future<List<Word>> getAllWords() => select(words).get();

  // 根据ID获取单词
  Future<Word?> getWordById(int id) {
    return (select(words)..where((w) => w.id.equals(id))).getSingleOrNull();
  }

  // 根据单词文本搜索
  Future<List<Word>> searchWords(String query) {
    return (select(words)..where((w) => w.word.like('%$query%'))).get();
  }

  // 根据单词文本获取单词
  Future<Word?> getWord(String word) {
    return (select(words)
          ..where((filter) => filter.word.equals(word))
          ..limit(1))
        .getSingleOrNull();
  }

  // 更新单词
  Future<bool> updateWord(Word word) => update(words).replace(word);

  // 使用 companion 更新单词
  Future<int> updateWordWithCompanion(int id, WordsCompanion companion) =>
      (update(words)..where((w) => w.id.equals(id))).write(companion);

  // 删除单词
  Future<int> deleteWord(int id) {
    return (delete(words)..where((w) => w.id.equals(id))).go();
  }

  // 添加单词日志
  Future<int> addWordLog(WordLogsCompanion entry) =>
      into(wordLogs).insert(entry);

  // 获取单词的所有日志
  Future<List<WordLog>> getWordLogs(int wordId) =>
      (select(wordLogs)..where((l) => l.wordID.equals(wordId))).get();

  // 获取单词的特定类型日志
  Future<List<WordLog>> getWordLogsByType(int wordId, EnglishLogType type) =>
      (select(wordLogs)
            ..where((l) => l.wordID.equals(wordId) & l.type.equalsValue(type)))
          .get();

  // 为单词添加标签
  Future<int> addTagToWord(int wordId, int tagId) {
    return into(
      wordTagLink,
    ).insert(WordTagLinkCompanion(wordID: Value(wordId), tagID: Value(tagId)));
  }

  // 移除单词的标签
  Future<int> removeTagFromWord(int wordId, int tagId) {
    return (delete(wordTagLink)..where(
          (link) => link.wordID.equals(wordId) & link.tagID.equals(tagId),
        ))
        .go();
  }

  // 获取单词的所有标签
  Future<List<Tag>> getWordTags(int wordId) {
    final query = select(tags).join([
      innerJoin(wordTagLink, wordTagLink.tagID.equalsExp(tags.id)),
    ])..where(wordTagLink.wordID.equals(wordId));

    return query.map((row) => row.readTable(tags)).get();
  }

  // 获取带有特定标签的所有单词
  Future<List<Word>> getWordsByTag(int tagId) {
    final query = select(words).join([
      innerJoin(wordTagLink, wordTagLink.wordID.equalsExp(words.id)),
    ])..where(wordTagLink.tagID.equals(tagId));

    return query.map((row) => row.readTable(words)).get();
  }
}
