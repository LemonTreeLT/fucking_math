// lib/db/app_dao.dart
import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables_english.dart' as eng;
import 'package:fucking_math/db/tables_knowledge.dart' as know;
import 'package:fucking_math/db/tables_mistakes.dart' as mist;
import 'package:fucking_math/db/tables_tags.dart' as tag;
import 'package:fucking_math/utils/types.dart' show Subject;

part 'app_dao.g.dart';

// =======================================================
// Tags DAO
// =======================================================
@DriftAccessor(tables: [tag.Tags])
class TagsDao extends DatabaseAccessor<AppDatabase> with _$TagsDaoMixin {
  TagsDao(super.db);

  // 创建标签
  Future<int> createTag(TagsCompanion entry) => into(tags).insert(entry);

  // 获取所有标签
  Future<List<Tag>> getAllTags() => select(tags).get();

  // 根据学科获取标签
  Future<List<Tag>> getTagsBySubject(Subject? subject) {
    return (select(tags)..where((t) => t.subject.equalsValue(subject))).get();
  }

  // 根据ID获取标签
  Future<Tag?> getTagById(int id) {
    return (select(tags)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  // 更新标签
  Future<bool> updateTag(Tag tag) => update(tags).replace(tag);

  // 删除标签
  Future<int> deleteTag(int id) {
    return (delete(tags)..where((t) => t.id.equals(id))).go();
  }
}

// =======================================================
// English Words DAO
// =======================================================
@DriftAccessor(tables: [eng.Words, eng.WordLogs, eng.WordTagLink, tag.Tags])
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
  Future<List<WordLog>> getWordLogsByType(int wordId, eng.LogType type) {
    return (select(
      wordLogs,
    )..where((l) => l.wordID.equals(wordId) & l.type.equalsValue(type))).get();
  }

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

// =======================================================
// Knowledge DAO
// =======================================================
@DriftAccessor(
  tables: [
    know.KnowledgeTable,
    know.KnowledgeLogTable,
    know.KnowledgeTagLink,
    tag.Tags,
  ],
)
class KnowledgeDao extends DatabaseAccessor<AppDatabase>
    with _$KnowledgeDaoMixin {
  KnowledgeDao(super.db);

  // 创建知识点
  Future<int> createKnowledge(KnowledgeTableCompanion entry) =>
      into(knowledgeTable).insert(entry);

  // 获取所有知识点
  Future<List<KnowledgeTableData>> getAllKnowledge() =>
      select(knowledgeTable).get();

  // 根据学科获取知识点
  Future<List<KnowledgeTableData>> getKnowledgeBySubject(Subject subject) {
    return (select(
      knowledgeTable,
    )..where((k) => k.subject.equalsValue(subject))).get();
  }

  // 根据ID获取知识点
  Future<KnowledgeTableData?> getKnowledgeById(int id) {
    return (select(
      knowledgeTable,
    )..where((k) => k.id.equals(id))).getSingleOrNull();
  }

  // 搜索知识点(根据标题和内容)
  Future<List<KnowledgeTableData>> searchKnowledge(String query) {
    return (select(
      knowledgeTable,
    )..where((k) => k.head.like('%$query%') | k.body.like('%$query%'))).get();
  }

  // 更新知识点
  Future<bool> updateKnowledge(KnowledgeTableData knowledge) =>
      update(knowledgeTable).replace(knowledge);

  // 删除知识点
  Future<int> deleteKnowledge(int id) {
    return (delete(knowledgeTable)..where((k) => k.id.equals(id))).go();
  }

  // 添加知识点日志
  Future<int> addKnowledgeLog(KnowledgeLogTableCompanion entry) =>
      into(knowledgeLogTable).insert(entry);

  // 获取知识点的所有日志
  Future<List<KnowledgeLogTableData>> getKnowledgeLogs(int knowledgeId) {
    return (select(
      knowledgeLogTable,
    )..where((l) => l.knowledgeID.equals(knowledgeId))).get();
  }

  // 为知识点添加标签
  Future<int> addTagToKnowledge(int knowledgeId, int tagId) {
    return into(knowledgeTagLink).insert(
      KnowledgeTagLinkCompanion(
        knowledgeID: Value(knowledgeId),
        tagID: Value(tagId),
      ),
    );
  }

  // 移除知识点的标签
  Future<int> removeTagFromKnowledge(int knowledgeId, int tagId) {
    return (delete(knowledgeTagLink)..where(
          (link) =>
              link.knowledgeID.equals(knowledgeId) & link.tagID.equals(tagId),
        ))
        .go();
  }

  // 获取知识点的所有标签
  Future<List<Tag>> getKnowledgeTags(int knowledgeId) {
    final query = select(tags).join([
      innerJoin(knowledgeTagLink, knowledgeTagLink.tagID.equalsExp(tags.id)),
    ])..where(knowledgeTagLink.knowledgeID.equals(knowledgeId));

    return query.map((row) => row.readTable(tags)).get();
  }

  // 获取带有特定标签的所有知识点
  Future<List<KnowledgeTableData>> getKnowledgeByTag(int tagId) {
    final query = select(knowledgeTable).join([
      innerJoin(
        knowledgeTagLink,
        knowledgeTagLink.knowledgeID.equalsExp(knowledgeTable.id),
      ),
    ])..where(knowledgeTagLink.tagID.equals(tagId));

    return query.map((row) => row.readTable(knowledgeTable)).get();
  }
}

// =======================================================
// Mistakes DAO
// =======================================================
@DriftAccessor(
  tables: [mist.Mistakes, mist.MistakesTagLink, mist.MistakeLogs, tag.Tags],
)
class MistakesDao extends DatabaseAccessor<AppDatabase>
    with _$MistakesDaoMixin {
  MistakesDao(super.db);

  // 创建错题
  Future<int> createMistake(MistakesCompanion entry) =>
      into(mistakes).insert(entry);

  // 获取所有错题
  Future<List<Mistake>> getAllMistakes() => select(mistakes).get();

  // 根据学科获取错题
  Future<List<Mistake>> getMistakesBySubject(Subject subject) {
    return (select(
      mistakes,
    )..where((m) => m.subject.equalsValue(subject))).get();
  }

  // 根据ID获取错题
  Future<Mistake?> getMistakeById(int id) {
    return (select(mistakes)..where((m) => m.id.equals(id))).getSingleOrNull();
  }

  // 搜索错题(根据题目标题和内容)
  Future<List<Mistake>> searchMistakes(String query) {
    return (select(mistakes)..where(
          (m) =>
              m.questionHeader.like('%$query%') |
              m.questionBody.like('%$query%'),
        ))
        .get();
  }

  // 更新错题
  Future<bool> updateMistake(Mistake mistake) =>
      update(mistakes).replace(mistake);

  // 删除错题
  Future<int> deleteMistake(int id) {
    return (delete(mistakes)..where((m) => m.id.equals(id))).go();
  }

  // 为错题添加标签
  Future<int> addTagToMistake(int mistakeId, int tagId) {
    return into(mistakesTagLink).insert(
      MistakesTagLinkCompanion(
        mistakeID: Value(mistakeId),
        tagID: Value(tagId),
      ),
    );
  }

  // 移除错题的标签
  Future<int> removeTagFromMistake(int mistakeId, int tagId) {
    return (delete(mistakesTagLink)..where(
          (link) => link.mistakeID.equals(mistakeId) & link.tagID.equals(tagId),
        ))
        .go();
  }

  // 获取错题的所有标签
  Future<List<Tag>> getMistakeTags(int mistakeId) {
    final query = select(tags).join([
      innerJoin(mistakesTagLink, mistakesTagLink.tagID.equalsExp(tags.id)),
    ])..where(mistakesTagLink.mistakeID.equals(mistakeId));

    return query.map((row) => row.readTable(tags)).get();
  }

  // 获取带有特定标签的所有错题
  Future<List<Mistake>> getMistakesByTag(int tagId) {
    final query = select(mistakes).join([
      innerJoin(
        mistakesTagLink,
        mistakesTagLink.mistakeID.equalsExp(mistakes.id),
      ),
    ])..where(mistakesTagLink.tagID.equals(tagId));

    return query.map((row) => row.readTable(mistakes)).get();
  }

  // 获取未验证答案的错题
  Future<List<Mistake>> getUnverifiedMistakes() {
    return (select(mistakes)..where(
          (m) => m.unvifiedAnswer.isNotNull() & m.correctAnswer.isNull(),
        ))
        .get();
  }

  // 为错题添加日志
  Future<int> addMistakeLog(MistakeLogsCompanion entry) =>
      into(mistakeLogs).insert(entry);

  // 获取错题的所有日志
  Future<List<MistakeLog>> getMistakeLogs(int mistakeId) =>
      (select(mistakeLogs)..where((l) => l.mistakeID.equals(mistakeId))).get();
}

// =======================================================
// Phrases DAO
// =======================================================
@DriftAccessor(
  tables: [
    eng.Phrases,
    eng.PhrasesTagLink,
    eng.Words,
    tag.Tags,
    eng.PhraseLogs,
  ],
)
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
  Future<int> deletePhrase(int id) {
    return (delete(phrases)..where((p) => p.id.equals(id))).go();
  }

  // 为短语添加标签
  Future<int> addTagToPhrase(int phraseId, int tagId) {
    return into(phrasesTagLink).insert(
      PhrasesTagLinkCompanion(phraseID: Value(phraseId), tagID: Value(tagId)),
    );
  }

  // 移除短语的标签
  Future<int> removeTagFromPhrase(int phraseId, int tagId) {
    return (delete(phrasesTagLink)..where(
          (link) => link.phraseID.equals(phraseId) & link.tagID.equals(tagId),
        ))
        .go();
  }

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
  Future<List<PhraseLog>> getPhraseLogs(int phraseId) {
    return (select(
      phraseLogs,
    )..where((l) => l.phraseID.equals(phraseId))).get();
  }

  // 获取短语的特定类型日志
  Future<List<PhraseLog>> getPhraseLogsByType(int phraseId, eng.LogType type) {
    return (select(
          phraseLogs,
        )..where((l) => l.phraseID.equals(phraseId) & l.type.equalsValue(type)))
        .get();
  }
}
