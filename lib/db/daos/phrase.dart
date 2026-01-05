import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_english.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';

part 'phrase.g.dart';

@DriftAccessor(tables: [Phrases, PhrasesTagLink, Words, Tags, PhraseLogs])
class PhrasesDao extends DatabaseAccessor<AppDatabase> with _$PhrasesDaoMixin {
  PhrasesDao(super.db);

  // 创建短语
  Future<int> createPhrase(PhrasesCompanion entry) =>
      into(phrases).insert(entry);

  // 全匹配获取短语
  Future<Phrase?> getPhrase(String phrase) {
    return (select(phrases)
          ..where((p) => p.phrase.equals(phrase))
          ..limit(1))
        .getSingleOrNull();
  }

  // 获取所有短语
  Future<List<Phrase>> getAllPhrases() => select(phrases).get();

  // 根据ID获取短语
  Future<Phrase?> getPhraseById(int id) {
    return (select(phrases)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  // 根据单词ID获取所有短语
  Future<List<Phrase>> getPhrasesByWordId(int wordId) {
    return (select(phrases)..where((p) => p.wordID.equals(wordId))).get();
  }

  // 搜索短语（根据短语内容或释义）
  Future<List<Phrase>> searchPhrases(String query) {
    return (select(phrases)..where(
          (p) => p.phrase.like('%$query%') | p.definition.like('%$query%'),
        ))
        .get();
  }

  // 更新短语
  Future<bool> updatePhrase(Phrase phrase) => update(phrases).replace(phrase);

  // 删除短语
  Future<int> deletePhrase(int id) =>
      (delete(phrases)..where((p) => p.id.equals(id))).go();

  // 为短语添加标签
  Future<int> addTagToPhrase(int phraseId, int tagId) =>
      into(phrasesTagLink).insert(
        PhrasesTagLinkCompanion(phraseID: Value(phraseId), tagID: Value(tagId)),
      );

  // 移除短语的标签
  Future<int> removeTagFromPhrase(int phraseId, int tagId) =>
      (delete(phrasesTagLink)..where(
            (link) => link.phraseID.equals(phraseId) & link.tagID.equals(tagId),
          ))
          .go();

  // 获取短语的所有标签
  Future<List<Tag>> getPhraseTags(int phraseId) {
    final query = select(tags).join([
      innerJoin(phrasesTagLink, phrasesTagLink.tagID.equalsExp(tags.id)),
    ])..where(phrasesTagLink.phraseID.equals(phraseId));

    return query.map((row) => row.readTable(tags)).get();
  }

  // 获取带有特定标签的所有短语
  Future<List<Phrase>> getPhrasesByTag(int tagId) {
    final query = select(phrases).join([
      innerJoin(phrasesTagLink, phrasesTagLink.phraseID.equalsExp(phrases.id)),
    ])..where(phrasesTagLink.tagID.equals(tagId));

    return query.map((row) => row.readTable(phrases)).get();
  }

  // 获取短语及其关联的单词（联合查询）
  Future<Map<Phrase, Word>> getPhraseWithWord(int phraseId) async {
    final query = select(phrases).join([
      innerJoin(words, words.id.equalsExp(phrases.wordID)),
    ])..where(phrases.id.equals(phraseId));

    final result = await query.getSingleOrNull();
    if (result == null) return {};

    return {result.readTable(phrases): result.readTable(words)};
  }

  // 获取单词的所有短语及标签（复杂查询示例）
  Future<List<Map<String, dynamic>>> getWordPhrasesWithTags(int wordId) async {
    final phrasesForWord = await getPhrasesByWordId(wordId);

    final result = <Map<String, dynamic>>[];
    for (final phrase in phrasesForWord) {
      final tags = await getPhraseTags(phrase.id);
      result.add({'phrase': phrase, 'tags': tags});
    }

    return result;
  }

  // 使用 companion 更新短语释义
  Future<int> updatePhraseWithCompanion(int id, PhrasesCompanion companion) =>
      (update(phrases)..where((p) => p.id.equals(id))).write(companion);

  // 添加短语日志
  Future<int> addPhraseLog(PhraseLogsCompanion entry) =>
      into(phraseLogs).insert(entry);

  // 获取短语的所有日志
  Future<List<PhraseLog>> getPhraseLogs(int phraseId) =>
      (select(phraseLogs)..where((l) => l.phraseID.equals(phraseId))).get();

  // 获取短语的特定类型日志
  Future<List<PhraseLog>> getPhraseLogsByType(
    int phraseId,
    EnglishLogType type,
  ) =>
      (select(phraseLogs)..where(
            (l) => l.phraseID.equals(phraseId) & l.type.equalsValue(type),
          ))
          .get();
}
